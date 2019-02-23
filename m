Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6ED20248
	for <e@80x24.org>; Sat, 23 Feb 2019 13:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfBWN2V (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 08:28:21 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:35452 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbfBWN2V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 08:28:21 -0500
Received: from DESKTOP-E4U7JCE ([5.169.49.65])
        by smtp-32.iol.local with ESMTPA
        id xXLlgXdZy6rc5xXLmgMKDw; Sat, 23 Feb 2019 14:28:18 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1550928498; bh=IHOMYSAkJrjad1ZJEB1yS3SM2QT2/bUqecI1Z6XDu2Q=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=f8my15Ts3rTOW7s/FeGUOBcid09kiuBo6M/p/iHFFf+26Gm4uPcejwptVDyVYp+IO
         3tFVO+bMZ0t3mHH5+KvspnM779VWzl0OgASwmIOsyaI/kJQbZxg8ZdA5DZoPMHUQee
         Bwp0fPgb82cyFvMveBtWOWrRJ4oLMJHog4d1qgBGFnTrywTpbTkK5mVoZ0DWu7kO0J
         ksAfAz2Ksy1KJqBuvh+/c4WHhphqBudBomJAEwjrfgAcNY4Gbv09xwuB+HWbM8saSt
         BBwlElb+E7J5l9Rf/QAkR3PNcI0+Btsda72p4lWlkimlCboeza6VIzXh82AJAJptc4
         O02zT45uNkX1A==
X-CNFS-Analysis: v=2.3 cv=d7kkNirE c=1 sm=1 tr=0
 a=zYX2uk1tt1KodCNUFRWNOA==:117 a=zYX2uk1tt1KodCNUFRWNOA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=08cpZRoF9MTHr67id2AA:9 a=QEXdDO2ut3YA:10
 a=vk3CbCNW2PIA:10 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <1550928497.2346.8.camel@libero.it>
Subject: Re: Students projects: looking for small and medium project ideas
From:   Fabio Aiuto <polinice83@libero.it>
To:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org
Date:   Sat, 23 Feb 2019 14:28:17 +0100
In-Reply-To: <86fttvcehs.fsf@matthieu-moy.fr>
References: <86fttvcehs.fsf@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCtj/SWh5FJSGrgf88BPL4iPnNNAVNmHHXHlH+FS+xA60ltEubSkePnfTT5YGAAgwZWfOB9qnQQjS6EN0RjQONlfTbp09sGNx69/QY6DAl1d9B7Jtodi
 RJyCDvovRpfJqbu+SNKyD1WIgUxvZOrQvhwTpxiHW1bW33HsnJmobg5kJuQw8AcU0IpH8w1WPeYFfMA+xnblaoWcg5f5bxGLQOY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno lun, 14/01/2019 alle 18.53 +0100, Matthieu Moy ha scritto:
> Hi,
> 
> I haven't been active for a while on this list, but for those who
> don't
> know me, I'm a CS teacher and I'm regularly offering my students to
> contribute to open-source projects as part of their school projects.
> A
> few nice features like "git rebase -i --exec" or many of the hints in
> "git status" were implemented as part of these projects.
> 
> I'm starting another instance of such project next week.
> 
> Part of the work of students is to choose which feature they want to
> work on, but I try to prepare this for them. I'm keeping a list of
> ideas
> here:
> 
>   https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
> 
> (At some point, I should probably migrate this to git.github.io,
> since
> the wiki only seems half-alive these days).
> 
> I'm looking for small to medium size projects (typically, a GSoC
> project
> is far too big in comparison, but we may expect more than just
> microprojects).
> 
> You may suggest ideas by editting the wiki page, or just by replying
> to
> this email (I'll point my students to the thread). Don't hesitate to
> remove entries (or ask me to do so) on the wiki page if you think
> they
> are not relevant anymore.
> 
> Thanks in advance,
> 
Hi Matthieu and to all developers,
I'm Fabio, no more a student and I'm brand new in community
development. I joined the git mailing-list about two weeks ago and I'm
looking for some first fix or tasks. I apologize myself in advance for
my little know of the subject.  Hope to have some useful information to
start workin'.
Thank you in advance
Fabio.
