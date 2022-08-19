Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E47C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 09:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347894AbiHSJcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347427AbiHSJcS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 05:32:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52CF4900
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660901528;
        bh=acPY+/O06pKX50ZHnJMCxprayTTR3iQY9Hytl9Tanxo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QHUbsa2B5SaGaSdavnz8b6+LRcDiGfuKwfLhBMO4jnTdUwluOoWHkQY+pkN7c95Ck
         wkBpOhtTC4IwlV67S3tOxMIETVKl05DhEZihtg1h/UlyOoAfFNr2hqTUCvqONNwQ+Z
         3rnik/L22PXArfZDZX10IiirYyyIUIjZB3r8lPbI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1nYFDL42K0-00qypZ; Fri, 19
 Aug 2022 11:32:08 +0200
Date:   Fri, 19 Aug 2022 11:32:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Michael J Gruber <git@grubix.eu>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 0/4] sequencer: clarify translations
In-Reply-To: <cover.1660828108.git.git@grubix.eu>
Message-ID: <2p150404-o6r0-4p10-o0s4-orso00o6n369@tzk.qr>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n7xbb7Nq+NxmLXlGZJpptVVS5UWHdokDU/8gOQgBLTCoYklRqMy
 32hV9CpzmEL2UmDIYyrn9TIAQBYOiWDuKLKRiNC1wv7egkqC5umz3e+hPfZbtaOFq72QDjQ
 BCBXvP/5rw9xOEh6qhBWgO4j6HJpoemJn77Uq0hs+iZ2N8s1EUYMC94nlzFUhYX0tzg6qes
 /QrTc1Fw5CMkI7CGTGoVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1foOSz9EVIY=:iQ1rkjlOJ98mYMaYnlVneS
 7/GUiTOk4eWICarrXUqBGPAHWnqn3U18TtQaXa5G0jesgZfijxfsAPp54e1zGe/tH1F+e6c5u
 btguXZ/OmbNCZgDlI46V/ycX7922A9/1CO8OZD4kLBRCNNt3BXkknRuBAE5FoC1FYjKCVrMZZ
 H96qzrdKR66MbuExnnekZxSOAxknsGMWaejuUVRKPZ813HHTdlU5DY44WF7Cahxa0nS3MV/2n
 vSZOuufC1dR+ajqq2vhM7v1eoBc2IE/vEEpKmmJqsiyY1d4kMboDL61Riq6mgTfIcn9dEnvst
 ODGs6ggKlkFK87rB1tSbe4DW8jO87v92GvgBrN4yLEyFouHRwA86o2tBKDRcHZUEana+g54OG
 c5OElnPHHU5oxZ21bKlQWNnD9dyHs+7Kbl29R6BrwPvNIUoL+IqtVXcPA7+8BRaapOP81k0ZH
 TCf8cR2WNY97+NPd+VNfVYul0Ygc566U02+GizCmfjeCcLoVqCOalDgtF7MCgbcJLs1MY5RbG
 Jxu3y14nlF9Umv3ygYJo2er5Fkviyt1Fdb/KnXVVfeJfNuzMjIMui/dhHcIra7aqUd+As6i+A
 hB2Ihd/SKk2hgKstAJxIeLK/w6DBXfLm3iHcM4w6j30+VbO+N4MywIPywtg2qJQzhNRXgqFNL
 8KTMrq1Q992CIcSkFMgCqocF5TWjxsj7PyoefwxuE3xq2wOpk+ERuRAHccXGQJZAe1xncXWTT
 AbkNWRmg29baywzm4NS8S6ME29Vj1cOZX3Vmrd88z0rh4H1wdOmJthN7fjdZmc1w6XRKERrPL
 NY3+Ga4aKy8tnomjnND5cQ2Vgr0qU8At+wdyFVLHOA+nJnSnwwfWhZ723fihQefP6JadebmXI
 AT0GaHqyTA3sRuYe2VKOIIHHznwgYaTulsoNez9mDdk/Mg2pH3pNLGaYk37bizfoeETuk/DNv
 KAtDtl8Y9SlCA3cW7i9o4RMNy8EGqlqILomrS58X2gDNyk0+nwj/cnCTewAtLe5cH/CQ9Aqal
 gxlzEl2NXbAU13e1rCc59FzfnO2n4vH69SgrRqipMMzZFqftBgCpT4BVFyddAbQeHnH4UfpCe
 13fuuC9f1d8Q/tKBEyK0Wu2UWSdz1Bf2p9t4cCTgBiX4jsN1tjN3JJkzA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Thu, 18 Aug 2022, Michael J Gruber wrote:

> thanks for all your input to my RFC patch. I tried to summarize and pack
> everything up into this little series.
>
> A follow-up could (but does not have to) turn translated action names
> into untranslated git command names in some places.

Thank you for persisting on this, and on behalf of the core Git reviewers
I would like to apologize for the hornets' nest.

I offer my ACK to this iteration of the patch series, with or without the
v2 of patch 4/4.

Ciao,
Dscho
