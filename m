Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE5B1F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161212AbeEXTfc (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:35:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52559 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034599AbeEXTf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:35:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id 18-v6so2644911wml.2
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNJecafjCLKk+spbomjAgmxZHcNcPQYMsIsYz0vca/4=;
        b=WnHRrfeM+pWmW5kbtzxA447bPLYhiF0dH8t/8uqEJBhnpph7nz/K6xkNYx8BqSpGqR
         Yuxg2XQbrW5SCX0nvigdNTWoR4Vcw3TFszmEq/jMC4algfWePzLme8HA5zBGanSiQYC0
         Dsdmpo4TwbMghwAOcvim11yOIUmYsBpCXH7XaN4rNhR6ybcWKQFy9NZzVt4NcCyxP6NE
         VgNjaAcAuF70TX+r5vg8aQtaP2S0oF+Pekr1y4k5LS3qfmUMmaZjGrz0eaQnlJ7egIHa
         ly71QZoIW5hd8vqIlhOqkLB2f9+FecCpwjqp6dH8Kh9JSMvFlsDvsHc+WKg4HnSJcn34
         5Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNJecafjCLKk+spbomjAgmxZHcNcPQYMsIsYz0vca/4=;
        b=lEcWY5oOQ1Gd7wHjetsflj2UUV1+p4AJyxxylFPUYsqQYbJCjgacft+bwHMLVPtnAZ
         HpdAyDPBaVQnPUqh5pArFjDdQHBjjIY3AEuwSfripCwPligt2wFp//MopRmOXhjgxqJq
         6NC/xqEVHqrRuMDv55BMkdrr5i845zEe22qHDIyLU2TYLjNq1sqjqhAtRgnYCxtm7VMv
         2eNTzG8TtS+ozuiplAaVXEJOQlbSnNc6Vq6jpGIOuwAMIviTX2Zdvproi+yGGHUl2Qh3
         VBs66k7qZHer+WZCP57uHAdYNSrllZ+QkE4OahiHx/emUapeVygpyS/AwREQoeqh2SqA
         LxFA==
X-Gm-Message-State: ALKqPwciesa4xAS3WUprIenn9Brfws7NBm8vbfJ0+p5GPU3PX+Ot+d4w
        6/iZINKNuKZ0H6h+D9LX2pXmADDt
X-Google-Smtp-Source: AB8JxZosd6o5UaRh13iIDtLbjo3alrjWS6TC/sC+Cqh++St2HMSqXIT0BxlpTNuioKnUyvLmjcV2HA==
X-Received: by 2002:a1c:6f88:: with SMTP id c8-v6mr7918165wmi.9.1527190526012;
        Thu, 24 May 2018 12:35:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 136-v6sm7056887wmo.12.2018.05.24.12.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 12:35:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] fsck: doc fixes & fetch.fsck.* implementation
Date:   Thu, 24 May 2018 19:35:12 +0000
Message-Id: <20180524193516.28713-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180524190214.GA21354@sigill.intra.peff.net>
References: <20180524190214.GA21354@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 9:02 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 24, 2018 at 07:04:04PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> That doesn't work, because that's for the server-side, but I need the
>> fetch.fsck.* that doesn't exist. This works (I'll send a better patch
>> with tests / docs etc. soon):
>
> Yeah, I think this is the right direction.
>
>> +static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
>> +{
>> +     if (strcmp(var, "fetch.fsck.skiplist") == 0) {
>> +             const char *path;
>> +
>> +             if (git_config_pathname(&path, var, value))
>> +                     return 1;
>> +             strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
>> +                     fsck_msg_types.len ? ',' : '=', path);
>> +             free((char *)path);
>> +             return 0;
>> +     }
>> +
>> +     if (skip_prefix(var, "fetch.fsck.", &var)) {
>> +             if (is_valid_msg_type(var, value))
>> +                     strbuf_addf(&fsck_msg_types, "%c%s=%s",
>> +                             fsck_msg_types.len ? ',' : '=', var, value);
>> +             else
>> +                     warning("Skipping unknown msg id '%s'", var);
>> +             return 0;
>> +     }
>
> This matches what's in receive-pack, though the way we stuff all of the
> options into a flat string is kind of nasty. I also wonder if we'd
> eventually run up against command-line limits if somebody had a
> complicated fsck config.

Yeah, but I'm leaving this for the future. I doubt that it's going to
happen in practice, although if you have a huge skip-list...

> I wonder if we should simply be telling index-pack "please read fsck
> config from the prefix 'fetch.fsck'" instead.

I think this whole notion of reading the same config from two places
sucks, and now with my patches it's three. But I can't think of a
reasonable way to make it better without even more complexity, and
maybe it's better to split it up anyway, i.e. the stuff you want to
accept is different that fsck and fetch.

> I dunno, maybe I am just creating work. Certainly I don't think it
> should be a blocker for adding fetch.fsck support. But if you want to
> think about it while you are here or write a patch, I wouldn't complain. :)

Sorry, too late. I already wrote all of this :)

Ævar Arnfjörð Bjarmason (4):
  config doc: don't describe *.fetchObjects twice
  config doc: unify the description of fsck.* and receive.fsck.*
  config doc: elaborate on what transfer.fsckObjects does
  fetch: implement fetch.fsck.*

 Documentation/config.txt        | 113 ++++++++++++++++++++------------
 fetch-pack.c                    |  32 ++++++++-
 t/t5504-fetch-receive-strict.sh |  46 +++++++++++++
 3 files changed, 148 insertions(+), 43 deletions(-)

-- 
2.17.0.290.gded63e768a

