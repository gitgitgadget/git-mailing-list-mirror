Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB071FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 18:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbcIQScc (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 14:32:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36674 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbcIQSca (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 14:32:30 -0400
Received: by mail-lf0-f68.google.com with SMTP id s29so6413267lfg.3
        for <git@vger.kernel.org>; Sat, 17 Sep 2016 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E6p68maXODjtgUjoxS8Rb46rkun/j8SC1iIFL+uUHR8=;
        b=CvNO46FV+HmU8gi6zMKJdEtg3U/Rx4nvZji1+nb25epMXNd8OlGgJI8KZKXxOZjaqe
         7Iw5WrTC93YE8uaF4+e9fbg3P7SEtg42m6MdtPsvIFGBscSM+JL2afCyMF5ibyRQqYlQ
         5+y5ULdxhU72UjbYUxRDPPkpbRNxYvGWb6xBsijIKqI0SQguM9YsSmTqGRmV4J8Ts+5n
         5KM7/ATycvxb+CnPp2tRUlUG5pxerphOc99QU4B4BSHy/OUTt9KQxnDMJn/U/VgFpi6M
         KrWK3W0ULmdB8P2VccRR3FIyEaSlrexI1SbmnOVU8Z/ctfpA/jF55/DdKns3zyBReD6M
         VGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=E6p68maXODjtgUjoxS8Rb46rkun/j8SC1iIFL+uUHR8=;
        b=HMeiXAk4bodjF1L/fQIK6biRHXCSKy3Jt4VYJ4Vry779CBACjdl1leBs3WTXn2sbD0
         XycdRFb1VvyxVf1bMCsmekmFDddI7pgVNEjc/aORcPhK3U8YUTfT0aAu9Q1uRaEbtSo9
         Ss2ZFK1dmN5dZ2CG6McT7ltdVPaGEPJvVphoBoWd6SCHSnr+I1BbenTyBqDhkJH7xman
         VHCFj3IfWGpm1Mu4/UrPQNMcSYqKRPfoRFa0O4mwDftgbC7oQo2eU3ayFE8GKuDDHIv9
         +NPJSWg75HjqyEdDEQT+7izETft3S9Ea2P5oNtaiP+XJFJH11p+tp7e/mKNwji8HrBzd
         uaTQ==
X-Gm-Message-State: AE9vXwPCnS3fBf8xtKda24ItoG78Lh/foh6XTBRCK9FR8G03G9JB1euMGru5pfjqB9wAeQ==
X-Received: by 10.25.0.131 with SMTP id 125mr6566746lfa.149.1474137148390;
        Sat, 17 Sep 2016 11:32:28 -0700 (PDT)
Received: from debian (c83-249-31-250.bredband.comhem.se. [83.249.31.250])
        by smtp.gmail.com with ESMTPSA id f139sm3421150lfb.11.2016.09.17.11.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Sep 2016 11:32:27 -0700 (PDT)
Received: from iveqy by debian with local (Exim 4.84)
        (envelope-from <iveqy@paksenarrion.iveqy.com>)
        id 1blKWF-0004LN-Su; Sat, 17 Sep 2016 20:39:19 +0200
Date:   Sat, 17 Sep 2016 20:39:19 +0200
From:   Fredrik Gustafsson <iveqy@iveqy.com>
To:     Andrew Johnson <ajohnson388@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why are there multiple ways to get the manual in Git?
Message-ID: <20160917183919.GJ20666@paksenarrion.iveqy.com>
References: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 17, 2016 at 01:47:52PM -0400, Andrew Johnson wrote:
> $ git help <verb>
> $ git <verb> --help
> $ man git-<verb>
> 
> I tested all three to confirm they were equivalent.

While I'm not able to answer your question, I can shred a little light
about them not being equal. For example using a windows machine

$ man git <verb>

does not work and

$ git help <verb>

opens a webbrowser instead of a man page. Using a unix system I would
however assume that

$ man git <verb>

would work since it's the standard way of getting help on those systems.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
