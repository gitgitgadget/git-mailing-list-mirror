Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B86A1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFCT6I (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 15:58:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38275 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfFCT6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 15:58:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id g13so28525947edu.5
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dao4DH3bwU01eKDAaMb73c24EvcqQGDKEnAWh+LobMA=;
        b=TBI5KydKWZ9ErYWg1hJHfil7gZbMTldt7675M7U2BwP5V1N0p7A4+KRPVruj5edxo6
         b3QiMjyDfeZ+YfvPChtU3ThjhoKAprxdMxpOUWP0gXYF79O99mw7+6Xg8eVqlDEb+iMb
         /UpO3x7i9Odp7xQUySjZ99WkdOU77Zi7Z2lbBMrpiyA39MFQ2jbPmCL+fl9YeU+vYJYG
         kfumlkhOHhiqsA4f5uAfewUwAz8nACmjj+DtXKUDg1L3SQIiJ6JyjWUKC9ohqlpmcQCo
         WZQAL7QMPj40HmvJWmZtXVR4rikrwglhZBMePPt1by6GLuk7yT98B+xMzMWYzvZ505FR
         g4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dao4DH3bwU01eKDAaMb73c24EvcqQGDKEnAWh+LobMA=;
        b=HrWz/2+PZUG0Cyq6uy40gZen7zoXgiPEd+1QjSwC8c9X/4Wbx8WxTTxst2uWbQwQwC
         ndPhhBfrhhzlXLTeGfULMgnagVYgCwhpMABpyPqObxKq4x2JD4I9mN2DtNczN5y+XZIJ
         HlS8HdU6iDRIrb3j00j1s6/yC88D1N9Ebnm3/wx5cj/OCdQAsOhtwjhAuCro2OyOPFYw
         BqQaiBo9f1VfYfwG3XyltaD78YFm1+fIXRMza4ak3cxQMy23R6xSOAfKz9zzZn3VOzzb
         lyeoq/gPyzUflrd6VsJWXio34fCyg6oSArMRHDKuRYVoaDRz9Q9DQ5Sx9EUVBYrGsZjc
         C8ew==
X-Gm-Message-State: APjAAAWjjZAzoZ20AcSHmAVjlF6+899ivA0NTu4NsY6F8N2ZKxQldMwb
        aTc1LziK1wz1tqinFMWzqhBxm2IoT9GLCISmY0QTVA==
X-Google-Smtp-Source: APXvYqwIxkRxZYKA96cCrZ+PsmCb0YzgBujXOWVLC1roe1pREwBFeXQFvN3S2skaiALNcbFoTHRTq8PeQLCFrsQAGOw=
X-Received: by 2002:a50:a941:: with SMTP id m1mr31575782edc.157.1559591886623;
 Mon, 03 Jun 2019 12:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190531183651.10067-1-rafa.almas@gmail.com>
In-Reply-To: <20190531183651.10067-1-rafa.almas@gmail.com>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Mon, 3 Jun 2019 20:57:30 +0100
Message-ID: <CACUQV59ZQ=WLXa4iDw3nSJWnZpiqAYLOuoHKsNWj48uC=+k5KQ@mail.gmail.com>
Subject: Re: [bug?] clean: Demonstrate failure when used with paths
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, newren@gmail.com, sxlijin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I missed this RFC series which fixes this and others issues:
https://public-inbox.org/git/20180405173446.32372-1-newren@gmail.com

Cheers,
Rafael Ascens=C3=A3o
