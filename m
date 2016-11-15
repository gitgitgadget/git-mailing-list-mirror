Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F3C51F40E
	for <e@80x24.org>; Tue, 15 Nov 2016 10:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965930AbcKOKTB (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 05:19:01 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36722 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941618AbcKOKS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 05:18:57 -0500
Received: by mail-qt0-f180.google.com with SMTP id w33so65815699qtc.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 02:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0MwDrstyyMXl8PGgLjbX/YFgOxA1Q0lj/5emSxDyLuA=;
        b=TXRSO3hx4spL8vio2Ds/hXacRsBSEsBTlT48x5t06PyW90uxGWrvz2uJp/f7xNPRF4
         Lv1r8P6XTXaDxAlPIprZZXeyHgSsBMc4+YMQPJFWorrtvIVyxbk5EK+KkV3r7oOJvjqX
         R9t1y4XKgp/IZVCGBiqEtL61PmEkyw4DrJp/EhrnrF/nfbTML6KiIAmCvYRMMK3wRgwl
         fx8kiHjTYdVoEHXaQaIjsBI+Hcbc5hJot90PI4SZNU/bz1BOVLiNRbFtyCHmVVwKkwQw
         vNJ7EA7/gonV899cdPR0F508to/xUI8dF3eMxNZ2kifwmS61Z58iUc7jUzUt6oR30+Lc
         vR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0MwDrstyyMXl8PGgLjbX/YFgOxA1Q0lj/5emSxDyLuA=;
        b=Ca3Merdm3f6qTvjR3puiMajjljYxfOxlZ+21N+7o+qVM8hwxcYPMS6E+WlbRhC5tQS
         brSUCVagRAjiDTn1UplnHNRAxCiUCbHCTWVR1w8my2lQbVYwdOi+27b+MFiIzZrmeOtN
         vj1+FAivDkdKvnkm3GwyaUsUeHSX5wEjlNlWLq0lI5Rf2N4ZsIPyhDGZ0KyOcsYHBsw3
         WUe2QkadJiSqptjl4ieQrBWJ1oNKSex4oU4CPCytCu8AacMqCTqvitJlfylLcDYdnkPx
         2H4eiBKDUDnuWHA621X173ZuQlQ0HZIJb5PM7lm7LHBkcWS2yx+jH4UtCCCleloqmlEj
         n4Aw==
X-Gm-Message-State: ABUngvcFKdTjfTp0KM9FhqEJwFijJlpgDuzoVX1DiMocEK+YDEFe0KuS0/0pef+68SHb5w==
X-Received: by 10.25.14.81 with SMTP id 78mr2122064lfo.183.1479205135916;
        Tue, 15 Nov 2016 02:18:55 -0800 (PST)
Received: from debian (c83-253-195-111.bredband.comhem.se. [83.253.195.111])
        by smtp.gmail.com with ESMTPSA id q19sm5701477lfi.1.2016.11.15.02.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2016 02:18:54 -0800 (PST)
Received: from iveqy by debian with local (Exim 4.84)
        (envelope-from <iveqy@paksenarrion.iveqy.com>)
        id 1c6auH-0003wS-3q; Tue, 15 Nov 2016 11:24:01 +0100
Date:   Tue, 15 Nov 2016 11:24:01 +0100
From:   Fredrik Gustafsson <iveqy@iveqy.com>
To:     ravalika <prenuka@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git status takes too long- How to improve the performance of git
Message-ID: <20161115102400.GC28860@paksenarrion.iveqy.com>
References: <1479202392275-7657456.post@n2.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1479202392275-7657456.post@n2.nabble.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Nov 15, 2016 at 02:33:12AM -0700, ravalika wrote:
> We are using git-1.8.2 version for version control.

That's a three (almost four) year old version of git. Your first test
should be to see if an upgrade to a recent version will improve things.

> It is an centralized server and git status takes too long

A centralized server? How? git is designed to be runned locally. If
you're running git on a network file system, the performance will
suffer. Could you elaborate on how your environment is setup?

> 
> How to improve the performance of git status
> 
> Git repo details:
> 
> Size of the .git folder is 8.9MB
> Number of commits approx 53838  (git rev-list HEAD --count)
> Number of branches -  330  
> Number of files - 63883
> Working tree clone size is 4.3GB

.git folder of 8.9 MEGABYTE and working tree of 4.3 GIGABYTE? Is this a
typo?

> 
> time git status shows
> real	0m23.673s
> user	0m9.432s
> sys	0m3.793s
> 
> then after 5 mins
> real    0m4.864s
> user    0m1.417s
> sys     0m4.710s

A slow disc and empty caches are slow. Two ways of improving this is to
have faster discs or make sure your cache is up to date. When I'd a
really slow disc, I'd my shell to run a git status in the background to
load the cache everytime I started working on a project. This is however
an ugly hack that wasn't approved to be a part of git.

> 
> And I have experimented the following ways 
> -          -  Setting core.ignorestat to true
> -          -  Git gc &git clean
> -          -  Shallow clone – Reducing number of commits
> -          -  Clone only one branch 
>       - Git repacking - git repack -ad && git prune
> -     - Cold/warm cache 
> 
> Could you please let me know, what are the ways to improve the git
> performance ?
> I have gone through the mailing lists.

You could always check the --assume-unchanged bit, see the manual page
for git update-index. However this is quite extreme and demanding for
the user.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
