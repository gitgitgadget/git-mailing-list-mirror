Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEE3C433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 21:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiAIVx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 16:53:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:57499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbiAIVxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jan 2022 16:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641765203;
        bh=Ckl7pBpGDlrz5p7p3c6Q1OZdbm90OVtlXmfb/vPKl2E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q4vcFPTR6FnikBsVeuKRyN/ibe+Z8K7vNasKehcTpHnc6FvnBdIguIS5FQHGFeN/w
         L+LMKIf7rBoBYeLYXSEgj3Tk6IYdX28lHXFR1Vu4KK7ZW+cTOJe3Y/8+055egjDvoV
         YjGsQwOEysbdI/gYw91+Qg0on4fiDn8jFy8N+MHY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1mM1ph2oPa-012ZhR; Sun, 09
 Jan 2022 22:53:23 +0100
Date:   Sun, 9 Jan 2022 22:53:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Imi Admin <imiadmin@HTW-Berlin.de>
cc:     git@vger.kernel.org
Subject: Re: Problem with credential.helper=store in git 2.32.0.windows.2
In-Reply-To: <8838ac786ed46b841e4172824b80564b@htw-berlin.de>
Message-ID: <nycvar.QRO.7.76.6.2201092246520.339@tvgsbejvaqbjf.bet>
References: <8838ac786ed46b841e4172824b80564b@htw-berlin.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dVu8GpBO/62gnmZVj34xlhRzjpdm4dPRXkzIhlfZNWZ+EProbhi
 wCwiEEU5mU/7qaJ3OWqcV1Bp+wH/dNIYzQRzSJu8yzWwZhwEI8eokG4bXPwxaDkg9a3B7C1
 HQ7PixTY3YOjs4kptYD4Enarc1QhBd7uvXLJcEddpDNRHn3wyrh9hhloG9C3Ei2qvCeeeQR
 otkAEIiWZL0EqUzNRt3wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K4o62ohjoUI=:ckx2ONdx4Jo3txZLBAdPvF
 KYRuuMenwYMd6m2gKRgqr7gjFYL/KU+9xmjm1yiub9Y2FKNeQeqbtIIyl2O/l/7tU2OfR+wEX
 ++wMUV1HUdfVmNtAG2JMpv1QqhdshH2hglj00zG3EGcLYn2C6cPOPcTQ8/fnLzif3PnQdfyr7
 ounxGPsRaO+2gP7+iGcTwVkeoAKMcxjBznrn37IwmNrg8tfU6dxnyb3xxHICCnwHA7RD17M3r
 3XFEQB7D6d/n5zSwgrEJ8huLkYPLHMMd/wtu0hiBFCiJW4VcxniPZnVzwfahkjAQUMUg+8gFw
 wUo0MyFcu7oHn/i9RiCt8/kpGzsVNoLTa5ifv/j55hhxACc4yaVKkQwqdmHQVz/q+ILp1RdGh
 7ksyl028J0NFXJJjshRJb1DGq8dkxoEdB5wAndu8NQLl/jSObb3pSKTkfKQZIKOeM6rBIYtPd
 BYGEbSvufBQLISRH4oHsvKLb8LmkOkZT+RaVgs+m4pGPvcrx60p2c0wrqEsYPD5+ejkd2NhIz
 6iiQMEg48EViDF2IwN5UHzT1zPEW0p965zOHtzEmIOenUVUIE5lrmdv4KHhzKQ/mulOozwt+Y
 E10KiBk4Vf1Lg/deS1mqVs1ibxisXJUFpz/roDGvSTNWbx9fHzq+FL2mKSwK+E6MjwdyCPUo1
 a0VLiEfHdwMpBN2vN62HFB1RPcu5ua+EJ76T4/jC39bSruiYfw+8kZxG1ClSDZwSMCmWtMcG9
 zvt3NLj1d7WCxrH9rM+9CaxkeN+T8fxQ/W38uDc/Zi1HaJ+z12MPnV4OICRGqKnva3SFrRo1l
 3upWEdP/HoV+PWX+JIz6MI9MJJxu7zFmt4jFl5c3gqXXMOZPqQL8WFrBdyS3pUv/WvGMlO8F4
 7zt9s+q6sYcEeSdib7URgRhHphGOu9k5hWo3+HdFfrvNKB1EoLSpO30o+BmCE6Slob78fSx3T
 e1RySfCpx0dap0WdeoOXFgKoNQjXXUopp05CEpZsFM7GnplO8n/hP5MQDnIWIfe7mXuYyt/JG
 JgVZN95+/dRsF2NFG1AItzZtpIBTw/c1jr4lfYcyWlKmCmgXh/qQtQyBzzCS2aYNuyra4COUq
 +KOQ9ZuWL4nZWI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Thu, 6 Jan 2022, Imi Admin wrote:

> Here's my local git configuration:
>
> PS C:\scripts> git config -l --show-origin
> [...]
> file:C:/Program Files/Git/etc/gitconfig	credential.helper=3Dmanager-core
> file:C:/Program Files/Git/etc/gitconfig	credential.https://dev.azure.com=
.usehttppath=3Dtrue
> file:C:/Program Files/Git/etc/gitconfig	init.defaultbranch=3Dmaster
> file:.git/config	core.repositoryformatversion=3D0
> file:.git/config	core.filemode=3Dfalse
> file:.git/config	core.bare=3Dfalse
> file:.git/config	core.logallrefupdates=3Dtrue
> file:.git/config	core.symlinks=3Dfalse
> file:.git/config	core.ignorecase=3Dtrue
> file:.git/config	remote.origin.url=3Dhttps://mygitlab.de/mygroup/myrepo.=
git
> file:.git/config	remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin=
/*
> file:.git/config	branch.master.remote=3Dorigin
> file:.git/config	branch.master.merge=3Drefs/heads/master
> file:.git/config	user.name=3Dmyname
> file:.git/config	user.email=3Dmy@email
> file:.git/config	credential.helper=3Dstore --file C:/scripts/.git/.git-c=
redentials
>
> [...]
>
> Anyway as far as i understood git should not exec git-credential-manager=
-core
> get at all with my local git configuration?

You need one additional thing to make that happen. As per
https://git-scm.com/docs/git-config#Documentation/git-config.txt-credentia=
lhelper:

	Note that multiple helpers may be defined. See gitcredentials[7]
	for details and examples.

And in https://git-scm.com/docs/gitcredentials#_configuration_options, we
read:

	If there are multiple instances of the credential.helper
	configuration variable, each helper will be tried in turn, and may
	provide a username, password, or nothing. Once Git has acquired
	both a username and a password, no more helpers will be tried.

	If credential.helper is configured to the empty string, this
	resets the helper list to empty (so you may override a helper set
	by a lower-priority config file by configuring the empty-string
	helper, followed by whatever set of helpers you would like).

So you need to insert a line "helper =3D` (with an empty value) in your
.git/config's `[credential]` section:

	[credential]
		# reset 'credential.helper' list
		helper =3D
		helper =3D "store --file C:/scripts/.git/.git-credentials"

Ciao,
Johannes
