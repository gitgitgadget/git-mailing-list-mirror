Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207ED1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 19:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeDNTga (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 15:36:30 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:42452 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDNTg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 15:36:29 -0400
Received: by mail-wr0-f172.google.com with SMTP id s18so15888223wrg.9
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=UYM7oxisisha3LPzgoPaspLJIzRClfUGh3VkvbPVHNY=;
        b=WUMyl+hZXXMjzGKJQnQ0th9jgwQb5QT5nm1h6/yq7J23XIZw/SnjlP+BRcJhbTR1Lo
         BjiPzdhHxmNgykveDyICuP1YmurfwaFTuz1VC4i8w3g4HIbm+pR4DYdulLgLGx6iViVe
         xCkbpmnpFjZOYP8toAvmTTlcyNL0C5IsilrOWyYxypjSINbMMUOr0gjCiuMOl6j+7m1F
         sZ8E8/2Sd9MMCjjrkL19UVcn+AJHW0OOXGQ8a4Osyqtgf719rBEO5fd6TXTrjPVRB3dL
         dE9ITneRDMloLyMwRs/DiUf/z4wRcbkRLowIGhQn9LpgYn110llSz/siM/GVDZKV5Cyu
         1Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=UYM7oxisisha3LPzgoPaspLJIzRClfUGh3VkvbPVHNY=;
        b=Zk12HF2BF571FFl5EaOugj6h/rkvcJ+k2laEIcge1MF+ftl2REGQyXvrC2lNmCyRIS
         FbIyRLKYmTga9vzXWDTnpmcorX1yYYJNnb0DD0vNT1DEQ4mooNaiCrUVmKSyarbMXTnZ
         fq3MhRctL7JOvBoiaEmUYABUmdZ/3vKPOz8ztJmvIGIFHlywCIbmDUwdsNCVSE3pjaY0
         DiVX0M7lsVLFXnmE193FtJZA+J51jjfyS14360JUHcCJ5DP2+jcEbVqfN5EODsHC/8h5
         C+SkxCmZdrLNr/oTp+Ep7T5ixBcktDtsYXun5AMoMA9/JQp1AaDxtVPIPcGelrod9edG
         1JbA==
X-Gm-Message-State: ALQs6tD/UZW7i66qRp43V3dsK3SMopxgwRuhofvTpRAhf4F9Krj4R3wE
        yp3rc5MdbM3ODpxgoNX/+jQ=
X-Google-Smtp-Source: AIpwx48k0Fe4G+xOmRqAq4P7HP6X6nJtY9mag01kO4O+dUzhmoBkWn0k/w6TSD8BPeFN50ED6unJ5Q==
X-Received: by 10.80.155.6 with SMTP id o6mr26306014edi.280.1523734587632;
        Sat, 14 Apr 2018 12:36:27 -0700 (PDT)
Received: from [192.168.1.7] (ip-62-235-59-112.dsl.scarlet.be. [62.235.59.112])
        by smtp.gmail.com with ESMTPSA id w16sm1984982edl.24.2018.04.14.12.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Apr 2018 12:36:27 -0700 (PDT)
Date:   Sat, 14 Apr 2018 21:36:24 +0200
In-Reply-To: <nycvar.QRO.7.76.6.1804141423530.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180414003338.27091-1-layus.on@gail.com> <nycvar.QRO.7.76.6.1804141423530.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] tests: fix PATH for GIT_TEST_INSTALLED tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     git@vger.kernel.org, Jeff King <peff@peff.net>
From:   "Guillaume Maudoux (Layus)" <layus.on@gmail.com>
Message-ID: <CBFBD662-F36A-4C5C-9320-15FB5A13E3F3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joannnes,

