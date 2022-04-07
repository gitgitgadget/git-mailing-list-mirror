Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F757C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 11:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbiDGMAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiDGMAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 08:00:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732EF44A06
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649332713;
        bh=bzvodwnBdTgLsPlg+/WN1RfwXxy4trA/63h1iw7YiAM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zl3EFsOnfGVsUzr8KlXpEVE+x49N//GpjEy4uglPJ5W6UAjH/zZOQ1lXsPY/ynCIc
         1x2VQ0Jw6t4R3OSaqp61kdxvttGxnCZqGDzY5szK8lnv1j/lKEvHjmH7KSC+Xh3/CP
         +8R8xragJAloS3dRoIDx4rRrcc83mZQwoik+7LKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.255.204] ([89.1.214.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1nSV8H18YG-00RcIj; Thu, 07
 Apr 2022 13:58:33 +0200
Date:   Thu, 7 Apr 2022 13:58:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Markus Vervier <markus.vervier@x41-dsec.de>
cc:     git@vger.kernel.org, Derek Zimmer <derek@ostif.org>
Subject: Re: Covierty Integration / Improvement
In-Reply-To: <6cb10d5e-d8f2-0d7e-a15a-4728466e0c21@x41-dsec.de>
Message-ID: <nycvar.QRO.7.76.6.2204071350080.347@tvgsbejvaqbjf.bet>
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de> <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet> <6cb10d5e-d8f2-0d7e-a15a-4728466e0c21@x41-dsec.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IZrvYkJaJrqDfdZQk7lU3atDXW/HKgnuYdtW8dhprCCuco1j2kQ
 e/sf76bVhBN00FlqFDXEGRrupvRQhTSC5rKwerUt1A2eMqumJ2A5V+/JudyNO5SwOkI0riX
 CygA3V2jdE17QX78gAZ/D8TC3bdRrbH5ScrrLTI0L4GxErQZB0hTj5V+14/Oyl5gnLefGcZ
 k2fNkUvlrip3ayaE9dq+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0py0eSORFco=:9QDRbD5ABfyN3cJhpndeK/
 INxjiN75WxwuSfGg5PiXorp4xrEYggYrJ74SOLw2gHuW3IJrFeiISyxYQYA5NEoazSq3UyPaC
 RaR3/X3RgfMFlF3YjI68e5AJLPbFxMPu0jyZzW5GGwSsNFXBWKZLeGfPjmU3r7xQQgQtwk90z
 nbI4Z1WNLxTyMCtF5havbTo4TZYXkW9OH/6PglSfpVJK4TImGyU5waSeJPOssqHHsQQ/xnrGN
 ArRCxkxs5vBWQ/E0nM0/VOjbJXHoZKJqFratjwyhlufx1HxmNlLQcgawg4FnzkgJ9E/CB/rGF
 dJx1uQ8kO02PmH3dL2a4PYjxN6guLShKa2cdcHUSI+gPXhRwIl5d39nG2JfLHLDpZayYZ/GvW
 eXbeSwXBKU3Tsuzad3De0opMBvmjnOjpaCGmPDkQ6dewcDSLA5mjiyX5h6F1O0O9Q5TjpISa6
 68Zti8g1RKKrf12MhgUv6IyAsgdbOAYFw/J/r/AFt8BrhF7noX5tCiMmXPy9jkD2ZFyuGnqye
 CBWT+o8LS2JSA2UWdkZMH8mrKBNcgjvmYe1SxwJyTPiMyqpcCU9GR612UFphWxj/keZ2YBvAp
 M1Z9jqKI+QMe/woccKNKTdTKjSFbbzmkgebl6Y2cG0KMjD/LfDRFIoT6/MdsrxEn4A9FDcKOB
 5McKZpxf2XHC8995XAyE5O/vHLhT6UkDjQ/zOAXvOfpJKs7uf8VNKKJ6XXxyTkNwaFcGnuldJ
 6ZSQKdgOEGf3IMdHRhNW7fzgnYnEqspqmolmlfM6LiHnyaW9utYDC0TC6lAqhDdK0xrPfisOj
 oyCKdrX8Di8nMo3AK2Bvn6C+EkP2kl1kxgkMEGsvSW9B3dYrKkv6uFQvQc1T7LZ3xS3MwAMA4
 wDfwCrmOf4Ownmf2CyjKYIwoWif42NJeGC60g9sJjN+/ph3nn60EcpAfuO6Cs8RwmTPoSN2mb
 7rHaDe849lzJWLExe9/dodx13AAiztbVIYCAgYC5q+lrhTHCEqgSc24K39M2gVfXCdoVoDblB
 OJXgjtDdXF2LDUmzN9adkYGsKLNE9m4ZWpQWuczE9ab8Cq4Wq9YDG4M+1NSpwyzixx05Pnz0n
 AkV2kpD2FZJLBg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Markus,

On Thu, 7 Apr 2022, Markus Vervier wrote:

> On 4/6/22 00:17, Johannes Schindelin wrote:
> > On Fri, 1 Apr 2022, Markus Vervier wrote:
> > > X41 is processing the current RfP
> > would you kindly provide a bit more context? This seems to come right =
out
> > of left field. Is "RfP" a "Request for Proposals"? If so, I am not awa=
re
> > that the git developer team submitted one...
>
> thank you and everyone else for their comments. To clear up the context:
>
> The OSTIF (https://ostif.org) is organizing a security audit for git
> and one of the questions was about Coverity and if the results it gave i=
n the
> past could be verified and/or improved.

Thank you for the context!

If OSTIF can help us get better support from Coverity (as you can see at
https://github.com/git-for-windows/build-extra/commit/23eea104 I could
have wished for a better experience there), I am all for it!

Out of curiosity: are you (or is OSTIF) affiliated with Synopsys somehow?

If not, have you considered if you could help us getting a comprehensive
CodeQL coverage instead? Theoretically, CodeQL should be able to do the
same as Coverity, while allowing us to tweak the analysis in a lot more
powerful ways than Coverity (most notably, it should allow us to reduce
the number of false positives rather dramatically).

It is the number of knobs CodeQL allows that has looked too daunting for
me to give it more than a cursory try [*1*].

Thank you,
Johannes

Footnote *1*: I had played with CodeQL last year but was called away to a
more pressing project, therefore this is woefully incomplete:
https://github.com/git-for-windows/git/compare/main...dscho:codeql
