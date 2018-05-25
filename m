Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B4F1F42D
	for <e@80x24.org>; Fri, 25 May 2018 21:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030217AbeEYVH4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 17:07:56 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:41975 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968376AbeEYVHz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 17:07:55 -0400
Received: by mail-qt0-f171.google.com with SMTP id g13-v6so8222313qth.8
        for <git@vger.kernel.org>; Fri, 25 May 2018 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DMzp84rHQAxyEPd76sb+cW/l9Fc0uYQqyYHQSCaO8aA=;
        b=P69ez9vQ85K9y5HM360tV9m2atvMuEIX8v0xWbMQztT3/qIhK/8h1ZZAfP+MAU/mAb
         9vhUpfYql1ge8ADPcXYIOURTjgPZ3LYDZt7mqAS+E+3M0xsz+nmRrERA3bZtCbiDISKg
         rD9FqVWl7ZjnNcwXEYYa4CAaEyhF+cRRGwD0RKcg7+Z1thC9zKyCJu0iwOtoPLdgqRSP
         0COBObUeqxBLhi0MgRE9+1EtfA+3fGTvccRvyLuGtCkcce2j/hYi/JX/hielS9zArJdS
         C8OvKTDfJlllzE5pR+ZJDOrZ2TMPu7/asWBCHdk45d0b1Xaor7iFKLAENxChsXgq1GM+
         Z0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DMzp84rHQAxyEPd76sb+cW/l9Fc0uYQqyYHQSCaO8aA=;
        b=q9kpFk2uuk6OfoDUgLYCqStqBseLphRM/reN42ysMcGrfojL7XsJX4dWP81hIksn3L
         hwPGYN5eCO5Yns5JtLSfQkY+CD10nSrV7c2MFWiBtGhUUAMFC8Gdi309LTGxsoTozf+d
         C8as1LaEKiMNRVuKI3/mODCBhis5iL+U5okXGC4O+MW2dpWFOXYpFXCepW7bxidKTC48
         LSJq3Wma6k0nOVj+8WF8/MeahsAP4ZkJt8GQe2odH/7S5fQRQjLROrq7Eu0FU0/QnsTe
         G9FO8dTmsyY37TAo2LeTTt6jgeZer/DF3IHB8D9jLKPR8oNMqWr/dNEelCVgae6kKnba
         3qfw==
X-Gm-Message-State: ALKqPwfPLvhaiEmr09KG1jO2rcXRrdkh8qdJIrN83dbGSaPhuOVKau7P
        zfg4mMUmfnc77fN95lvppk44y3zGtZ+8mRry4yw=
X-Google-Smtp-Source: ADUXVKJZTHSU+RSldnG5oWXOuL6KA3Xab/U//y/sbq+I3TS3Sah7F3ep6WQ3L4BojVIoSV3ffz8hTgYDD5tGrPOaotg=
X-Received: by 2002:a0c:9e5a:: with SMTP id z26-v6mr3914114qve.109.1527282475023;
 Fri, 25 May 2018 14:07:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 25 May 2018 14:07:54
 -0700 (PDT)
In-Reply-To: <20180525192811.25680-2-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com> <20180525192811.25680-1-avarab@gmail.com>
 <20180525192811.25680-2-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 May 2018 17:07:54 -0400
X-Google-Sender-Auth: 5aIYlYodoEfeI0jn-_n7M3fmoAM
Message-ID: <CAPig+cTK1iKiYnxCH5D2RnhZxaNocgx9UuNeakxzf4LgFSnd9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] config doc: don't describe *.fetchObjects twice
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 3:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Let's not duplicate the description of what *.fsckObjects does twice.

Nit: "duplicate" and "twice" smell redundant.

> instead let's refer to transfer.fsckObjects from both fetch.* and
> receive.*.

s/instead/Instead/

Perhaps the above paragraph can be rewritten:

    Refer readers of fetch.fsckObjects and receive.fsckObjects to
    transfer.fsckObjects instead of repeating the description at each
    location.

(Not at all worth a re-roll.)

> I don't think this description of it makes much sense, but for now I'm
> just moving the existing documentation around. Making it better will
> be done in a later patch.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
