Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6F71F405
	for <e@80x24.org>; Wed, 19 Dec 2018 14:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbeLSOEU (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 09:04:20 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:36695 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeLSOEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 09:04:20 -0500
Received: by mail-ed1-f49.google.com with SMTP id f23so17059197edb.3
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 06:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ZmhTCEB2wRrdpLuJ0gnvGeJGKIvfI7uTu4L7wjYJHYU=;
        b=SByGekxvoxH7MjzGIFAW2Oykr7LKlWU3qPGyfoMKIQas05lJb6g21z+rznwZr79eqo
         mlQgiMiYUk3VLBnSlyPG5eYZlA2QnDJIVBmKJwWLuuTmdc2+gqQl53ZMfS6sHeQrCd7M
         /vYm3xw5Z8TV6hHSphEMOtJPJnaWHDHkqX1mWZChYzhGeFXL1rrt43O3TYako8D7e7Wb
         jUEoYEGOWQ93dhF8LmAjScsCLNgFpHwL8hWGKGHmDaCRm0ZPlfdkoBXDItDK9W73NCTl
         2RYXTThbvtElnkA7Qmk0bB8SlFE/MebnlJaYya3CAXGPDZonMCaPIl16Yv79y3pWMNna
         bbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ZmhTCEB2wRrdpLuJ0gnvGeJGKIvfI7uTu4L7wjYJHYU=;
        b=eMc2gomZ7aE0Zm5CPTeUI9mK3cHaxolWjUFoDJGMtiU372UuLs6/63FacTOMi73epk
         p1Sl7Vm0Of5DcSsvQgIO5phyP3pfaCZ5/XqyW//Yfno630GqU6xKIGLz6yW68L7/OCYT
         j3R+h9c8ZU5uEyxeB2srqM2Ncl/MdiXXDIH2HTSdTkq7VF5HRpv4CV1bLGjb1UWU7DWl
         CigY5kzJFSmzwDK0eklKTBGvcViYwIg+KrS314ZKjKWJ0km2/M91wowV1AmCADPcWAr1
         S3WBmNx9Q95CR4XcUyVIwn9sFoBXGmN2oQ25IVwxAzRxG1ynrpaXdkxPGmETBnXMkcbr
         zYUQ==
X-Gm-Message-State: AA+aEWbUJt8ezQmOT61MTuKVASpq9BuDZFiBy9WiI6Gzx1sNSJbR5+Vo
        zogifOVAN/Q75SHf27UzFgY=
X-Google-Smtp-Source: AFSGD/UAInwWg0YiBWotcH2vR/1o6+vjRtMKtKmGMV6lK/AWo1GzX9kpc4WSvPTy5xv4+JsacORc0A==
X-Received: by 2002:a17:906:7751:: with SMTP id o17-v6mr16343753ejn.15.1545228258444;
        Wed, 19 Dec 2018 06:04:18 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id k31sm5552986ede.5.2018.12.19.06.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:04:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Referring to commits in commit messages
References: <20181217165957.GA60293@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181217165957.GA60293@google.com>
Date:   Wed, 19 Dec 2018 15:02:14 +0100
Message-ID: <877eg5fwd5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 17 2018, Jonathan Nieder wrote:

> v2.11.0-rc3~3^2~1 (stripspace: respect repository config, 2016-11-21)

Minor nit not just on this patch, but your patches in general: I think
you're the only one using this type of template instead of the `%h
("%s", %ad)` format documented in SubmittingPatches.

I've had at least a couple of cases where I've git log --grep=<abbr sha>
and missed a commit of yours when you referred to another commit.

E.g. when composing
https://public-inbox.org/git/878t0lfwrj.fsf@evledraar.gmail.com/ I
remembered PERLLIB_EXTRA went back & forth between
working/breaking/working with your/my/your patch, so:

    git log --grep=0386dd37b1

Just found the chain up to my breaking change, but not your 7a7bfc7adc,
which refers to that commit as v1.9-rc0~88^2.

Maybe this is really a feature request. I.e. maybe we should have some
mode where --grep=<commitish> will be combined with some mode where we
try to find various forms of <commitish> in commit messages, then
normalize & match them....
