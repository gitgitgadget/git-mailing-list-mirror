Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6913D1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeHOWD7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:03:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33449 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeHOWD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:03:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id c135-v6so1642660ywa.0
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yuQKEUhClAw3Ve0IZq5jPRZ9ZEn2SoLAFFy954pgt8I=;
        b=MGNjm/byizn/AUvjsrL7AeonNTV8W/1An9x0tywnVbM880WDJh82G8lcgIwePI9EsR
         X2RjfdvO3pDXPoM0iAsyhXfagb1dSP4XVsbrA0K1aiwsp1Fyn8csOOsIOAVeQvfDP+pL
         ervgtWKwWweb7/l7fq6H69OG3xtxCZTKHKCub5C/Yaiiu8xDNHpjCuaSxFvLH1/ZTjR6
         daX3T6XxUXIAWEdkNwV0Mtc2GukDy/m9Kc9JDyQy9HAwpmoriTB6RS7TWqdBcXv8M4DT
         /mBIr3ll76uvv5UUvyPvMYdICBCQd9gMEtEyW4NYA7ianEbxashlvFFSM1XN/QAI7MeD
         qBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yuQKEUhClAw3Ve0IZq5jPRZ9ZEn2SoLAFFy954pgt8I=;
        b=mjOJ2rAwhTRuSbrSMibA8ttuiJN0PM0ljnHBiDP9hV1RGsru8hKIHte4aWIgpCfaYL
         ErHxE3jBCWLm6m9Sb0PciACXYhrZlUw3ADuFwEOsPx3VFOkpeL22omN08j+0wDplNLqs
         AkbCHJR+BXxJ4g/TknG3b4qyOcNe432Fk1zSHzpeHr7yxsoivZNbs8tqQ14UKAcjTxwj
         BKfF8WDOR6QLKnI3mwhhyA64roBO+HHuppxAENnrk226bcfQncfE9LDunq/yrmoLe4M0
         D67/HFO3AdS5zR8uwsl6O+1roYCONC5GxanJPVXW5kVjymgTTLv/GG9yAVHdChoZpsuC
         X15Q==
X-Gm-Message-State: AOUpUlEtFJV99Cyy0Una/Gboo6CgJRlCiowpxnEfWUkEaB7cpThHz+fM
        ThrD+DvGPOjsIIHwdhgrUo33/3k0Hr2GfqRV4KVRgw==
X-Google-Smtp-Source: AA+uWPyF22PbopDT+slONc9zs72P4Nef1Zzwg72gkwQSePMu9g4EJJ4yqrugXsx+P2+g75UFK4fTSShjhiuhW4pEkls=
X-Received: by 2002:a25:3c45:: with SMTP id j66-v6mr4327937yba.247.1534360233510;
 Wed, 15 Aug 2018 12:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161441.16824-1-pclouds@gmail.com> <20180813161441.16824-9-pclouds@gmail.com>
In-Reply-To: <20180813161441.16824-9-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 12:10:22 -0700
Message-ID: <CAGZ79kbs+4_D95+F5km0ODPb1_7tPXMivet35Pq+4vut1ZS9dw@mail.gmail.com>
Subject: Re: [PATCH 08/24] unpack-trees: remove 'extern' on function declaration
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 9:15 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

This removes the only existing extern keyword, which was added by
Linus in  933bf40a5c6 (Start moving unpack-trees to "struct tree_desc",
2007-08-09). All other callers do not have this noise word as it was
simply never
present there despite the old age of unpack-trees.h. Interesting history.

Thanks!
Stefan
