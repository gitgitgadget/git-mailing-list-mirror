Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828432036B
	for <e@80x24.org>; Thu,  5 Oct 2017 10:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdJEKwb (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:52:31 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:46114 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdJEKwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:52:30 -0400
Received: by mail-wm0-f48.google.com with SMTP id m72so1329648wmc.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=VLC8AMI+baZ75P+bafAFOkbWezI6VoA8DDaYw0V95xQ=;
        b=jcV0ml9dMR9COpXiFF2jtlqYZwW4iky0d32LUlCG5oeNGhYMq+1LjsOsxdvwGlQRV9
         kuPGBJBR5TCyBzJ18yMorIQOU+qQNKOMSoI+dr8l8ACfVCp5NUObbPhLuLh79mCCaCVU
         loGnu/XtJyKeifnLvBSRofL2Aecd9oL5vM2sRe9F0p+JHf4QA0ZfWhMnfd6ziX7KE9aZ
         DgyZeWUpmL2FXW8eH3rZy+3T/qsfzD9St2EqeobHCD0EVaFytQZ2O/TNkOaZkFix/zWe
         PexPcziPR62jNDhqpvT2bc3ff6XHpoODmwAtEiqROz/Fc1szBls3qrkGtL3wgzyNmJKX
         wnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=VLC8AMI+baZ75P+bafAFOkbWezI6VoA8DDaYw0V95xQ=;
        b=gWGMQNNtJTcbpSg03rFTQBQgIpuMJCoe7ZJdFi1dsWlKKYRp3n+wm33+4eqyXkmXEp
         +4HyULNVPJ7mP25U+GMUdr6e+OOkEdNHDfHNFSyuJRSJ1OxevKEy6Jx3jk4A8nRZW9j5
         1LV2nHGctd4gHMWV1sdTvgp+MjylS/3kIa5J0h+r8hLo/jsDlmEe/NwWraiZaf2tLtK4
         LnjvoImaFHjpryLlATdtKZ2usnkBCLnG+EwIykcS3yBvungPxqhfbUEtqLYa50o5lxui
         wf7hp9/AO5WitTrOX96aK0e7LStKgn2a2qqOXvHmW9GShs2TAlbrRyQSesig3VvyoF7v
         ImZg==
X-Gm-Message-State: AMCzsaXP1YH1WCLnLMUYBqRSHLBBjM/2PvAgVVldOKAU0L0V01R9ro/u
        jeFIHfCakZHblXZg8z8S357LGNHA
X-Google-Smtp-Source: AOwi7QAFN5VHJPbLcLuE27FeYeEGqZvpiRt8BVHrILQRjMjxAY1aU+nhUr5TS/JfDZNzM6n0Ghsefw==
X-Received: by 10.28.152.5 with SMTP id a5mr10704289wme.131.1507200748617;
        Thu, 05 Oct 2017 03:52:28 -0700 (PDT)
Received: from [10.32.250.38] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 4sm23889367wmm.1.2017.10.05.03.52.27
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 03:52:28 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: git send-email does not work with Google anymore?!
Message-Id: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
Date:   Thu, 5 Oct 2017 12:52:26 +0200
To:     Git Users <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I used to use the Google SMTP server to send my patches to the list with=20=

the following config:

    [sendemail]
        smtpencryption =3D tls
        smtpserver =3D smtp.gmail.com
        smtpuser =3D larsxschneider@gmail.com
        smtpserverport =3D 587
        from =3D larsxschneider@gmail.com
        chainreplyto =3D false
        suppresscc =3D self

Apparently that stopped working today. I get this error:

    (mbox) Adding cc: Lars Schneider <larsxschneider@gmail.com> from =
line 'From: Lars Schneider <larsxschneider@gmail.com>'
    Password for 'smtp://larsxschneider@gmail.com@smtp.gmail.com:587':
    5.7.14 <https://accounts.google.com/signin/continue?...token...
    5.7.14 ...> Please log in via your web browser and
    5.7.14 then try again.
    5.7.14  Learn more at
    5.7.14  https://support.google.com/mail/answer/78754 ... - gsmtp

Of couse I tried to log in via web browser etc. Does anyone else use=20
Google as SMTP server? If yes, does it work for you?

Thanks,
Lars=
