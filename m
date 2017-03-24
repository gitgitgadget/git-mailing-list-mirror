Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790851FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 12:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757143AbdCXMf5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 08:35:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36442 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756648AbdCXMfz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 08:35:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id x124so215348wmf.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ttDp/G4j4METkFJYuNX8DlJ1WudlG/Fc2ys3cIDVszg=;
        b=WPkJFhlxhftmRipIwTtw5YvG4kdHieI01DKvX2D4yfrBYTktmjLo8xVTZvyGEyiFf1
         9iIdLjQKxhLe+gDt9P9QXqgCcQdJNngF3qGaXqIk+j5b7HIP+YsblpYh6Wh7dpFS2m3q
         cHPDTfJV60F3wTyJ1X6vHIu4d0a9AULnlZP0MfQTpCU8HYmUvXEqlB4I7V+vEiXCDeQo
         tzTtL5E/qPtQ0+T2/RneC1pfRJuBHOBAmOxb0WOPIZJSW3OMhVaw2vhkOYLOxBvd4YEK
         QNe8Iv+Ji+Kgtzdi8ptmw7nRSAqif+gBlpLTz0dLFZeXGl7y0a8kmDZqDylc74pYvlf6
         YYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ttDp/G4j4METkFJYuNX8DlJ1WudlG/Fc2ys3cIDVszg=;
        b=ajORTm8g+bJ6L+9zsXKfyYCLnU04drKxamiObwQ+pMIlhC/nD57bE+D1vMe6JXodql
         3doxymVh/lCg/YuiD/b7/30HZNFtj10Eh980q8yQFjz+f+GLdXHslnwbSf5O+Bjomcjq
         bQWxS/SG1hXt6wJVrp39ZpHwQH5QlF2kJLqDHs5++CA7cYFwQjFOHiXfrCeNWegnG5Yn
         u7nYT+YXC8iZusbWnLrjaJ5UuOfcnwXI65Gf8LspCvu8v70tlvYVa1emha+ZM1ob/87+
         D4SOnbp88fS3KTI7NR609Anzfz+ot1G1cDHxDJLn77u7l+6JMWJJm3VUTdTA7QMKOHeZ
         Uwhg==
X-Gm-Message-State: AFeK/H14AHYqt9TAc86KZu6UW1FneT5eE9FHHej6JZzawDJFtk/0gQdO/unJvdN+QrsW7g==
X-Received: by 10.28.37.3 with SMTP id l3mr2892666wml.100.1490358953695;
        Fri, 24 Mar 2017 05:35:53 -0700 (PDT)
Received: from ban4wcb152r.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id j34sm2738129wre.7.2017.03.24.05.35.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 05:35:53 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] travis-ci: build and test Git on Windows
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1703241242210.17768@tvnag.unkk.fr>
Date:   Fri, 24 Mar 2017 13:35:51 +0100
Cc:     Git Mailing List <git@vger.kernel.org>, Johannes.Schindelin@gmx.de,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD7E9F8C-77CA-44D4-AEC8-CEACD0528E3A@gmail.com>
References: <20170324113747.44991-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703241242210.17768@tvnag.unkk.fr>
To:     Daniel Stenberg <daniel@haxx.se>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Mar 2017, at 12:48, Daniel Stenberg <daniel@haxx.se> wrote:
>=20
> On Fri, 24 Mar 2017, Lars Schneider wrote:
>=20
>> Most Git developers work on Linux and they have no way to know if =
their changes would break the Git for Windows build. Let's fix that by =
adding a job to TravisCI that builds and tests Git on Windows. =
Unfortunately, TravisCI does not support Windows.
>=20
> Forgive me for bursting in and possibly repeating what you've already =
discussed. I just read about the limitations for doing windows builds =
via travis so I thought I'd at least let you know that you can avoid =
those limitations without too much work:

You are not bursting in - I am happy to get your feedback! Thanks a lot =
for CURL BTW :-)


> Two alternative approaches would be:
>=20
> 1. use appveyor.com, as that is a Travis-like service for Windows. We =
do our
>   windows-builds in the curl project using that.

The Git for Windows build and tests are *really* resources intensive and =
they
take a lot of setup time. AFAIK we would run into timeouts with =
AppVeyor.
Maybe Sebastian or Dscho know details?


> 2. run your own buildbot and submit data using the regular github hook =
and
>   have buildbot submit the results back (it has a plugin that can do =
that).
>   We do solaris-builds in the curl project using that method (thanks =
to
>   opencsw.org) and some additional windows-builds thanks to private
>   individuals.

We could do that! However, the idea was to have the entire build status=20=

for all platforms in one place.


- Lars=
