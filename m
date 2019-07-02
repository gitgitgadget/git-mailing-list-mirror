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
	by dcvr.yhbt.net (Postfix) with ESMTP id 942EC1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 12:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGBMdN (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 08:33:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:52053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfGBMdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 08:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562070775;
        bh=lvRVVmIU1p7F0Vil9csdNPB9ozd0mgg/QambcMOb7RQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NcDNihgJVDR0UxVKo7g3MfWYfAaEEs1Vtfcq+3OlyiKI2tZPbluLN5Xwvqnyr32KI
         Af2bih2zy4lzPpNL/FXlUv5KxpgG6yuXocXFxZSyNq6TQhKk+Oa4XdzsplGJdTnx+Y
         udcmwTmu9n6HTe9txqk413AOWAqcdArtCXwmj2M0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1iiWx722f0-011VFz; Tue, 02
 Jul 2019 14:32:55 +0200
Date:   Tue, 2 Jul 2019 14:32:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/10] grep: move from kwset to optional PCRE v2
In-Reply-To: <20190701212100.27850-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907021417050.48@tvgsbejvaqbjf.bet>
References: <20190627233912.7117-1-avarab@gmail.com> <20190701212100.27850-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-932313293-1562070778=:48"
X-Provags-ID: V03:K1:vAeds6CYGMUwE4UytuAjJ8ps8ePnsYIiw5TT8oPdxW4g8t4WF/M
 eKg8/vqv22W5PI/X3j+SI2TT5n78zSaTgjw9mhTy9xHfvl41E0UeZwMKpwfT0h0GU95dcRM
 I3krVFs49wH5NprXMCn/Al54S8uOrCOVQ29E5NPKNA0WegKhyp2kpLspyg6OrmZEFrG0qfN
 hp2BsCGzSQg4Lhfr49Dgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xZl09J9K8bY=:m2+6r1FOQMwgyaYeJmUe4E
 VzLpnTkiHhTGBuIYi7dU9syQ5d22RdSVutDCJCC6SpHMRdpLhO3ydWH9SxcRktfSnbdXdyvR/
 2q8FMkkKmYJv2dZfK+plRamsjcFCdsjy2WLLPi7x59nsGbReBJizLwHQTJvKks3giVJTLN8Jb
 vyDfsJsAJPLLalMWiTjcNzEyW9JmMBfW/qAmST63absQLl915IO0pAZFzMtI2Rwp856D/NStP
 6qdPLiJ89Dno5d5vzcgOR1Uu3Uz7ydblZU7alO9U7Bl1XMdodKmZlC3iM+h59N0+PeaoS4MCq
 9NYg6bHAjgr9sI7QmOtS91FVh0UqoRz0fWaLNK3h5ScBhvnVO+FJMy4qyVxDYffLIligX861E
 UNeqbAK4kxSL3KjHjsBFscfUiN7PxNaWOtHSFV/boIJAvbU1i0O1sHk9XhZI513BpvBLXHH3H
 G9uHo5BwP3EUceqxoeQ8aCbhF9G0gV1l38EK3OcYcjh/ARjwXi7OkZ+G3TMDntXuLjgAWyOWA
 ZaixYd9GsURYy3GjRDOzzxCfY36yai+zX2FGGbTV6Z2wy8MWidOpA8uCC7DdWb5zIWh+AuyrQ
 3Bn2ioFiZN8qGkQAR/vD4A0z6Ssj5sB7sjlUzHYoNEvQPa94SPmueQqfpBTERCnVAQIG7G+gE
 wMy9xTkXOi7xPSZhKSSYW6y5qh7wPF7C1AS9rR9IHdJnGETFpYiGFJOpfeUrQc/BCGOcPa0Fk
 ub8pTRr4aaSPWjhMwWgfKyLmtKuUILJMbEf038F6zY2Br5cMVqhiTjtzDUA2YXfp+ASB+teS0
 4wPKcbBzt17xTbAh62xl6xffop8fht4eNzsm/sY0xplpN30W26qfi9Bp+EKxg5ooZgVKbIkRX
 dzEMiry+Bpw1elL3yqRBIxxEdsyYkJT2FZpL98Pq4TxKCs/ISOYs8y9KdQ0sOX+wYFlfjLC03
 YCisy1Oc8/ficcf5vhXJ7Ij1YCgNswsAlxS5Jxrsgj+OudlAnl/xRcyyQOs9Pqrvi0mO/KvXk
 oW6mxWZQMKFLQQcQL4xRyKdi+hPOe1sJ++v4fJlWt/ZMZ9n17srZpFOlkmSVTaotJKNvPrE5T
 fU0hEEu3btyzMvxID3foEADTHea5KFziG1l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-932313293-1562070778=:48
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 1 Jul 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This v3 has a new patch (3/10) that I believe fixes the regression on
> MinGW Johannes noted in
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1907011515150.44@tvgsbejv=
aqbjf.bet/

Yes.

However, I probably failed to mention another breakage, though...:

not ok 54 - LC_ALL=3D'C' git grep -P -f f -i '=C3=86<NUL>[=C3=90]' a

 expecting success:
			>stderr &&
			printf '=C3=86Q[=C3=90]' | q_to_nul >f &&
			test_must_fail env LC_ALL=3D"C" git grep -P -f f -i a 2>stderr &&
			test_i18ngrep ! 'This is only supported with -P under PCRE v2' stderr

++ printf '=C3=86Q[=C3=90]'
++ q_to_nul
++ perl -pe 'y/Q/\000/'
++ command /usr/bin/perl -pe 'y/Q/\000/'
++ /usr/bin/perl -pe 'y/Q/\000/'
++ test_must_fail env LC_ALL=3DC git grep -P -f f -i a
++ case "$1" in
++ _test_ok=3D
++ env LC_ALL=3DC git grep -P -f f -i a
Binary file a matches
++ exit_code=3D0
++ test 0 -eq 0
++ list_contains '' success
++ case ",$1," in
++ return 1
++ echo 'test_must_fail: command succeeded: env LC_ALL=3DC git grep -P -f =
f -i a'
test_must_fail: command succeeded: env LC_ALL=3DC git grep -P -f f -i a
++ return 1
error: last command exited with $?=3D1

There are three more test cases in that test script that fail similarly. S=
ee
https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=3D38852&v=
iew=3Dms.vss-test-web.build-test-results-tab&runId=3D1019770&resultId=3D10=
1368&paneView=3Ddebug

I ran out of time to look into this in more detail :-(

> As noted in the updated commit message in 10/10 I believe just
> skipping this test & documenting this in a commit message is the least
> amount of suck for now. It's really an existing issue with us doing
> nothing sensible when the log/grep haystack encoding doesn't match the
> needle encoding supplied via the command line.
>
> We swept that under the carpet with the kwset backend, but PCRE v2
> exposes it.

Please note that the problem is _not_ MinGW! The problem is that the
non-JIT'ted code path is a lot more stringent than the JIT'ted one. So
what you'd need is a prerequisite that tests whether the PCREv2 in use
supports JIT'ted code or not, and skip the test case in the latter one.

Or you fix the code by re-encoding the plain text in UTF-8 if we know that
it is not UTF-8-encoded but the needle is.

Ciao,
Dscho

--8323328-932313293-1562070778=:48--
