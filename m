Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B044CC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9070F60EE2
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 15:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhKLPIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:08:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:43341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhKLPIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 10:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636729557;
        bh=a26TB+7wVs+jUi9InDL2TnZuoZCorPLRQhb1z245Fpk=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=I02EeAxR1xLzs67LQ7dx7nbrfYZlBwo+xrTijvlMy2PAyEKPYAfKm+9yAeaOdSTp7
         LaRIbw2d4utE4jvsa+vmm30ktIq7kODM4bZ5uzj58rLqhMPkyl+7AO7Kj19Kr6847u
         pW87mE1tBHmpI1BZn980eObtWwjwX6tdw6pFtwB8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.14.2] ([109.64.190.68]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7KU-1mrdk62lUw-00BemQ for
 <git@vger.kernel.org>; Fri, 12 Nov 2021 16:05:56 +0100
Message-ID: <04cbce68-bcbd-dbb2-5d9d-df7dd464fa03@gmx.com>
Date:   Fri, 12 Nov 2021 17:05:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Eyal Rozenberg <eyalroz1@gmx.com>
Subject: Feature request: Ability to edit existing tag's message
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OgkwKX/LK94WLMnm5esooQHKa0xtlEf6YfUc5BuerfEbXC5aaid
 gnfm5CzVxDpq3CG/6Wgmg/SOTtmD0lkoVl+SjcTOWy3iznj08VktR28S7mxUuSgJr3cOLTn
 thJNn28Zo+c26oGCMdOgdztuLZpH0n30Q5lBDTiW/mxsqD2UDJ+TBn1TmpLs0WAohkbPiJ4
 m2ySyS0FLKBhexDG/f6GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QjkGfRf/a2w=:XxEt5YcflleRL4yNMNS9Ru
 vhUIbo83dQ6CDTCFyCl40f6+1f8N7ncvpJ0lwNoj3widxjt+2Eluoyhici1ffQLFvLaLY05X6
 kH06B7/SmxwfS/VDfTMvKor2pjuQJnkvWVmmg6SzBqhCLTQfQ8LrUlz1e7SPQbgbRrcnmOmVP
 ULP3LnFrFan6MytvMFHaifiYv78+peKMcm0oqwucYfhThtaTdlYGjJLmHeGVLnc68aLGPXDfR
 yVcB7HlHw4kUseimH7XRLEHc2x/TRZ5WyAMB8V5pXhcqRGydF2H1IAGPnu8hCmC74Vqt6oDaZ
 Dh1Q+QYOf0vxxwzFUCG3dWyZVlqF/dJlThu247fL66QtZQzE1LadzuryLjOZMpA6uQFm+rZLy
 DK8zdAf2F868GbAPPAcvYA80RzYsY2TOSKj4yMcAXdqoJXx09v8Wj/00BK873aRBdWO6gcqcF
 LnCySUbmR/FlC38DvHd3R7vnp2Amjiw27zXqH6bZxKaNASSgwkcuVf2pd6P4WSqtxpZhk2ZsO
 5dOtLOEq6unJ7IX8+lX/naRB5M9md0B4lHvrP/fGonLfd5RqOldp6IxlnV2lobnCV30/FXx/p
 mtA19+hrigiA+yTggDdQFwkTXz7VlOVNL9PLANqXXFHc5L2GllAE7cKYZ9FMIXzH/WrvoALIR
 YFJFdLDpofI3d8rDlJ7ePfJ1R4ZP7JpEZLAo05Df4SxSouluFSWMuQeFqdc9Fm4nrxHCWLXlN
 zS8f4psuT+rXV0CMEzhm8jbzqx1D2vldVp5nfePsX0u0QaST0C31o34rtqRYxXgu/BR3DL/Kg
 Gy3JNFWRO4gkFn8XVZW6cDmnUo1Lz0hIQJYjUoyHAtiIsPGEymrJd5/sG21vAmHO1QSrm7Py5
 D2osZR9zlYqrr+1WD2wfkazNq0bnsaWhcWbZbTXhy2B5uiyHEQC/hJj59yPBRHJK2mEbg6N/e
 SzvxkHwvZEZUHMtEuG3ZBgaPTFF3CMSsouSUpUavVP4TPyGuVGcxY6DWxwERWiSrvgp8lxEp3
 sanVwl6diLTOQgE+haJCZPd6i2W1ZlDPr6pz7wNFrAa5EF7+DGjy89+7dk0m4s0vLrcQeIPxB
 s2eGGYsF0tYXqs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the moment, one has to go through some hoops to edit a tag's message;
see discussions here:

https://stackoverflow.com/q/7813194/1593077

It would be nice if:

    git tag --edit my_tag_name

would bring up the editor with the existing text of my_tag_name's
message, for amendment. And, perhaps,

    git tag --edit my_tag_name -m "new message"

would overwrite the existing message. I've suggested `--edit` since the
switch already exists, but if you like a different bikeshed then it
could be --amend like git commit --amend.


Just my 2 cents and have a nice day,
Eyal Rozenberg


PS - I'm not on this mailing list, so if you want to reply, please use
my actual address.
