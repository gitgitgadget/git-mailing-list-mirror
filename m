Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639271F461
	for <e@80x24.org>; Mon,  1 Jul 2019 13:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfGANQI (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 09:16:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:35929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANQI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 09:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561986961;
        bh=o1Dna7/DhpCjtcc2APEAKUWje+STX7Oe/TmDQSgXQ6Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PYvmmyWLAz4SxpzZaSCYzi0gK0tdGhhPcqdTbXJBZMwjo5D5SK5nYHTwbtBdy8yuo
         fh1BhJg1Ue0mMklHPCN1JcMLcyl+Q49IxdWNlnVjfeRQ73FMxxO7QKdJWrHrdloyjq
         PFHrm6Hm79xxn/GaxkKnUknIXj4IKV0DsiJ04N4Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1hnCpK1hZP-00FFK4; Mon, 01
 Jul 2019 15:16:01 +0200
Date:   Mon, 1 Jul 2019 15:16:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org
Subject: ab/no-kwset, was Re: What's cooking in git.git (Jun 2019, #07; Fri,
 28)
In-Reply-To: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907011515150.44@tvgsbejvaqbjf.bet>
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-286019804-1561986988=:44"
X-Provags-ID: V03:K1:EOE9YgTB9vWQLcsCGfOxry0OPAsS2fljdyz6ayavu7awDVN1lyp
 fEiA4U/XhqZ/feglbBHALeU6xMALn+U82Rki0s1bzr9nU7A4R7I1ufL63x670fxli+ifKLT
 bEVoPUcDT8cXlNWbhUkWauCufB2LX3o3JQ8G8kAELv/nej2nfOGC2pJPryMh+tjuhSQMY+t
 Zb7ZRMG7eJ2rdAiwPcIGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qNQek9YOt8A=:okM4B+cHpUuLIrJTVsuuVN
 zDCKp0A/4wgN0ldK61q0TG00Dfj/HJ9sD9Qcx/Z2y6bYHDN1PFULycddfx4fp3RbYh4ku6GPP
 Cp1QYLm11bC8LxJ+ly4CbF5DrJL63XXisj+2K20v4sibSd7orL0lHIn/HyxOQ4MsLQlmwRuVI
 mUZi4R8FpfmVW7lUdmhd8BG5QVKjS5bsfJ2fy6KkJnFJ7Y1g8EnfDa+KRyy/WnANYVe2/6Z2w
 gzadB/dkL6kKnCF+wc7po54QyCRlfilBfW/R7rB7wtiJ1IgJP1mHXAf4xfLp5IRzivIK/QIhK
 doUeDg9Pn8XNdfuKZ0ffrgZ+vhTFFo6saMwMOn7E2vI3pVzSgfMdonFnXdQI6+tOpf2bqVMNl
 hE8MdvIHWIcKE9gQkK3MdkvsZyCIHfZiTEjlq02sP6TC7g/kiFA7OcE9It+7mQBHRORAABmSu
 FfiNJnLhDvu1V/HhrxAoWNC3fYEsQrEQA0kiERuIgQjlB56H+edK7WKQG+2/wola/5i4EGyfl
 VH+ZlNcpBpmSwR/rgsjeRx+Z7xRsKaf2fChbEcvHzGW7uFwA6IbD+ebJcrv9nuBcG5zOgkyLw
 +u3IlrbwdphsSs8zYUkS9cl7PzMecvXEf0S5v1r7l767uj+cB60uZ7Ix1b4URobFPHNvkivF5
 dfZ2eXwytTnMbwUE3vAXUecfLuNbXI9S1uWY7psWqBd6+xVRi0kzZb3/pGdkaQNqwlqtRnOAy
 L1A7OUfyv3zdRTDlwCI24LwFoUVdsiiF0USHQNDP5/9BwoooXgPqRLv3JJFclKJbhU+bUuZi7
 xG3gVVN7EewUrzWAX+qWersUWhEDylASWtOWlQKNUJz5+nBB+jcrpQ3eUUzsC7AQ+faddGbB5
 TZVAcyVmffta2fLZM268OQ9qW6B9PmnfPFXx4tvtzynFCtgZEEZk+GEdtqEE4aNp30MUkWZpS
 9tHEgzpu/I6IecQSwlOJvCCtMF81h24h8JW/fvu86y2hxGvE3l8TKMJd0vpTp3d6eNJot/d7f
 ATywTgOowEIDggG+0DKcF9SKNxS4w1BwY0jAS7CGcHM+Hvo6Ph3Mn7TwvDkHTuXtS20/WOJZL
 EoNrtzfB7aX5gZQHAswivDVzFHEdSxP+kPU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-286019804-1561986988=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & =C3=86var,

On Fri, 28 Jun 2019, Junio C Hamano wrote:

> * ab/no-kwset (2019-06-28) 9 commits
>  - grep: use PCRE v2 for optimized fixed-string search
>  - grep: remove the kwset optimization
>  - grep: drop support for \0 in --fixed-strings <pattern>
>  - grep: make the behavior for NUL-byte in patterns sane
>  - grep tests: move binary pattern tests into their own file
>  - grep tests: move "grep binary" alongside the rest
>  - grep: inline the return value of a function call used only once
>  - grep: don't use PCRE2?_UTF8 with "log --encoding=3D<non-utf8>"
>  - log tests: test regex backends in "--encode=3D<enc>" tests
>
>  Retire use of kwset library, which is an optimization for looking
>  for fixed strings, with use of pcre2 JIT.
>
>  Will merge to 'next'.

There is still a test failure that I am not sure how =C3=86var wants to
address:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11535&view=
=3Dms.vss-test-web.build-test-results-tab

Thanks,
Dscho

--8323328-286019804-1561986988=:44--
