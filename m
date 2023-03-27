Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0B0C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 07:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjC0HRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjC0HRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 03:17:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25C3C17
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679901450; i=johannes.schindelin@gmx.de;
        bh=a1Va5VO+TZBK3Zq7gQYJATYJreBmtfSSueahnspsaWE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OsQ8nSwR0JzUow4Rh3z/4ohYSUwKeXZXhKig49xwo/CTFkdtX5ZSltej3ZjWY2YS/
         N4m/M1XW+2h3vIWnWeZi5me5Ee5s61Sq32bO1sISrpKHyx+xVEQcbDjtCzOnjNt0CB
         RsISs0xdc6G3i4ZcNBiyFMjNzNH0d6KIAmCAILwEVw+clkZhE11FmnssNxSDpIhyG7
         gn3pQFq7flCWKzse1hM/TJsfLF1PuH5DjTDwphqM5whLzKdrCa1RJl0OUoe83sBwIT
         1NOs2kB8RcZIQbz5FNaPvs/Ib3Bkp+ojSE9+2mFyf5xT1FJrpj1M+YYYgfN8S6JH5S
         o3JUL0YuPTz+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1qHgLs0l7O-00b0Mf; Mon, 27
 Mar 2023 09:17:30 +0200
Date:   Mon, 27 Mar 2023 09:17:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     sang.tts.designer@gmail.com
cc:     martin.agren@gmail.com, git@vger.kernel.org
Subject: RE: Bug Report with Git Bash
In-Reply-To: <002601d95a64$57312bd0$05938370$@gmail.com>
Message-ID: <36529771-b147-48ac-13df-51ed8462eaa1@gmx.de>
References: <000801d95a56$e9253f80$bb6fbe80$@gmail.com> <CAN0heSqEH+AtzXcybPY-Jd-bRtgtKmGrfxbXL-adsvjr_srEZw@mail.gmail.com> <001d01d95a63$f1fa38b0$d5eeaa10$@gmail.com> <002601d95a64$57312bd0$05938370$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1481356811-1679901450=:123"
X-Provags-ID: V03:K1:kgwP/GJXWjgMKids3eAAQqMZy56heuHAbVo1qOTr+2BzRaP2I8f
 nEPYP8PQJSai3hgZfNgf4xYWKNaDD5/ksgxklqBRP2uBo07tCsw1hhBBWdP2hJVmkFkvBdK
 7wCEZLn+4uY7yoj+GCI/nc8Fmg7QvAzzYxBPpUkjHqTZrFeW+mZrJL94VE3Tcqv3YJfGhS4
 bJMV9Ujf4eKzkE1T2ZHHg==
UI-OutboundReport: notjunk:1;M01:P0:o/tz/m/jvVA=;euw7vr+DH8DM3NGlbvUZ7ql5VOh
 iEl3pJ3LetCOcrvldKwJF+mA0AcYG/s94X9wx235EcDwfIyI9A9sL0pAtZajqB+jGMAhV5tcc
 jPlH8Xp9R81aXETZiXv7vNJIEvVIa8nQg8BXvXHh7j9Rkbg07Qou0Pe9GxgqC8/rKDgGz0iDB
 I/hWtMbjox+JlwvL1xv0Ts0GFZRa54NTgOVPfaGlVdJEoJQfgaYpOXCPafWF/HjbIINZDRZyI
 AvTgLzG6JU9tv5dDtvjudasxkgVcELM/dkaKkuodlJtByGa/YuDQIqqMxW078RnCKMAEn2TDP
 qlI2wvWupbNYz/FxvH6WQJmHAroeFCZG1AM50aph1sxaJgUOyW5KwyAk32MMryoMeCuJ3CLXw
 +u8IkF9uLCDm8nlX1rQ1VWpc+EtIi08V0ut6O7fGfAVQkwF7+Eckxan/0yt48QJzAXdwll3vp
 +jzHPW8NaS14jrUrtx4E9FkvVfGP6isWxympx1d7SnViBps0BC1D3s5hqtZ5HFhcF+X/7fj/w
 rrp5DPxIvtCoEzTwKktLp+3n2uLizwOa8Bic6CRvPwhNtKRu+MWUbf5U/8ve47zSUMZnBPzu8
 8OSSJn4VFqiGlE1IAgFL/4c+8tTUq4OgHvQpld9fIl7ipRSfAQoJFavmJETUg/acxl3xOEQhy
 Uhie8xBQCEMrxJ+oKBx1PRpIy8K7913V2312hxsPQLSHKcXr8V+MfR5Hn7llElWVPfx6ygzn6
 DEuUchBvnyr6JOoHHXfnreLZWF13no+ffcNHCuZ40+gc4GUdmsDkDhsfAibVpbS60T285MxCH
 9MGN8xajBptcZ9civQGHkVUTU2M5iUJ6ImmUVSIqkdoE0aOv7YSUMfIw7rjgCNd4IWsiq2aBj
 k2YETHyW+4l/HS1D2vTZirX5O26+JVPqviujtRSUNdudNFhKtJOqd+Z/jb+qd3iytmm/6mtPf
 z/kH4OJdZhjsb1Cge21s/YKP4bw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1481356811-1679901450=:123
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

FWIW the reason why you see it in your Ubuntu setup is most likely rooted
in the `/etc/skel/.bashrc` file that contains this:

	# don't put duplicate lines or lines starting with space in the history.
	# See bash(1) for more options
	HISTCONTROL=3Dignoreboth

Ciao,
Johannes

On Sun, 19 Mar 2023, sang.tts.designer@gmail.com wrote:

> Dear Martin,
> What a very quick response!
> I just tried your recommendation, and it works.
> There is no word that can explain my appreciation, to be honest!
> Thanks a million.
>
> --
> Thanks and Best Regards!
> ---------------------------------------------------
> Sang Truong Tan
>
> Department of Electronics
> HCMC University of Technology
> Phone: (+84) 977 600 563 or (+84) 908 983 574
> Email: mailto:sang.tts.designer@gmail.com
>
> From: Martin =C3=85gren <mailto:martin.agren@gmail.com>
> Sent: Sunday, March 19, 2023 7:28 PM
> To: mailto:sang.tts.designer@gmail.com
> Cc: mailto:git@vger.kernel.org
> Subject: Re: Bug Report with Git Bash
>
> Hi,
>
> On Sunday, 19 March 2023, <mailto:sang.tts.designer@gmail.com> wrote:
> This is a relatively simple bug. when we double-type a command, like 'ls=
'.
> However, in the Ubuntu environment, the command only occurs once when we
> press the top arrow to use the prior command.
> It is identical when using git bash.
> Repeat these steps:
> Type "ls: in git bash.
> 2. Type "ls" once more.
> 3. To return to the previous command, use the top arrow.
> As you can see, the number of times we type the can command 'ls' does no=
t
> matter; it only needs to occur once.
>
> This depends on how your shell is configured.
>
> Look into HISTCONTROL and ignoredups.
>
> You might want something like
>
>   export HISTCONTROL=3Dignoredups
>
> in ~/.bashrc.
>
> Martin
>
>

--8323328-1481356811-1679901450=:123--
