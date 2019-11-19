Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7673D1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKSU7q (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 15:59:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:58901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfKSU7q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 15:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574197178;
        bh=DqI91n6ci1hLWI/IqLwyb5GjcJLVRPxX4tyi5h6qTi0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kgxN5x/4OYpnZbJqnpMvP8A9ucz8EL6BJ4DYqcdUKlkK8PHBujZ5b7hAw1bXSNjIm
         xT7tELmzmNuRGoYjQihWXoE9rZqlS+5mePSh9RQ4HqUnvRYr1o4zaB75cHc96KgSud
         UxrFFR8uSFe9efWZusNtV8eOYu5dEAZnRy/SiQUQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbW0-1idErE08L8-00H9ii; Tue, 19
 Nov 2019 21:59:38 +0100
Date:   Tue, 19 Nov 2019 21:59:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce`
 cask
In-Reply-To: <20191118221804.GA23183@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1911192155140.15956@tvgsbejvaqbjf.bet>
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com> <pull.400.v3.git.1571789978.gitgitgadget@gmail.com> <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com> <20191118221804.GA23183@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-377742872-1574197178=:15956"
X-Provags-ID: V03:K1:y1rCGVVLjrUqit24+4kW8pDMXQG7Y0zi46XSVtnuWaRjLnxpUdY
 +MTH+1Nh7ZkWCtWH7JHdm7L0z7QSZSADESePythNTLP5fqKIXyY2iWesXfYahcLKlJGtrbd
 S+GfrtLLAJW1HBdcAdCiVR+WpWhJEqdX0gurmd8wHJwetU35VvXT1JGbri6I8p7w8GiLUXg
 S26zOwXGmEDik49XENh1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J98vAtY9O0I=:E+sEqoYkKkkey+grOHfCoZ
 yjGVHyYc4HjuHGkdx19FkZCc421+s/79UQlAlfApmuaVdq7LpxbEZW3gT98RPc7jEnEg6edCI
 /HRJPaE+/eaV/W0H2hegbgI8jeJX5H4rFeQxyr50bOMDJN9a4iH/lFmAsQEFau37BpVq8Qqe7
 YzKtDjZMYpjC0qW6up5XcNbeubbZDHyePuzyW3UTHYKPlqiz7Rf+1ZSRTBFH28crX7xVD5bM+
 wXiThpUfhGMC6ZenrsYaAG6VZvM1192Kxsn3bHABEn87VoLC+ZgGbSUESFxeiAhg4uhIZXd7S
 tKCehJpW0DzgFBaZg6Ck99hey7endF1Qunc4R9W5LOa5HVxzAFGQ2S1OFppyrtM86YQfCkvx7
 8F79QCTU7mCiKkk5JUc2bhum/LaPNwpJGMHig7gEHcd4mkT/Dce2w1vBye69d3KtXlxXoSj1o
 KWEq02PBCtZ0NWDUYJeHyxExVGHXiDAg682WdK7xdUZzZE2jFkmo1765d76k8nX7/ZVt2qs3X
 8jyXQSgRQ94ElqsQcHyMN25tXu6cUQTt4wlWnEPPMre7bziPK8pjLs9OTXUn5EAnQByewM3tc
 t7lUYp5//HI3eTHkraGZgjvnrpY2cJvrQ1kays82Ut58swwpMH1vcV+KjqtAbUHSJdb0zMKOj
 E6J1cPIO9Gza7hoVByA3knAEKAXHFaPJhuwJsd1nU4cW/VSg421DfA89gzQokrGCMsDSs8SS8
 RpNGJsGZgOgf0cWotbqxjb3VMnYZwpUPQDRuSt5giCdXUdf1jrrL5JxMnoeW2pOPnqX5gc6sT
 QtynKa7JHf6m5tSdO9KZ63jvjigX154sIk5ZHa3pyJP8GShocGzfu9U41CLpaLFuxn+PfhKyL
 20HZ1p7vVCn6K+LdOe8cBbeIqJXHAaoIf0A6N1yWKKc87461HFn+Z7CsPIUanv3CpPoLVz9vR
 Um0Z7vfAV5LeZ88sBwBzWSjgIo0ykUvKuQS8A4Rtm59t5c6jcVvC1qGQVDY/pJkD5YgJk4Rgm
 li3I2GzRjASH3Q9zjk4vnY10xij6R3cHHm3BdmVJQImkyg79L2I05OtRRaFIvu1ch8iYEVrQ2
 pKNoyNNSwL3BXU/880rdewRFn0Jd2YqcgfgLt/0Ig9l5n6qdbMEu0gadM4zQqQtp48SciS3gw
 GURnqVN1gOFbzAoy99bqiMegmywsf5w6jZfOqRxGRKzAV7OJzWU6sQ/6VKLq+imBHM+Ro9D2n
 rLU4pAMbIBZegpyFccS1Sc9sjZ/HmlOYiS03RgJAtK8Kd3v3CyU3XSDJJfaU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-377742872-1574197178=:15956
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 18 Nov 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Oct 23, 2019 at 12:19:38AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > CI servers are typically fresh virtual machines, but not always. To
> > accommodate for that, let's try harder if `brew cask install perforce`
> > fails, by specifically pulling the latest `master` of the
> > `homebrew-cask` repository.
>
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 85a9d6b15c..ce149ed39c 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -40,6 +40,11 @@ osx-clang|osx-gcc)
> >  	test -z "$BREW_INSTALL_PACKAGES" ||
> >  	brew install $BREW_INSTALL_PACKAGES
> >  	brew link --force gettext
> > +	brew cask install perforce || {
> > +		# Update the definitions and try again
> > +		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask p=
ull &&
>
> In the build of v2.24.0 this 'git pull' printed just short of 600
> lines worth of diffstat.  Two weeks went by since then, and in today's
> 'pu' build that diffstat is already over 1000 lines long.
>
> Perhaps we could use --quiet here, though that would suppress the
> transfer progress as well.

Isn't there an option to suppress the diffstat specifically?

*clicketyclick*

Ah yes: we can just pass `-c merge.stat=3Dfalse` to that `pull` command.

Feel free to submit a patch, as I won't really have time to take care of
this any time soon.

Ciao,
Dscho

> > +		brew cask install perforce
> > +	} ||
> >  	brew install caskroom/cask/perforce
> >  	case "$jobname" in
> >  	osx-gcc)
> > --
> > gitgitgadget
>

--8323328-377742872-1574197178=:15956--
