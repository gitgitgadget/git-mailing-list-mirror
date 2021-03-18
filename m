Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E2C433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242CC64F4D
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 10:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhCRKhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 06:37:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCRKhM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 06:37:12 -0400
Received: from Christian-PC.fritz.box ([109.91.254.15]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MYeZB-1l8rmV23d5-00VedC; Thu, 18 Mar 2021 11:37:04 +0100
Message-ID: <b805d53740429a26413cdd4e756db29f95c98052.camel@avr-fun.de>
Subject: Re: Git install crashed nearly whole System
From:   Christian Strasser <christian@avr-fun.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Date:   Thu, 18 Mar 2021 11:37:04 +0100
In-Reply-To: <YE5wFxE5RPew5zrJ@camp.crustytoothpaste.net>
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
         <YE5wFxE5RPew5zrJ@camp.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:avo4Vf1WDgKEO8XVYGmbOGavEgES8xuPK24HrpHrxdZyT2qrJLz
 xizIyE5o/V3/sdxs3CDhMdUdpUN2dLLz4P0R6fFD8R5Ao2L/cW5K5LO46IiA3N80Zl1wuQy
 4CKIZg2QKwAVwTVLk7wd9xZaUCNDm9bhOVRi+JF+f5N4jgVdJ0h/hr54tfm6r2b/VC0TRdh
 7INns9wucBdpxDOd0otQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MsXzHfGeqhM=:uU33SPO9NHN3BBeFYv0+1R
 QVOqDm8BZ3b3uWLIdP/rtCLTDbsD6XTEmt3n4eJq97V0lygTfBG6IunXfWfuNzQTbmTyuqKTb
 u8f+aIrjTTvPV2NCHC1G+zwgdpmuLFrghKSv5qnP2DrMO2MWTGiB6rD1WWirqvvUgkpxvk7Fy
 WSkecJ1oeTyoYlLB8iHY+fEsHULqo05a3UJHCSDQNcvUZS6UXl1A/9KfpjTL/MbPVNoKKZgfd
 yUCijtdD/khmOFISKQcpKkwMDzi65atDTfN806Bw4qWEdSMfuFY1iLolk+5nJnOv5OYlI2e8y
 kmLoMw79k7sgA5q9T/253z1bnEbSULQG/4g1IB1/BgBYnS10Cy0mjAUC2coF8+A6e9S3YAzV5
 HoyY0lj0unJu3OF3+CfIEum4PREpX5h+X41piVdveOBggsg/oojps0JJK3QtQo7nbD2hl2GvO
 msqdE/CGHw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Brian,

First, I want to thank you for your detailed information. 

I'm a little confused. Is the instruction on "
https://git-scm.com/book/en/v2/Getting-Started-Installing-Git" not the
official one? As you can see there, the first part is how to install
git with your package manager (git-all).

I have to admit that I'm new to the Linux world, and that I still have
to learn a lot about it. 

After the disaster I reinstalled all lost packages (also GNOME)
according to the information in my apt history. Everything seems to
work fine now.

Should I remove everything form "git-all" and reinstall everything
according to your advise? It seems no git daemon is working right now
(systemctl | grep git).

Best regards form Germany,
Christian



On Sun, 2021-03-14 at 20:20 +0000, brian m. carlson wrote:
> On 2021-03-14 at 18:23:40, Christian Strasser wrote:
> > Hello all,
> > 
> > I installed Git yesterday on my system. For that I used “sudo apt-
> > get
> > install git-all”.  During the installation a lot of very important
> > packages got removed! It was horrible, and I couldn’t use my gnome
> > desktop environment at all! A lot off dependencies got lost!
> > Fortunately, I could save my system through read out the
> > information
> > about removed packages from the apt history.
> > 
> > Today I totally removed git and tried to install everything again
> > with
> > the same instruction. The same misbehavior did happen!
> 
> This is best reported to Debian because it's a packaging problem, but
> I'll tell you what's happening.
> 
> By default, Debian installs recommends.  When you specified git-all,
> you
> also asked to install git-daemon-run or git-daemon-sysvinit, and the
> former is the preferred option.  So that causes systemd to be
> uninstalled and sysvinit to replace it instead, and because GNOME on
> Debian is configured to require systemd and not to work with
> sysvinit,
> GNOME gets removed.
> 
> There are a couple problems here.
> 
> First, you don't want to install git-all as a package because it has
> this behavior, and git-all should not be configured such that
> installing
> it causes your init system to be changed.  That is a serious
> packaging
> problem.
> 
> Second, GNOME should gracefully work with whatever init system is on
> the
> system, so that users can pick the one that's right for them.  Non-
> Linux
> systems don't even have systemd, so GNOME should be appropriately
> packaged so it doesn't have this problem.
> 
> None of this has anything to do with Git the project, which provides
> source tarballs only and relies on distributors to build binary
> packages.  All of these are Debian packaging problems and should be
> reported in a series of bugs to Debian (usually via reportbug).
> 
> In the meantime, you should install the git and git-man packages if
> you
> want to use core Git, and optionally git-email, git-svn, or git-cvs
> if
> you want various other parts.  You don't really want to run git-
> daemon
> outside of a controlled environment because the Git protocol provides
> no
> authentication or encryption and you shouldn't expose such services
> publicly.