Le 14 avril 2018 14:30:38 UTC+02:00, Johannes Schindelin <Johannes=2ESchin=
delin@gmx=2Ede> a =C3=A9crit :
>Hi Guillaume,
>
>On Sat, 14 Apr 2018, Guillaume Maudoux wrote:
>
>> From: Guillaume Maudoux <layus=2Eon@gmail=2Ecom>
>>=20
>> When running tests on an existing git installation with
>> GIT_TEST_INSTALLED (as described in t/README), the test helpers are
>> missing in the PATH=2E
>>=20
>> This fixes the test suite in a way that allows all the tests to pass=2E
>>=20
>> Signed-off-by: Guillaume Maudoux <layus=2Eon@gmail=2Ecom>
>> ---
>>=20
>> This is more a bug report than a real patch=2E The issue is described
>> above and this patch does solve it=2E I however think that someone with
>> more knowledge should refactor all that chunck of code that was last
>> changed in 2010=2E
>>=20
>> In particular, it seems that the GIT_TEST_INSTALLED path does not use
>> bin-wrappers at all=2E This may imply that --with-dashes also breaks
>> tests=2E
>>=20
>>  t/test-lib=2Esh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git t/test-lib=2Esh t/test-lib=2Esh
>> index 7740d511d=2E=2E0d51261f7 100644
>> --- t/test-lib=2Esh
>> +++ t/test-lib=2Esh
>> @@ -923,7 +923,7 @@ elif test -n "$GIT_TEST_INSTALLED"
>>  then
>>  	GIT_EXEC_PATH=3D$($GIT_TEST_INSTALLED/git --exec-path)  ||
>>  	error "Cannot run git from $GIT_TEST_INSTALLED=2E"
>> -	PATH=3D$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
>>
>+	PATH=3D$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$GIT_BUILD_DIR:$PATH
>>  	GIT_EXEC_PATH=3D${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
>>  else # normal case, use =2E=2E/bin-wrappers only unless $with_dashes:
>>  	git_bin_dir=3D"$GIT_BUILD_DIR/bin-wrappers"
>
>This is essentially identical to what we have in
>
>http://github=2Ecom/git-for-windows/git/commit/e408b7517d
>
>So: ACK=2E
>
>You might also want to go a bit further and let the test suite run with
>GIT_TEST_INSTALLED when Git has not actually be built, but only the
>test
>helpers=2E I started something along those lines here:
>
>http://github=2Ecom/git-for-windows/git/commit/a80f047abc5
>
>I always meant to come back to polish those patches and submit them to
>the
>Git mailing list, so: thank you for getting the ball rolling=2E
>
>FWIW my use case is that I want to test a "MinGit" package, i=2Ee=2E a
>subset
>of Git for Windows intended to cater to third-party applications
>requiring
>Git functionality (but not requiring any interactive parts of it)=2E
>
>What is your use case?
>
>Ciao,
>Johannes

My use case is packaging git in Nix=2E We were bitten last week by the 2=
=2E17=2E0 update that modified default perl paths, and we broke the package=
 without warning=2E See https://github=2Ecom/NixOS/nixpkgs/pull/38924 for t=
he install tests and https://github=2Ecom/NixOS/nixpkgs/pull/38636#comment-=
380712557 for an idea of the mess we created=2E=2E=2E

I first tried to run the tests, but it turns out to be pretty uninformativ=
e because everything is setup properly in the build environment=2E Plus you=
 do not expect meaningful test failures on a released version=2E What I rea=
lly want is testing the final, installed version with all the weird wrappin=
g, hacking and tuning that Nix requires=2E

As a packager, it would be nice to have dedicated install tests (integrati=
on tests?) that check the setup of perl path or the ability for got to find=
 libexec executables without testing internal features=2E But we cannot req=
uire that from every project=2E

Running `make clean` before running the install test would be a good idea,=
 because I have the feeling that the current implementation of GIT_TEST_INS=
TALLED relies a bit too much on build products in the source tree=2E Or at =
least that tests are not clearly separated from the build=2E

I will look at your patches and would be happy to review anything that you=
 deem ready to upstream=2E

Cheers,

Guillaume, aka layus=2E
