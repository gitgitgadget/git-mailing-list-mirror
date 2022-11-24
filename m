Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E992C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 08:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKXIy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 03:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKXIy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 03:54:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114FB9A261
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 00:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669280058; bh=BVoiQBteR6MPumJ80x+0VQjTC2tgYiB7kIHsAuOBC54=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=POUPGDEV5Dn7oO6upZApnxtjNgkmipjUAycMjdflKF4clC8Nxp7/h/LYAYly2Pqak
         eJ2vT3PRw1crxxmOFNbwVJHuDvGfj8B45m9frdl9IXstHcNGV30Y79s2K9fMn1XEtN
         tszxIqGF/XU87QxNipyvVr3pkBWMuzoBfkRKqK23lo4t9zkXCAHXrD0o/jwuIT2FGn
         yy0q3aIPONk02x6S8s4S55P6p4I7MsS+oeXgcgevBNITiQ6j5vRwQZ+LG0/ighHEG4
         VyaWbTFNd5ckg57a3l+rZ9IH/O1J1+kHtcesl1IkzIr9b6K+0H1Etu9iPoBRus4d0y
         7fbkxb2ft2HFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.58.20] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1pO5993Ot8-00igxM; Thu, 24
 Nov 2022 09:54:17 +0100
Date:   Thu, 24 Nov 2022 09:54:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] ci: upgrade version of p4
In-Reply-To: <9q4525s6-qrq8-1841-n257-711328352n85@tzk.qr>
Message-ID: <5p3n90pq-4ro8-0278-3q8s-r2p568q3o26r@tzk.qr>
References: <20221123150233.13039-1-worldhello.net@gmail.com> <20221123150233.13039-3-worldhello.net@gmail.com> <n79194n5-8q94-29n4-s447-64r0p2po4r76@tzk.qr> <9q4525s6-qrq8-1841-n257-711328352n85@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eS+1eI09yqNmQ/drZRNmaOPboJK5sKtKe9j2fvKDHNEpQDXVp5j
 PbeaBYAyS0wKn4iXP1cesqYRDUSvIK0Z6T7tdxNexAjYtRHe8sBVHjMBUs74HvJhtMOMVmk
 I3Zi2y9aeoaBWw2uW2SYJSPG8dE87MVNZyvdI1Cc5XPxZtC0SqbNAwkg7q89yJBmbooSZ9X
 7rOt4MODDItk7P8WMTrNQ==
UI-OutboundReport: notjunk:1;M01:P0:oRton7eh4U4=;xqDR06y9qiUB1GRoA0gUT4+LBlH
 cHYuGsU7JiA72TKatQjLlGv3iAHai2W4EIj/7Hckx3JR2UvQpwNCPrcLthZdMIeuOG2NG43nU
 vhfb6WbbYV/4IbAi7ioJnXCpkQ/nceC/aqv5qosluWkYPnz0Hq4/QT/6bT/4rzm7LX/JCOcFn
 6lr1Hn59fnlYbmE0AdKeph7J6QmEnpobKXKF3apw9fz5VrInrP0F/WiCj/pUF1mXs08yGhHNg
 h+jqxQwSkjdsxLDzP1xvhws9+7CPJ9SUgNnfo5W+oypsKcop3TAGB1lScB2tGed+LTo5EslkQ
 DLKsh+ng+ZBJJMEd7V8ohyZBrt1ZVlVyRb5H7z0sciDR1jPXjhorwTZ/arrMkjNZ7hlTQg5f9
 AYo7K1N4fzP9wQn6YEjRrTiKv54TV05Bb8vFpnkiX1wVSEbXLZ6xGWs8vG5r2THB4UOvkK1Bt
 rDBeVIV06AsOJSBxvqe9oqVpLDg7F8XEEg0NyivpkDjH9M3sNVPv6Z9DUGMvd9PwKeUYYLgIU
 td1yRfTI6QNZXoB0W2A4OgRtDkjqZA1mBqZL/WqHQ4F8at5FBesVUqD0PCKjqmZP5RtX7PrX2
 4j2RXUevIHgexzhmNSX8O4oRPVSRrgTqQLq5tgQB8ALeSewDR3XHy/2epzYepVSphQE5RpY3t
 oeUbIJgM6zhJ4P7jDcDqrVCDRzFa7BISXIyfym6ZjrEK30zwII953+Gv/Z1BdYyxGDOecDyNm
 fR0kET8kIjxDHbiPJazxcpHN3CPxfzUtulmIdi0olp3pR/XkJWLcU3LjDp5AlCRbgWNBZ1mga
 9pcxVIOAzTwI8QmKBRkZkFX9sJMBgaKCEjjuE8Vhr+KbJksWFI6D6tZJ6J5kdItHLrNgVjyXD
 M2A4lKxPe8laYUiQ1HROWoqc09H3EwPyqu+wMJKbNnYz6JDLqdTStPRRWSsICeiGhtPLpJ/zg
 SblEkA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Me again,

