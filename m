Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F22208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 05:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeHFIGx (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 04:06:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37466 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHFIGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 04:06:53 -0400
Received: by mail-yw1-f65.google.com with SMTP id w76-v6so3194517ywg.4
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 22:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CmyMOVnwQqN2c1mO91cKYPz10qKyKVNGPtpcvaYhk6o=;
        b=F6fpJFwXR9K5Iif3nN/HmScJzXAjLdceFs1kzkT9hfPeW6ZJDePWeP7L/hT8TkR2+K
         95ksgm9cFfMPgeEqx9OgVGIOu4CXLB1VuFPGhDxrQ4m3OW0mPVcEPUtVvhm6iRO85EWL
         1TzL7APKeJnJfy8di9+cySJpPKXkP/5/HdY+ebGxGKu5Kb4+PlWf7z3XUwc8R0Fnvs6m
         zRa0V5gelnjyVlTUKtk/hcKlDTFVfnitI0r2Vrmanl0aoXlI5dCBsHOOLSe+/X8FIkBT
         2sU4KqDc8KAF6HoBzIZbgVHMZ5ddEYwB46v9S8BJSZkpvoSTfOnAKPXZVGAJrMFw1u02
         4h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CmyMOVnwQqN2c1mO91cKYPz10qKyKVNGPtpcvaYhk6o=;
        b=dGPL/tcXbneAy9SpDOw2BSTE2YmO2VMLzPEZZLIKh43tCmpVeQs6nPx+/BsvUnW8sh
         Bqja0WKQF48GvsxXUsSMibjUKT5ybQDlbJyi7Ec99ID2rXf3wCS9TdRZMcwh2ord3CTh
         hq53B36inOgFmmieTUcUspONGuMG9hIOz/+DkqdVTFaTheooYZ3Q8a+GP7sq09MqhB6q
         e3YF239ScSkXX/bkMZAiVRN9WUH0/2krjMxRh2bLb5lFFi2+v/T7gfnOWdhV2Hq/cq75
         kEfXqsyJSAoPBH5iGrB+bG5LT4LPdCR0Or49KTzqCcYOSuPPCIHoLM+B/ibqsLt632qW
         EEng==
X-Gm-Message-State: AOUpUlHqn6tWwJiXLTRJ5QPEejrY6SGFCkjxGG5ni8CIvmu/39rdEPOE
        3MPV5KLwJrHkC8k4DYDCy0FOe3HwtHt3KtE2SOHD9A==
X-Google-Smtp-Source: AAOMgpfsVxeTT1dEKd93tOBvtZuHWMKxFH55yfwe6nkpa9aPTS4mkerIobm6MldRfhR4BVBLqeKlkLvjZbrk0zpPcEU=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr7027935ywh.238.1533535165132;
 Sun, 05 Aug 2018 22:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180804062500.20188-1-pclouds@gmail.com>
In-Reply-To: <20180804062500.20188-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 5 Aug 2018 22:59:14 -0700
Message-ID: <CAGZ79kbS7K0yUak9g5vH5ZyJ2aZ4RBmbBXHVtBzQjfRG4Fx1jg@mail.gmail.com>
Subject: Re: [PATCH] config.txt: reorder blame stuff to keep config keys sorted
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 11:25 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> The color group in config.txt is actually sorted but changes in
> sb/blame-color broke this. Reorder color.blame.* and move
> blame.coloring back to the rest of blame.* (and reorder that group too
> while we're there)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

FWIW:
Acked-by: Stefan Beller <sbeller@google.com>

Are there more hidden sorts in the config.txt that I am not aware of?

Thanks for writing this patch!
Stefan
