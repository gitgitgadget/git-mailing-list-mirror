Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E529E208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 17:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbdIER6O (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 13:58:14 -0400
Received: from mout.web.de ([212.227.15.14]:60964 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752269AbdIER6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 13:58:13 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7n5k-1dbu1v2NdI-00vKr4; Tue, 05
 Sep 2017 19:58:07 +0200
Subject: Re: Empty directories in Git: Current guidance for historical
 commits?
To:     wafflecode@openmail.cc, git@vger.kernel.org
References: <20170905124743.Horde.bgYg8gUhE6ubSHtPAr3lCGl@vfemail.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f8ed8f0b-a2e1-9e7a-bf79-2b7629b838f2@web.de>
Date:   Tue, 5 Sep 2017 19:58:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170905124743.Horde.bgYg8gUhE6ubSHtPAr3lCGl@vfemail.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:8yCbt78b+QLnHGupMCzKcSUJZFYJjtXnKQ/oL51rxOt0fSayV45
 3ATOMUfKbuBtLYRJyPh31EERRXdyVpCpJteVrlKNMCjgnFnO/qz4uF+dUeti4FlZoGLqNsJ
 jCGzPEQ1/7ptKc4GFUtDZ1atvFTrpDYPzyyOBzWRmd3p55J68C+CshKsBmzlPjch7+wIl2g
 +1EfJ2t1+TRzNqTRBO5pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s6rgGUehtQE=:gC+gSQFxnCK01POTJ1sc9a
 nG5f4R86e9xLbncT3iJ9+0Ju28PpKusAnvsle6lzBw1gGPmD/FxjIErVKUMJ5jK6Q7jh34fdP
 eTAwNvmcrc9b0NmHlV9pZ/qVh9ByqeVMwYIUpgYC0Jx0ByQRgqu4m0fmD4B64jGXZbaDMsPBy
 NiXrpK0iPUWCfcsae5sDoig05J23VGgCBIAoJy4fRnXwd6pFwkHI8CXSd/PurFSWDmiz+tKwk
 8abBDaPHnbzYVnh68ap1FPQt2mgFVZG3RKEgPNykquqXJaqAtA8UOwmO+HygwLR5DlEy9yYBL
 XhCYpPJ/ciyFJvFpDI/ALGvvDIRPS3wqWhw75UtXzxCgBEcHLBLObO58F9SIqNjr4wU34LSu9
 tk+WcMn6pVSSSjQOOT1jABSsEICXc+sCxDquIKvHrzyrOFIqjPi73Srm0hzcTEX5N6+FZGTxl
 4ryKId5GZH+SW8UREOD6phjnPhp44s2+5kE8U+E3wRJ1SUXoxH/VPPsxe5xVRkiEhbgEqUuHX
 CnrZkYeULgsxuzYmCXzHJVQta6Tg8RzB4dsRYElLP89KZcbe2q3rwagx8a+yJKF74ZtqUv9LJ
 CauBzd3aI0OvEJWa0fZ5LuA8mkeUG2Gx3rBg9oyKjgOr8Z5FOgnFirktKEwXGtCdA29EGvvI9
 5UTgk8s+d42zeD00l/XHB7okL0G79xZ+3A/1Mc4qVFaOcDYldAJ9cdWYrFiFb+LBDnEARzSt9
 AYoHGtKWYtKXDjLxInK++UkUpNz0qaV9681NiChBN+7RNr9p9f5+WyqWsDBqp4XQ5Ps2Meh7F
 3lSk1E7IccVs1HjrORnrpfOM//p7O9Og4mxqpVfOvJPABdK/MY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-09-05 14:47, wafflecode@openmail.cc wrote:
> 
> Hello,
> 
> Per the FAQ it's clear that Git (by current design) does not track empty
> directories: 
> https://git.wiki.kernel.org/index.php/GitFaq#Can_I_add_empty_directories.3F
> 
> That's fine and I can fix that for my code going forward via the build system,
> as needed.
> 
> However I'm looking to import a fairly deep (10k+ commits) svn history in to Git
> and I'm wondering what the current best practices are for dealing with empty
> folders?   Meaning to say, I'd like to be able to check out an older revision of
> the code and have it build correctly using the older build system which expects
> certain folders to exist.
> 
> There are a few different answers floating around the net, so I figured I'd
> confirm via the mailing list.
> 
> Is just dropping a ".gitignore" or "README" file in the empty directories during
> conversion still the most reasonable approach? 

A .gitignore will, but may cost 0.001% CPU time when running "git status".
I have seen systems that create a file called ".empty" in every directory.

> If so, is there a way to do this
> automatically during the conversion using "git svn" or the like?

Not what I am aware of.
And even if, the .empty files need to be removed, once the directory is
removed.
And we don't have logic for that, as far as I know.

That would be by suggestion:
convert the repo "as is", with the tools we have.

If you need to continue to work on an old branch (or the master branch),
add the .empty file, where needed, and continue to work in Git, on
a branch as usual.


> 
> 
> Thank you
> David
>
