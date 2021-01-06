Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6248C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD572311C
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbhAFOXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:23:35 -0500
Received: from mout.web.de ([212.227.15.4]:52717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbhAFOXe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 09:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609942897;
        bh=FNNteq+yXM6zp6hbQuluwRLKmR+kPxJtJDu4QmxmSfc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YJz0EWmXs2cTkVMmmrGSLdZ21U/AwfUr1t6vo5oLb9+7MzpJJIqdTSImutPFZxLsb
         xLQtv/UwWK8iB5E2iBaX3MIJ1ulD4O0qX0U3mNfnsQ++d7xSPYGpF4Ym1vUlDmiAjy
         8ubPTDIdakbjWK6sskDDNc9SVdg9yl719e+Yp+7A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2KQ-1kWALP2y6I-00SUWE; Wed, 06
 Jan 2021 15:21:37 +0100
Date:   Wed, 6 Jan 2021 15:21:37 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Daniel Troger <random_n0body@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
Message-ID: <20210106142137.gxd2a4vnrsjj4jq5@tb-raspi4>
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:jdfYLOen+62MKoQ7qxs7MbRgLEbvX+sfpOc50z1zMX9hRR14B6I
 w/YjWuligYlKz+O5FWJgwv8OtsqIMSBb2Vn59UNJTAqYqPbYkGGNvXWVvuzE+tisgdlW1PM
 PEAHaTtEtGj7SIbit0i65PR1H6rD4Q3q+s4h0eTAovCUuMlm2eNPhOH/Zkfco1KZXljxFau
 VsIjd0qPtirvuewZbXxPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PLMuvWwxR5U=:hv51ZhnB35t6RHq94CnhDw
 uF7gtMvmHQtpOXGmRTbtPZiUJeeRHGjACihbgOJoGEiFRIgFMESUrZKxxFgsSZHCJhkZ+nsoy
 iLQynIJ9wZrqX/T0dKSWcDMLnoX2Sh9OiErSIKmp3w7+U3Y/6WSYbUZFpv61IfQENCkYQSRTf
 XKKLLMqzbCtXqXeL3DChQX7H1kU6DVVmLf7I9mSwx0nDKiumOZLosa8qt7nHvnHDHhLF1IY3T
 ZzqfTwjOKQfKZKM5y1x42RBgWa/GsbSxlSSEoYoryFyiDNf9XazNPlnXacHsg+ytrem84dTmc
 BAF1l8791myt8jD3H5YwdrWIGlZRBmdo0oK7F9xzBSGFwLHtyQtbSLO+cXtbjtIuADaKVtOjT
 D/dxrvn63A4Y1ST6MQWzXvX3jqiWJf8p6UwDxcog1Hv5e+5yrPsTe9Hq3lUrhHAiAbWqBn+IJ
 qRUyiIBXyIxX5QSBuv+Pxc+1wUVnjWT4zOB2fCzxSJsnKKRbfuHBsJMHFOjt9RUlDdOVHMAzc
 uTG+VHVY+hRdicrPQt8wx75bgrQNAWCDDTufIJYyFBi8FScedrQFbqPF/GYIEBn3v4/mMZ8sp
 OAQdP4uZ4A3rs8WKYI4prOmbQMnqImBQpZyyZfe039SlyNJlBIEI7vEWQZnoGJNhavptw4qDJ
 ZbaLd5rBWuM1YewY0xQ760UtwVpsuMnhVZnqKlEgkexVrK8CMHRwe2nVh+c0I8epVwt/Bww7+
 rEaRIHRJYtjtgWiSAQWtutIQHn+sxiPUIJVfgejIYZYURzBLcpjV3Eskfd/jrmWVd5AlLd5mp
 uxHRud94QXjFElL0+FYTdn4oyK3ANVU3OdRhBASwBfMp0E6RZ/0u59eQwxCg0f6OM4ZbF6ig5
 T00DiR1+OVRZXebecm0w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 06, 2021 at 12:35:26PM +0100, Daniel Troger wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> I ran `git restore -p .`
>
> What did you expect to happen? (Expected behavior)
> git restore to open in interactive mode and letting me select data to di=
scard
>
> What happened instead? (Actual behavior)
> I got an error message:
> ```
> me@iMac:[redacted]/paulbrunng=E5rd-springyard/src$ git restore -p .
> BUG: pathspec.c:495: error initializing pathspec_item
> Cannot close git diff-index --cached --numstat --summary HEAD -- :(,pref=
ix:44)[redacted]/paulbrunng=E5rd-springyard/src/ () at /usr/local/Cellar/g=
it/2.29.2/libexec/git-core/git-add--interactive line 183.
> ```
>
> What's different between what you expected and what actually happened?
> The main problem is that the command didn't do anything. It basically pr=
inted an error message instead of changing a file in the way I wanted.
>
> Anything else you want to add:
> Yeah. So pretty obviously the problem is the "=E5" in the filename. The =
interesting thing is that the folder with the "=E5" in the filename seems =
to exist twice, with differently encoded "=E5"s. But their content IS AUTO=
MATICALLY PERFECTLY SYNCED. And the only tool which recognizes them as two=
 different folders is git. ls in the terminal shows them as one, finder sh=
ows them as one, even "glob" in php shows them as one.
> This is what git seems to see them at (taken from git status):
>
> `modified:   "paulbrunnga\314\212rd-springyard/`
> And further down:
> ```
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	"paulbrunng\303\245rd-springyard/"
> ```
> Here is a zip containing the folder (emptied): https://arxius.io/f/7ec7e=
1c7
> I tried creating a new git repo, extracting the zip in it, going into th=
e folder and running `git add empty` and could reproduce that git sees it =
as two different folders.
>
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.29.2
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 17.7.0 Darwin Kernel Version 17.7.0: Sun Jun  2 20:31:42 P=
DT 2019; root:xnu-4570.71.46~1/RELEASE_X86_64 x86_64
> compiler info: clang: 10.0.0 (clang-1000.11.45.5)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
>

This uses the decomposed form of "=E5":
> `modified:   "paulbrunnga\314\212rd-springyard/`
...
And here is the precomposed form og the "=E5"
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	"paulbrunng\303\245rd-springyard/"
> ```

Both are lowercase, right ?

What does
git config -l | grep unicode
tell you ?

I have
core.precomposeunicode=3Dtrue

and that what we need on a Mac (to handle precomposed and decomposed bette=
r)
