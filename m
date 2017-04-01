Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7F71FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 00:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754289AbdDAAQ7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 20:16:59 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:32863 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbdDAAQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 20:16:58 -0400
Received: by mail-pg0-f53.google.com with SMTP id x125so84565954pgb.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AIj1a7QroPOku9hi93maEQKfbBgHtIIdNSlPaTueuv8=;
        b=MSTDR11dQzvAaRIibONlfGo7v0JYRuzUhTjsp4XixJdbvX8s+W0Pih9WJvn4+9j2fn
         szvDycnJxcayBZvZna4YQQ4kHK+RmpXWyyV/APzki8AnfmD0hYWC9YHEdhe5F6/hG8l6
         PAyjTbaGl3pM7jeJ2AtwZf9rKOzBa5kbXUDoYRL6aq9EbmuJZiSAC+Df6yDwllK92pvP
         OWtMdPYqGP2h2QKR+z1pM4ukrWFxWnjGNFxI8XVo8j0rfommuXFZ4ni7Z9POeg/T18Hb
         sqJAnOBt+xTAGl/WQaMhCE329i6ejnq9XJrMxlpuxuuQmoWw4AefDOyjWiEbDJnyUwbC
         ErIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIj1a7QroPOku9hi93maEQKfbBgHtIIdNSlPaTueuv8=;
        b=YQCNMYJ64Bm6rZvMSvrBQXqzxued4bwkoFcNO0RoODS6Uws3LglgBwA49/hJly+h8S
         9zGpKhyU5xxZ++N9wGbF60imO/2a1goHTuOd/48AkLPsQgXp1LzysNd16+EqVF+ewQfA
         MxHfRLWLHMaYXTljU23Nv1LbhXjXPXeoaFGaZ+/JRjuWBlWS103Ue5Afi9yY3Gd+DWyX
         exDP3HVq4gCr3aZo+h+Pl9h1IVmPf9MR9+e4YbXmHT4N+8gF8ksIaWifMXs6iSsd1hOQ
         WrrRqT/qxFeOgjlLNJN3zp/Oz0ts3QssfIvGq+g/5o+vLL5NsvTp1zh9D9PZJRBYIQc3
         0t3A==
X-Gm-Message-State: AFeK/H2HuQX0HjXGHYZiXl8exW5/C0rQLyZz12hQ9iXKZiW67FgycYlqb9LJ/NSsZLqEByq7
X-Received: by 10.84.173.228 with SMTP id p91mr6101256plb.18.1491005817556;
        Fri, 31 Mar 2017 17:16:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:6531:bef0:31b8:e5b7])
        by smtp.gmail.com with ESMTPSA id q194sm12509123pfq.43.2017.03.31.17.16.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 17:16:56 -0700 (PDT)
Date:   Fri, 31 Mar 2017 17:16:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] push: unmark a local variable as static
Message-ID: <20170401001655.GB40772@google.com>
References: <20170331231135.195195-1-bmwill@google.com>
 <20170331235623.166408-1-bmwill@google.com>
 <20170331235623.166408-2-bmwill@google.com>
 <20170401001152.GB8741@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170401001152.GB8741@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/31, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> >                         Also, clear the push_options string_list to
> > prevent memory leaking.
> 
> That's not a real leak, right?  Is the motivation to make it not show up
> in valgrind output?

well depends on what you classify as a leak.  I guess since the program
will exit soon its not an issue, but there is still memory that was
alloc'd that wasn't freed before the variable pointing to it went out of
scope. :D
> 
> At first it didn't look related to the other change but then the
> connection dawned on me.
> 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/push.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

-- 
Brandon Williams
