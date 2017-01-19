Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98EF920A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbdASVsX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:48:23 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35750 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdASVsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:48:22 -0500
Received: by mail-lf0-f65.google.com with SMTP id v186so6752233lfa.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 13:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lMqurlYVVc2oonez0keICMQJklE1kmX281wnJ2IOiAs=;
        b=pcAsbAtZMNNF5JEyTmJ6nzaOKzGDvlQORJM2kYUZOIebNHVyXteShtZEekqcNFoRQu
         Fy/EE+jDMjrCxK7Yp8kgwqwosC4TppMNsKDgXZ5y5NS1uYwgWSAmWCmQa0JV8pu8RBM6
         g+ahjt631vo5F6OgvsDvThi7f99wBz1ZMHTluncRbvJwR5RW5IOyHaQ3HKd87KjjWi8T
         2QtWPR8sdf7sT3f5uw8jG1nZnRKvf6Z+9IMY2ec4tnRkfM3iUbXzEtj+2OlATzolF9TU
         zmXAsit++WSlUC3yQTYH3g6Dtl8+FgSdXbp1t1raa/yBrY4lhFSxS6MyXYtBIKmRJG6R
         wUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lMqurlYVVc2oonez0keICMQJklE1kmX281wnJ2IOiAs=;
        b=Km6UOwrORWTtA8bh4pYeKGkkiqs86RH26Ne31f08yi23dLl41s9WfGR4MQ8tWWIdZI
         De4vipyCeNCsFeSlOW9D++8snKCNl+sf6LTrzIkY9267hhkTGxwvcpbK7FsKsq+DMEbD
         W8iVDUTYNvebvRIdYZEVAfz3JwwEF+HOxwYbNvJL4Yoje4sqvJtPudslZuVn/sUkG8KV
         S71vuboDtbcvzOLEOhPl5jmEujXsxd9vilnRrF9TJBxR3pJDjuwaKVKH9VZTB+mpxl/m
         Nx/yXQ0e6Bg04tSY/0aYjgSbOro0djdRvQqtXvW5EqfGfbPSz7TEfKZ7G3V1DsSXxJdJ
         aTQQ==
X-Gm-Message-State: AIkVDXI9cjcXcXoBp4W6Tl0iyZ4Mv/aTKM8ibvdFkn9LRh6i9AgcQL73hXCAKr7+BrdRwQ==
X-Received: by 10.46.78.2 with SMTP id c2mr5283743ljb.77.1484862501100;
        Thu, 19 Jan 2017 13:48:21 -0800 (PST)
Received: from [192.168.1.26] (afu230.neoplus.adsl.tpnet.pl. [83.25.150.230])
        by smtp.googlemail.com with ESMTPSA id a78sm2422651ljb.47.2017.01.19.13.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2017 13:48:20 -0800 (PST)
Subject: Re: Git: new feature suggestion
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Khomoutov <kostix+git@007spb.ru>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
 <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Git Mailing List <git@vger.kernel.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b96b71b9-f8a2-d039-6e8a-c64e7aac02a0@gmail.com>
Date:   Thu, 19 Jan 2017 22:48:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 19.01.2017 o 19:39, Linus Torvalds pisze:
> On Wed, Jan 18, 2017 at 10:33 PM, Konstantin Khomoutov
> <kostix+git@007spb.ru> wrote:
>>
>> Still, I welcome you to read the sort-of "reference" post by Linus
>> Torvalds [1] in which he explains the reasoning behind this approach
>> implemented in Git.
> 
> It's worth noting that that discussion was from some _very_ early days
> in git (one week into the whole thing), when none of those
> visualization tools were actually implemented.
> 
> Even now, ten years after the fact, plain git doesn't actually do what
> I outlined. Yes, "git blame -Cw" works fairly well, and is in general
> better than the traditional per-file "annotate". And yes, "git log
> --follow" does another (small) part of the outlined thing, but is
> really not very powerful.

It is really a pity that "git log --follow" is so limited; it's
development stopped at early 'good enough' implementation.

For example "git log --follow gitweb/gitweb.perl" would not show
the whole history of a file (which was once independent project),
and "git log --follow" doesn't work for directories or multiple
files.

> 
> Some tools on top of git do more, but I think in general this is an
> area that could easily be improved upon. For example, the whole
> iterative and interactive drilling down in history of a particular
> file is very inconvenient to do with "git blame" (you find a commit
> that change the area in some way that you don't find interesting, so
> then you have to restart git blame with the parent of that
> unintersting commit).
> 
> You can do it in tig, but I suspect a more graphical tool might be better.

Well, we do have "git gui blame".

[...]
-- 
Jakub Narębski
