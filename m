Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044ECC32772
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiHPKTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiHPKTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 06:19:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536A840E12
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660640218;
        bh=g+RQPRybAix2f+g4FOThvyed5glV+rj14SkhB0ouWwo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SaS3bprH2AF3xS6foiSas8wPlDQOQVEDl5g6aJizrU+7q9aTvBr1AmS8xu9eq9i+0
         J06vW0JKcakQRPbU/2N5eslPSYANZoALmkYU8EwpYu8ZqcKg+EWvFKRKp0CiJin7l4
         uGHZnmCvARiEbJjcsYBRUlgsuYBeee9Kpn3RxZ0s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfJd-1nVDOP0KlT-00vAxT; Tue, 16
 Aug 2022 10:56:58 +0200
Date:   Tue, 16 Aug 2022 10:56:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022, #05;
 Mon, 15)
In-Reply-To: <xmqq5yityzcu.fsf@gitster.g>
Message-ID: <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr>
References: <xmqq5yityzcu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2138905018-1660640220=:241"
X-Provags-ID: V03:K1:nZxXxHd3OSM+CwL0zJ7W8BcHoKT1g0h0DA/ftwz93xPhs0qD7VS
 Nyd4GPUQI7/JsgPv3HjrDO9KRgo/5jaDKfmYMMTmx9UciQopxyxqEx1wXojAdbjGfgrzb8B
 aBK5avCcDlwCCXbs6/BB6dLdxrfTQsDAYQycUQ821VIb5LQRNBjN4CjdxzQfOHWOLfXJW1a
 wrTBXJAD1+ThPl0Zw4Pxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uVvFqN29gKc=:MQYTls+rimBjWSmcKKbd7f
 Qg3gTyZ6RvW1hvX6rJ2QOK1cWdk7/iWFpOivKRk+DYkl5zG0OQZbTWVokSnHsMkAt3xBpUFw0
 Oa6QHMD1Zc5WouOzwEgQBk9BYAyKGbhiDHPa8ESmoTE4z/2mQdlvh6jnJwmwpaSbTFj6JKDjl
 5AkDeBQcGN2E5EJhF+Kyt0zDshDZL1dbExdxXF3R9qZAEBQ3bX/wL35jizlrhLEz5QtySP4Zh
 BWNfmTtt208qNf2lEs2FDKulUeLiEierU221Q03uW30B7Ve4R/fdUjc9qIsxu1O5er7Tg+JH7
 //91obB0Mp9pqODNGrWnhzpfz8CNQRVgb1il4fzHmbbQXdzgBFkpvuHK9fcMoxSCJUhMd8bCJ
 K1UFZW9ItLJzkrZRU/spc9dMtKsYtbLwhu2si8PLW6pl9L0JrwcTeptNvfxbHrCPSkeF1iEls
 99/6pRGkFSD+F6NFHc/J12IJOCnbJv5vx7zcn99nYn9PtKRiWeSeH2PDIfEXmzCa3GP9Ykv0c
 Jw8nAVwuH1tyn4y3uYY8dc+KHdbbw9RuwGkCX+e8lIxbrsf4FoXF4x8/wuDzX7ImvHqZZxD7Z
 sVDG9oXI4HaaV+KCM8G8Mn2bmV0iNnq0QyZh3t7SPXBj5YlXZq/vAjNY6IkvbXmXRhbbwsghD
 r1KbDjnWiNiSh4lNRzqdsxneUmPpeHUeQN+4r2GuMVIwMy4QJH1L+bCpIEt3p7ilnGdBSmar/
 8lLxjcp6/4sGcCYrljd4pPePedCAeH7Ydlf6HWlbxemL8q+ZnrzCZ1xMU8SmPpk6aEiHvYQld
 P6Vyfn75wxC/h0NOCEVOyIcsQWcqrpv0q+jcYnfcSgqmwQ5+KEuqfYqdZT+SpkVAzG/5KNBx2
 GCLxyjc7eFjYs5N5DUnloruGODjT2to5zMSNt4NqB2mr/DTFZtmASaxGMeVaN/adrOVrgHNZC
 puwATNB7x1tjqou8w+v9YJXIWZmET86z7Zfp+C9Eywg1rbsHqt3im0cVWmgOqthKRP6jp/tkD
 5ir4YAv0EYCpxJPXdDQ334wCxxSBJfSrcf6LZ4Ew3tc39dGxTzc6k0EK2u4BWthkn1BFZURKA
 D8/v1JFQ5+vJ//Lrtg4XXQ9HE10+xknIAoaOaEU6U/UammOy9wvrxSISw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2138905018-1660640220=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 15 Aug 2022, Junio C Hamano wrote:

> * js/bisect-in-c (2022-06-27) 16 commits
>  - bisect: no longer try to clean up left-over `.git/head-name` files
>  - bisect: remove Cogito-related code
>  - Turn `git bisect` into a full built-in
>  - bisect: move even the command-line parsing to `bisect--helper`
>  - bisect: teach the `bisect--helper` command to show the correct usage =
strings
>  - bisect--helper: return only correct exit codes in `cmd_*()`
>  - bisect--helper: move the `BISECT_STATE` case to the end
>  - bisect--helper: make `--bisect-state` optional
>  - bisect--helper: align the sub-command order with git-bisect.sh
>  - bisect--helper: using `--bisect-state` without an argument is a bug
>  - bisect--helper: really retire `--bisect-autostart`
>  - bisect--helper: really retire --bisect-next-check
>  - bisect--helper: retire the --no-log option
>  - bisect: avoid double-quoting when printing the failed command
>  - bisect run: fix the error message
>  - bisect: verify that a bogus option won't try to start a bisection
>
>  Final bits of "git bisect.sh" have been rewritten in C.
>
>  Expecting a (hopefully final) reroll.
>  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>
>  source: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>

I had another look at the thread and did not see any feedback that focuses
on the actual scope of the patch series. Conversions from scripted parts
of Git to built-ins are always a bit finicky (and hard to review, I
admit).

Therefore I would like to move the status to "needs review".

I do not think that there are any major issues with it (=C3=86var's feedba=
ck
notwithstanding, it focuses on tangents that should be addressed after the
conversion, to avoid losing focus), but I would love to see a thorough
review of the conversion to avoid obvious regressions like the one in the
built-in interactive `add` I had to fix recently.

Ciao,
Dscho

--8323328-2138905018-1660640220=:241--
