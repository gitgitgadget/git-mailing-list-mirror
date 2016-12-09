Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3311FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 16:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933812AbcLIQxM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 11:53:12 -0500
Received: from mout.gmx.net ([212.227.15.19]:65091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932361AbcLIQxL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 11:53:11 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfBX6-1czRbO2fbk-00omZq; Fri, 09
 Dec 2016 17:52:58 +0100
Date:   Fri, 9 Dec 2016 17:52:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/7] Pie-in-the-sky attempt to fix the early config
In-Reply-To: <CACsJy8DDwKhOBOxD_yOf2MfhxP4_TDDj3AwCf25ct6YH3TGp6g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1612091722290.23160@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <CACsJy8DDwKhOBOxD_yOf2MfhxP4_TDDj3AwCf25ct6YH3TGp6g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RALpnT2AKyODh5WaK7LSYefNnGoMzXOLi0h1fpa3YMYyeJKprww
 ZgT/DMS3ZrvH/G4mKYYP8DAWCyxTQmk62nW3cLvv+HZIYIaabocfRlrBLnyUu531pxe1teX
 xGnIb+xZ8QBXQEO8smV2M2HQCmkAh4Y8zwv3ZRqJR86Z/gwftefJMDKze8+6NEfesh1iRio
 KYqjA6nQG+fKbVWc5Iitg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t4QayL+q7Mg=:74MKWf2Muu8+w5CdHpCCN0
 FzCfmu2F6SsMXSRM57pukMSadITjJuIw/Y45Y6DiOGHqs9M1CC0Wi8mI8sY4JMO7vD90RiEEW
 0TyY6G+US9EHjuLTRgKKMJUtLqzdfiSwse9O7BXr0clb87M3Ib9/n/3OED4sOVCJ0iOQl5CBW
 1g5ecG1vopHDWqDp9+lfIiK6amT8RgKII02XlS8h5oelwAmeQOqCJ7Vnf+uQVCLB3emXGpGki
 Sy14QFbnnOVYLA53TneQRZxUK7RmWFdRd5vp8a3SsdSm0Ktbod+eoj5hFG3A7ajg5BnWgzQj1
 nAjNfAIf+RzyqlHA0g3rWM6EwgBnkrechhnNHmhrXYIvKghrUr6NbpIPJOEiDYk+SZQRyBjsP
 IKJSDHYS+O4Qg+uZDnKgZ2k0ju+o/NSIRBh0EwIcPkchBy2EkKZ11ssfOrc6wJgNIqOTTQTsd
 iRg4T3VNMDzH06qo13sTOAY9UjL/wdv1hjR/VlnMrL0y+N1jmU5i4VHsy9iWSuDIgMzY7sDLR
 X5Yz6yyIkNw89H8OjHhLz8U9qhphDrUnCqU8tVuMYRPpBCzfMnkdtzxbQf0pk/61H5v4FAbaS
 ydd7g3VZYC6lckWahiC7CHovTcdW/QB1jYk1L68eFRihL/46CdHeoldmHeKOK9fPRGP7+pKo4
 UQWhr1n7fMY/0qp0uOk7iY1biTZSkxWUNyP0/E1qO7nR2ABmL5UkcSVijtnLbXRghcNIfmhPb
 22Mb9CY03Tg1kY7JF1GMRs7dGDqs66TCWWp5CPve6+n3u3FMbCH+NBdA5m9ms2Dp1FZXEHgv1
 Z6OR/+i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 9 Dec 2016, Duy Nguyen wrote:

> On Thu, Dec 8, 2016 at 10:35 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Hopefully these patches will lead to something that we can integrate,
> > and that eventually will make Git's startup sequence much less
> > surprising.
> 
> What did it surprise you with?

I mentioned a couple of WTFs elsewhere:

- that it changes the working directory (personally, I am not surprised,
  just because I was exposed to the Git source code for 10+ years,
  however, I know developers who do not share that experience and find that
  feature... interesting)

- that there are multiple code paths to do essentially the same thing, but
  in an incompatible manner: setup_git_directory() and setup_git_env()
  (and possibly more)

- that some environment variables are set, and need to be unset (or even
  possibly reset to no-longer-known values) to allow subprocesses to
  access different repositories

- that git_path() can be used before setup_git_directory() without
  failure, but wreaks havoc with subsequent git_config() calls.

- that the setup_git_directory() cascade is completely oblivious of
  whatever config has already been read (possibly requiring clearing)

- that setup_git_directory() *returns* the prefix, even stores it in
  startup_info, but a subsequent call to setup_git_directory() returns
  NULL

- that as a consequence, builtins that require the prefix to work if there
  is any, but do not necessarily require a repository to begin with, think
  `git diff`, *must not* be marked with RUN_SETUP_GENTLY

- that check_repository_format() sets have_repository=1

- that setup_git_directory() is a oneliner, calling
  setup_git_directory_gently(NULL), when it would be more logical to
  simply make setup_git_directory() accept the "nongit_ok" parameter

- that setup_git_directory_gently() is not at all gentle when the
  parameter is NULL

- that resolve_gitdir() does not, in fact, resolve any git directory, but
  only tests a specified path whether it refers to a .git/ directory or to
  a .git file

- that resolve_gitdir() actually tests for a .git *file*

- that resolve_gitdir() is not used in setup_git_directory_gently_1()

- that resolve_gitdir() tries the order directory,file and
  setup_git_directory_gently_1() tries the opposite order

- that the handling of the ceiling directories is hardcoded into the
  setup_git_directory_gently_1() function

- that a ceiling directory of /home/hello/world does not prevent Git from
  looking at /home/hello/world/.git/

- that canonicalize_ceiling_entry()' relationship to ceiling directories
  is rather coincidental when the name suggests that it is very specific

- that canonicalize_ceiling_entry() does not, in fact, canonicalize
  non-absolute entries

Need I go on? I could, you know...

> I can see that I disrespect the ceiling directory setting, perhaps
> that's that.

No, I actually see a lot of good reasons for the ceiling directories.

Ciao,
Dscho