On Thu, 24 Nov 2022, Johannes Schindelin wrote:

> On Thu, 24 Nov 2022, Johannes Schindelin wrote:
>
> > On Wed, 23 Nov 2022, Jiang Xin wrote:
> >
> > > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > >
> > > There would be a segmentation fault when running p4 v16.2 on ubuntu
> > > 22.04 which is the latest version of ubuntu runner image for github
> > > actions. Upgrade p4 from version 16.2 to 19.2 will fix this issue.
> >
> > I was about to embark on a debugging session when I had the splendid i=
dea
> > to look at the Git mailing list archives to see whether anybody else h=
ad
> > encountered that particular problem.
> >
> > However, when I pushed a branch with this fix, it still segfaulted eve=
n
> > when downloading version 19.2 (link:
> > https://github.com/dscho/git/actions/runs/3538788474/jobs/5939977231#s=
tep:3:387):
> >
> >  + wget --quiet https://cdist2.perforce.com/perforce/r19.2/bin.linux26=
x86_64/p4d
> >  + wget --quiet https://cdist2.perforce.com/perforce/r19.2/bin.linux26=
x86_64/p4
> >  + [...]
> >  + echo 'Perforce Server Version'
> >  Perforce Server Version
> >  + p4d -V
> >  + grep Rev.
> >  + echo 'p4d: bad version'
> >  p4d: bad version
> >  + p4d -V
> >  ci/install-dependencies.sh: line 91:  3051 Segmentation fault      (c=
ore
> >  dumped) p4d -V
> >
> > I guess I'll embark on that debugging session after all ;-)
>
> And I did. It turns out that r22.2 works both on ubuntu-20.04 and
> ubuntu-22.04 (I locally verified for the former, proof for the latter:
> https://github.com/dscho/git/actions/runs/3538941550/jobs/5940295721#ste=
p:3:384).
> So I propose this fixup:
>
> -- snip --
> From 81e2d9a4f6ad2d2d9df27edfb666fe2112bdef57 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 24 Nov 2022 09:31:41 +0100
> Subject: [PATCH] amend! ci: upgrade version of p4
>
> ci: upgrade version of p4
>
> There would be a segmentation fault when running p4 v16.2 on ubuntu
> 22.04 which is the latest version of ubuntu runner image for github
> actions. Upgrade p4 from version 16.2 to 22.2 will fix this issue.
>
> Also add some instructions to show errors of command "p4 -V", so we can
> see why the output doesn't match.
>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  ci/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 6c658fa21227..eaa75ab3c07d 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -252,7 +252,7 @@ ubuntu)
>  	# were recorded in the Homebrew database upon creating the OS X
>  	# image.
>  	# Keep that in mind when you encounter a broken OS X build!
> -	export LINUX_P4_VERSION=3D"19.2"
> +	export LINUX_P4_VERSION=3D"22.2"
>  	export LINUX_GIT_LFS_VERSION=3D"1.5.2"
>
>  	P4_PATH=3D"$HOME/custom/p4"
> -- snap --
>
> If you squash this in, please feel free to also use the updated commit
> message.

Hmm. Hold on. While `p4d` now no longer segfaults, it looks as if `git p4`
is completely broken (see
https://github.com/dscho/git/actions/runs/3538941550/jobs/5940295721#step:=
4:2005):

  failure: t9800.3 basic git p4 clone
  	git p4 clone --dest=3D"$git" //depot &&
  	test_when_finished cleanup_git &&
  	(
  		cd "$git" &&
  		git log --oneline >lines &&
  		test_line_count =3D 1 lines
  	)

  + git p4 clone --dest=3D/home/runner/work/git/git/t/trash directory.t980=
0-git-p4-basic/git //depot
  Perforce db files in '.' will be created if missing...
  fatal: 'p4' appears to be a git command, but we were not
  able to execute it. Maybe git-p4 is broken?
  error: last command exited with $?=3D128
  not ok 3 - basic git p4 clone
  #
  #		git p4 clone --dest=3D"$git" //depot &&
  #		test_when_finished cleanup_git &&
  #		(
  #			cd "$git" &&
  #			git log --oneline >lines &&
  #			test_line_count =3D 1 lines
  #		)
  #

I guess I will keep digging,
Dscho
