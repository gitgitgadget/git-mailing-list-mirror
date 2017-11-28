Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4022620954
	for <e@80x24.org>; Tue, 28 Nov 2017 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbdK1Ofs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 09:35:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:59790 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752112AbdK1Ofr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 09:35:47 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJXEd-1eHmMu0Gz5-0036Wk; Tue, 28
 Nov 2017 15:35:27 +0100
Date:   Tue, 28 Nov 2017 15:35:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Prevent double UTF-8 conversion
In-Reply-To: <20171128102126.20864-1-l.stelmach@samsung.com>
Message-ID: <alpine.DEB.2.21.1.1711281524390.6482@virtualbox>
References: <CGME20171128102138eucas1p116ae54d723bb100202fae2c1aaf5a9d8@eucas1p1.samsung.com> <20171128102126.20864-1-l.stelmach@samsung.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2021115085-1511879727=:6482"
X-Provags-ID: V03:K0:tgUnSPAttqFSu2r8aDaMoxuF560ShhN69sC1xSssmAvBtGa2Ws4
 i/85lb3MCDqIdrHFHmkHLfsgEfNPxnhSY7P+JBnrgBfjZatOuK6XzhugCSDsikYYtOoPB3j
 5zBMA+eiCSgmXpRXOD31bJMjv7Dxu49lRJuojUywln1fWk6fr/lY+uTHv1fBbh9EsZivVcT
 /nweCEfRkd3bpFI+FOqcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7b0v73gCcg0=:/mZBC5tppKAqobR0Cc6XWO
 RLdHgk4ihTnPHPUM8Yf0s5USlDcd4yaY76YA0FCrZ+to/EYJUSgXPHZzlM8IbJ9hhzCGRkSGV
 /KEeEs0432XYhU64SPLrXRDIehfhbz5DgiZrL44hOpeahv5GuhdF+2WWm2RqL7/hdgtitdf2C
 /tDJXoqBr2yRDu6pFCtFrndtVRrGV+CHbwHw0jhzLb5fvB0fil5MyHqJFykXS+7cU6wNldgjl
 fM+FBAXw+mFlzjHTTee8TwodTh4RZJFkvJFbGYeN0qY9IQbDDbM8OG6cJ9kRdA7LdGwwPf3To
 YdnYjOz5/0tkkVyy8RYfZBbrtSoOuQM/wOCzxVIrD73CVGvYO3XAHvIh6d3CuI3s7A7T7er/5
 0Ve4DI/9LAvtRYwP9u/iJfcrxr0BZnVCGoycjKziDs38YGohH3WV+McritV0eNQeXe8f0w/tM
 YCjKtkEXkuwGbvBpsJsxnVRGTlzjhL5yBc0AB0XoLcqVFAkLFalvf18vqB9ImhlQlgHgbG8/v
 2axMfl5Kn6bKZHuYU1DpgIIJXLM4x+FFJLviBHCc2EHk9AC+O9CqcVxGhKnNhmhm38G7xM45r
 JqwPXf+yZu7keT8RQqN7p2HtguLjYV8W+60h3IvXptcxnFlq7LG1R/U8xW5DiECPNfK0+SpXg
 B8i65kGVViqHwbyVYsecBQiESCFU5w19if+i4DdsYfocJaMDt785GClJyxogPLoE9TsUJPP3K
 WwCOTGVGK2XQhyER7yGGguF+utFxmjIJt6S+mjNaay1qY9aHG+JE/7QCzBbXa/thgy4lNhNPP
 z2mOVhjbZCO2RJaTnySWux7f18AZTgJDwKmCDVxQOH38NuyhNA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2021115085-1511879727=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C5=81ukasz,

On Tue, 28 Nov 2017, =C5=81ukasz Stelmach wrote:

> Set encoding to utf-8 for file descriptors used to receive data from git
> commands.

The patch only changes it for the `cat-file` command used to read the
latest commit message for amending.

Maybe the commit message should be adjusted to reflect as much?

> With encoding on the file descriptor set to "binary" Tcl (8.6 in my
> case) does double conversion which breaks e.g. author name in amended
> commits.

Is the problem in question occurring when a commit message contains
non-ASCII characters encoded in UTF-8 and you click the "Amend Last
Commit" radio button on the right side above the "Commit Message" text
box?

I tested this with Tcl/Tk 8.6.7-1 of Git for Windows' SDK, and with Tcl/Tk
8.6.0+9 of Ubuntu 16.04.3 LTS, in both cases the encoding of a commit
message '=C3=A4=C3=B6=C3=BC' was handled correctly with "binary"...

Could you give more details about your system so it is easier for me to
understand where the difference comes from?

Having said that, I also tested it *with* your patch, and it does not
break anything.

> So, this is the second attempt to draw some attention to this patch,
> since the first one has somewhat failed.

Yeah, sadly Pat (who is still listed as the active Git GUI maintainer) has
fallen very, very silent for over a year.

Pinging about the status of the patch was definitely the right thing to
do.

Ciao,
Johannes
--8323329-2021115085-1511879727=:6482--
