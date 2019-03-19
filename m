Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDCE20248
	for <e@80x24.org>; Tue, 19 Mar 2019 02:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCSCIu (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 22:08:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35710 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbfCSCIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 22:08:50 -0400
Received: by mail-it1-f193.google.com with SMTP id w15so424545itc.0
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 19:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bEKXsp8jcMOqh+q1R9ejxt5yowHKyTRmHUYvGWOb3tw=;
        b=QoGv/ACnFhjiVD77ZIzt3lYy+WN1pRb/1GbIi1RwKSZYPWGl0seZq/xye36UR7LoMM
         cMa7HfQsQIhaMqpTbMMUUKwG2FeD28KlRNowoj7s92g2R1TXQXelfstgCtqY52IKv5r0
         8ZkWTsoHvi22qDGhJVH7J1dqUTwYw/ggcJNeAl2ngNn8mVwNqaCbm/TZXV4Naho67ovo
         wzd7xnuzwn+mtBPOhXnx/f5rWcKM6JTukH/haBfBt0SHWfMbU4Pu2ZCrps7iVUAPH+sw
         E2YPfGADbUnfhzL2miGwz+vauYdDhtx1gA3N/+58z442hPNdFkbO+GX0vw1ZLM8hT1aw
         qOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bEKXsp8jcMOqh+q1R9ejxt5yowHKyTRmHUYvGWOb3tw=;
        b=EOmIjJvMGMQd6CNQLFsaUo0luVrIwXvn8SM2FmTYElk8f4nZnUa823LfsxYS/lACdI
         h4B4TsITbmEYTwzBfdoLWVo4GGoH6amE8dv1c7NyUYONuZDx5pbQIHgg5YlN03F1dR1g
         khGpsl9vabae488U8475Djso8NBXHejg/EoS+oTfL2qaSBaPQ5jTAn++KQXsIOrdc62K
         ay0/oITWsof6KSaIQDHYHBQ2aQX1tF4G905xcdSHhetLlGL4wNrlSCyNBIDvh2o750A6
         Q7ZAVESM0rH4KPlzo894aAAY+SaBuHbmSS1SEEpQh1Je88Vej9g6oUlMQgpXPQvvP5rv
         +9bw==
X-Gm-Message-State: APjAAAWebux89nI7Ejawx+QCZVVbG/5ERSIBMOa5rgpqNjkNgHuMbWXk
        MgCj5jycPiTIFE0r1YgNT4jCXCPdzZ5RW7by1PE=
X-Google-Smtp-Source: APXvYqzAwRBzj08gYILIFc6xIfo52ajMqTuJyvxgHt9djW/aetW0LZ2YV5OC2Sn4iQW1Kh2l32wjKDdgBaa3TFfY0v0=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr1044988ita.10.1552961329773;
 Mon, 18 Mar 2019 19:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190318161502.7979-1-avarab@gmail.com> <20190318161502.7979-3-avarab@gmail.com>
In-Reply-To: <20190318161502.7979-3-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Mar 2019 09:08:23 +0700
Message-ID: <CACsJy8DW=MPe=oU-hf2ngpMFXYexmhQyLy-W1BeKo-0gpvAh8Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] gc docs: include the "gc.*" section from "config" in "gc"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 11:15 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Rather than duplicating the documentation for the various "gc" options
> let's include the "gc" docs from git-config. They were mostly better
> already, and now we don't have the same docs in two places with subtly
> different wording.

Nice. I have a wip series to do this for more man pages but it's
still, well, wip.

There may be one thing we need to sort out to include config/*.txt,
sometimes we mention see linkgit:git-gc[1]. When including
config/gc.txt in git-gc.1, this self reference seems silly. But I
think we can just leave it for now.
--=20
Duy
