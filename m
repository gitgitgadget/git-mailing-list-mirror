Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4DF202AA
	for <e@80x24.org>; Sat, 23 Feb 2019 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfBWSTq (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 13:19:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:54443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfBWSTq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 13:19:46 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbxJ8-1ghivm2I4M-00JKPU; Sat, 23
 Feb 2019 19:18:56 +0100
Date:   Sat, 23 Feb 2019 19:19:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: does "git clean" deliberately ignore "core.excludesFile"?
In-Reply-To: <nycvar.QRO.7.76.6.1902231905180.45@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1902231912370.45@tvgsbejvaqbjf.bet>
References: <alpine.LFD.2.21.1902231008530.28936@localhost.localdomain> <xmqqimxao76b.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902231905180.45@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yHaeR7HxoIokvquYRyOo2Ielsppq2G/2VEQLp8dbLvb4rpWO2fZ
 X9n6adDX2QucRdRqppAWOmnCLPOF/7m94iNBDfpAKsTyVA9wqnTkZ6/TUwgB6iVmcQNDgT1
 iBeqqazSip7OfUPmanYKyPTs7ApWWBReB57OTIFVh7gpJM6HFFjb8OSnqccAAzkFU2UHP90
 Aprjykj0pSJcOwbnYtitw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UXg9CDkJvnw=:SuFPZSGLZN/GtsmAHZF1ua
 EdTk3pVj/K2zyn94MCdIwZzbDk+fMAFVzVZmQMtaTTBdk4tLoFJFOhtT6Hf+TVSHxsVfnJz6C
 nU04aDFX7K88rAb4eI9/V7YlpJsnGTp+vG9uZKqg13d1UWXaAOmO1gsKIejnPxsImzDWLKaOQ
 ReiKzOn/ivkVTQg8J9Y7EMJr4Dxwuvk6uovqL0QFr6P6eDFFBx+NCkC6Xs+WnrmLEk4cHmOCL
 s6sAmzoBzGf00S4e/5mVlKa1ZX2IFL92C6qwkI7bvTIpctZfH7G+HeUdb9MTjPOVQ85xM3sUL
 0OGosEvR5tfjjsB88XVx/VZGTlXfttlXiyS9BjxSlyimYoo71ejC9/jLxBlQrdNcOxBLKIsdB
 zbR4IqSMcRsqWWs31pUPMgyFY4aZwT048TmSwbup3mfvhJVTpBF/wnkpiebQC57CZ1pTRqShK
 mXAGFHvlE9waH3i2cnsgaK1Wuic8MUyYy8Jcj503occv/rnIrP829Iq+tys9I3a2FLfNFpvG0
 EQYm3alcjKeYS6gwFjarectC24srQXtB6uNIzRZU2tXk1eCsL+ZPtHNJE05bFOkVpHGX9FGCY
 XhXY5N/wfrf8/nYONT3N7qSJAtsEPl0ngWcO/OjmSudeNgk8tfj3Mym/4pJZFZeEtxlssLgfC
 eGELN30w5ylnBdomgbfqMT3u8mawOd4ae74uWD/DRwuawS70CDf3MjCO2ESbEgltidh/3dgEk
 zrrqulrccit1S7Zav7a8FnwBs5r3WwazDE36+GbpzIxjVyPY/DrAfzQarwiNxvF2UlUqAXghq
 KIFd4Sd2kzpJJAQcywYnLDFzUiJ1w2nIpTZvA+dgAp8mFV1G90H497YqzPUYehrkM7IjkKOBW
 hfCNSWl3Xk5MoQKFoLtj4UY608BvYzCgTyBBQ7JX06ErvgMIsG0qV/uqdIt1ZwyFutUu/b7yP
 VvWbDjqWkyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 23 Feb 2019, Johannes Schindelin wrote:

> On Sat, 23 Feb 2019, Junio C Hamano wrote:
> 
> > "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
> > 
> > >   am i misreading something? and if not, is there a reason git clean
> > > does not consult core.excludesFile?
> > 
> > Can you ask "git log" and "git blame" whch of  core.excludesFile and
> > "clean -x" features came earlier and by how big a difference?
> 
> Or maybe we can have a look why the `core.excludesfile` regression test
> case in t7300 does not catch this?
> 
> https://github.com/git/git/blob/v2.21.0-rc2/t/t7300-clean.sh#L408-L417

I actually doubt that `git clean` ignores `core.excludesFile`: in
https://github.com/git/git/blob/v2.21.0-rc2/config.c#L1297-L1298,
`git_default_core_config()` (which is called via the `git_clean_config()`
-> `git_color_default_config()` -> `git_default_config()` chain from
`cmd_clean()`) does interpret `core.excludesFile`:

	if (!strcmp(var, "core.excludesfile"))
		return git_config_pathname(&excludes_file, var, value);

Then, `cmd_clean()` goes on to parse the options, setting the `ignored`
variable upon `-x` and then doing
[this](https://github.com/git/git/blob/v2.21.0-rc2/builtin/clean.c#L957-L958):

	if (!ignored)
		setup_standard_excludes(&dir);

This function specifically looks at `excludes_file` in
https://github.com/git/git/blob/v2.21.0-rc2/dir.c#L2481-L2483:

	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
		add_excludes_from_file_1(dir, excludes_file,
					 dir->untracked ? &dir->ss_excludes_file : NULL);

So I am quite puzzled by the claim that `git clean` might not consult
`core.excludesFile`.

Robert, care to come up with an example demonstrating where it does not?

Ciao,
Johannes
