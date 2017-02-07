Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA091FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 19:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932292AbdBGTsr (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 14:48:47 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33500 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbdBGTsp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 14:48:45 -0500
Received: by mail-pf0-f171.google.com with SMTP id y143so35439481pfb.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 11:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x2hzhO4uJFsHbk4KCV/OKwVUY+p073abmgVqTMkGjTM=;
        b=TpIpvTFggIbv+IhKlGTgFVP4sYqRNhar8t6pPoAcY+N2AQ7vgcgmOL9IOkLbJIZ+1W
         5YoI/xuPG5pTv9AgvizZ6TiG1ol8btXtp66i+27pIhv0qvV3rq9E4eto2AALTjMhfQBf
         Gc8/I3x1dnCiDBfpLJc7py4tmwGbscrB5c3VvUkcxWZ33rSHO2zR8EtwWdhlGzk9+qpG
         Av1y2zojK0/KXTlM5kCJjgIi0IxdFi4dFEbMhnBBIMmL2M6yXTLA2knKpNduJNRBX/ev
         xaW3NaaDRsPpmrc7j0D9iyDk3PVLLbeB73Ns/4wmIWCESwJ9npwdvMTMtZuqcA69ywaV
         4+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2hzhO4uJFsHbk4KCV/OKwVUY+p073abmgVqTMkGjTM=;
        b=j8twZSIZFRyeU4GNkTmDA2cF6Q1ua7fTYoEARXdKigmXkSSz1rXovBFuge98bBA7re
         sIeAPkx8pmGb3FqZ/hFOXgP8Un3mfXeCzNTUhuyXBvyUCtoWJYpfe42UAZhwtBNUwTkS
         rYIo5tRi7HCaxGRcGzVomAFgTq146XY9VTEgWFMKpa2AGpkjyq5Jzm1hMM6ulzVGuxNu
         WLnyLQhjpnMkKHLjilPLmH+XVNhS2nHmBPI33lUyTMEKY+ZoSjjiv1/MAcSGXMHo93bJ
         s/yYeNhGX+J54ChJHk6cWrVwXOGy90xVOgVq53dEtJdgmLmBQJ3BtPxn+LwuX3RzwnVh
         ncEg==
X-Gm-Message-State: AIkVDXK4I3UmNqAxKY+XTjmd57fj3c4cjUXTdtTOCQKIZpv0ckgVYRvcydUu9cIZG8qI5Q==
X-Received: by 10.99.106.199 with SMTP id f190mr21705823pgc.110.1486493080569;
        Tue, 07 Feb 2017 10:44:40 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id j7sm13273582pfe.84.2017.02.07.10.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Feb 2017 10:44:39 -0800 (PST)
Date:   Tue, 7 Feb 2017 10:44:37 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Stavros Liaskos <st.liaskos@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: subtree merging fails
Message-ID: <20170207184437.c6uuuxcmhi434vbc@gmail.com>
References: <CAEXhnECi3LvSA92dSjL5PZ1Lx9p1PWELS04nmfJW=8K9o4T-0Q@mail.gmail.com>
 <CAJZjrdU3toam4tDwXBu1Q3UAZm-kML3CzMrsMoJ_2jsGJ3vWrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdU3toam4tDwXBu1Q3UAZm-kML3CzMrsMoJ_2jsGJ3vWrQ@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2017 at 08:59:06AM -0600, Samuel Lijin wrote:
> Have you tried using (without -s subtree) -X subtree=path/to/add/subtree/at?
> 
> From the man page:
> 
>           subtree[=<path>]
>                This option is a more advanced form of subtree
> strategy, where the strategy
>                makes a guess on how two trees must be shifted to match
> with each other when
>                merging. Instead, the specified path is prefixed (or
> stripped from the
>                beginning) to make the shape of two trees to match.

I'm not 100% certain, but it's highly likely that the subtree=<prefix>
argument needs to include a trailing slash "/" in the prefix,
otherwise files will be named e.g. "fooREADME" instead of
"foo/README" when prefix=foo.

These days I would steer users towards the "git-subtree" command in
contrib/ so that users don't need to deal with these details.  It
handles all of this stuff for you.

https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt

https://github.com/git/git/tree/master/contrib/subtree

Updating the progit book to also mention git-subtree, in addition to the
low-level methods, would probably be a good user-centric change.
-- 
David
