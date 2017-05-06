Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENCRYPTED_MESSAGE,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8B1207FF
	for <e@80x24.org>; Sat,  6 May 2017 17:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdEFRqR (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 13:46:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34283 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdEFRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 13:46:17 -0400
Received: by mail-it0-f67.google.com with SMTP id c26so3840968itd.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:cc:subject:message-id:date:importance:mime-version;
        bh=vlkNJWQDzUGTlIzH3hXS129wvkinIG0ns9VeYwC8V2g=;
        b=awOOR3iBv8377hn0PLvQbEPMVmMXybKq2JLSug6X1qlY+VwghbEaGGXz66ai2c7rtC
         eDJfO/DWZd/XqsyJRpsN5QsFiPcn6gflzrQncjVNZG8iJ85y0TjQKwv7X/WZDEJpkgJp
         TDymvDjLhE11SIUl1bHd5+GnXbp4Ajl0OzWTVauaNMDioyzlnIpRkV2Un2ewdmvVQKfz
         JAyYqymu/KaoM/V/w26FRbWda4Oh1zBpChRfi8ASZhyLsQfG9bVKW4VD2wNfo8D9VoHK
         P42CKQjC1IOk39kmYx2PJpxPbX3hAeiY/w/8USvflQMikH+nl1nQAqU364QVc4rJL1e2
         dQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:importance
         :mime-version;
        bh=vlkNJWQDzUGTlIzH3hXS129wvkinIG0ns9VeYwC8V2g=;
        b=PZq70rO6XvwpQDnQeYEAHBFP27EWpyEfoy93h2cALf/wgj1wPF6X87lg6GJVKekifD
         8WD4yrLN8pnrKhD3FQV0dB0Gn8Dz3dbdD+y2HAU16jpuDWjwpeIY4TIGj7haohRmixEI
         JMtY3X90neuebstzPJdTC9yvM66xZabhvxPXSacddxX7+UKHAv0/sItQN+NRDlZgNk3q
         vKwqcFA736IkZIRRtdQeqm59kpALIkqEGLMyvUw4ZMn0cQ86AS5tsow7Ax/RFD4wI4ZZ
         XCp9E4l9yyh32ndh9HKt5/A5lSg4yW18GpI6kagr3ANceGi25WQ0y4A8/1TMVqiMOMda
         jgZQ==
X-Gm-Message-State: AN3rC/47a9qwtksTEcG2wbP6kyf1JHHlLmBo8o7qythqIC24nmrOxYtK
        BV03ETZt0G8Dgg==
X-Received: by 10.36.31.143 with SMTP id d137mr14878510itd.95.1494092776451;
        Sat, 06 May 2017 10:46:16 -0700 (PDT)
Received: from ?IPv6:2607:fb90:8b7:ad9a:0:45:d376:2101? ([2607:fb90:8b7:ad9a:0:45:d376:2101])
        by smtp.gmail.com with ESMTPSA id c62sm2502951itd.11.2017.05.06.10.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 10:46:15 -0700 (PDT)
To:     peff@peff.net, Yonathan Phone TX <tiradojonathan32@gmail.com>
From:   Jonathan Tirado <tiradojonathan32@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
Date:   Sat, 06 May 2017 12:46:03 -0500
Importance: normal
MIME-Version: 1.0
Content-Type: multipart/encrypted; protocol="application/pgp-encrypted"; boundary="--_com.samsung.android.email_81951332723789"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----_com.samsung.android.email_81951332723789
Content-Type: application/pgp-encrypted
Content-Transfer-Encoding: 7bit

Version: 1
----_com.samsung.android.email_81951332723789
Content-Type: application/octet-stream
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="encrypted.asc"

-----BEGIN PGP MESSAGE-----
Version: BCPG v1.45

hQEMAyMKgIfmQxojAQf/UX0nd2y+HJEZs4fzS0sxj85JY7UkNyy2LV3WvAvyPMAN
IC/gOuZ5zrgkqzukYqXz+N/lXQeLSkIRwS9G8CbfdQc8R5fLUnQsCg9lnnGKudTa
1BP67nvVwJdgPmTr5cD8DbavEcxnPG5vYQqJaBXr/y5CH+Sq4wLI0OaZogqp3aDf
VOl1Vlx3MLIDeCrjqL6rebdHJy2SLPA5Pt2SgrdsaDsRnqUIhZ1MgZUafKV3imxl
GtlXFGt82+7nr2RwkoAS3/uHkvJjm5mWUfNh7YFRhurvM2pQ7e+5iFvXJpUSvsRb
akPeRjHfjGneQskCD7JPAsOyV3OgURRHq/At9G3b+4UBDAPt4kR9ij0SOAEH/jyO
C33ZvK718eigblO04WmAEA/yk65gCBF5icrWEfrBs/3wQNOOGsQDVZdV5C/fKTBt
IRq+pC8vJo+GI1yk9KSOpG3yEFB+RNO/mWLyIUL9mSxtlBknY54+a68GtC+D+IU8
lgzZNB/icO314twykmVYnyLvapxU5PRbyhFXTmNSeHciknnMWoxZgtrHOQir4B1x
qJK8ElcBv4M7fdR+mb/b0WciYOKDCJoUyIsz8zKkRn+4Sk1mDoTBbbF00VD53cfT
tT8qkbRn42nHoeSXIv6KRsrwVIulS89d2t+feWKzuXA3OMgQIDCqMpQ0okdjWz5w
gs0akrAbuIUxEbuEnUGFAQwDnu/cGBRQLt8BB/9kt8dZ8NJgJJxDrM9RArDbnPZI
5I5WT1tGe1gnF/mOwjnU4EGKcdw8nuBilDf08WalVcRm5fAG2MIJVrE7FJsNETqY
Zg02VX877cPSIH6vlmJLc7dPp2f71Hb5t1HZp5g0oODh6nI/+uKAZdCGfObxenE6
4UDrJYwMm0XD5uJbMYvMEIGu++a6bvD6VzbzHIg6hQ5BKgJuCyzIlGvI2dqbgXVh
RfJh4ZSrRZ7YVa8LB9PJXLFYw8kg0UZ8e1rh5KHj3zEFmFDB7z2/gvtd/CLhym4N
m7o6tsJZmN5Wxn32PNQ7MaafhaOG7uoXOG6hRWiwToyygnm62qkkzERaFLYJ0sFt
AQXyxyH6zOyPDYWwRT6WXL1RMoI8ii/nXbp9KSh7rb0JnWfgzuWN9U86S8/z8HlC
NTDWG2nutw5pK7PYLiKlGAW6ljq5JtSs6mrkPjwXGM7hw8upTndlnI9CtxEgDKP1
+v3JicKuSK0TW+hgsM0oaX2dDd+ZXKtv+cjs2ZJyDHusYatSXYFn0jKVyxxKGGpZ
Jl2eTckrZC5+aj5I24WzqPiuX4DHS4sAD0CrCT0ZNxDp1q10DduLTiaalS9q+TbN
03lRFHR/ulRcSWdlxVpW+xVs3VDXJfaTS5MTlrugHnS4JepyrfpMRhm6w4IWWF+J
lOBEqZ83yviFtXDtCj8kGq18lpLFA61ZRcpy/Ix0bb6yfnju7fTOJ5DRl8sP5g+A
FQX/4DBEvSPXBKNtmL67MdNgp19CTCxgMfYxvO+U/rkUB29XuUmGcj4LvCNl6JWF
iC+fKSVRrDWQP2myNYdzzQdrGVY3BAzwlEYg0OKHvxEhMN3oqVz03DFyIU8mKOf3
kIowevtJdPngyjfYTdUKSq7Mv/+uBJ6PCkTXNDGrUPL3a50Yr2UFeXLaYZxQef69
Tj583+KxdIXfb7RszHc2VQ4Kj/bopg+VQuDOD9iyb716k9twZqe/fCuK3CHRkog5
ax8YZvgn5B5DQ7Rtoed4c35fr2QtK8e5AdCNtkVj0zSjjiPiAD4tYTiVT/ainyfc
0mHj/DuNrtjcHeu2L3MPMk021Qajm0eUvoHuE+A=
=zc7p
-----END PGP MESSAGE-----

----_com.samsung.android.email_81951332723789--

