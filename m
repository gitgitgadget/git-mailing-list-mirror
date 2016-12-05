Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263851FC96
	for <e@80x24.org>; Mon,  5 Dec 2016 21:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbcLEVUQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 16:20:16 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36741 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbcLEVUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 16:20:13 -0500
Received: by mail-ua0-f170.google.com with SMTP id b35so361507467uaa.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=WkWV1k3AtHX3k8m7AWUwZLJdF76HdaLFfujblAg47N4=;
        b=HZUubp4IcfV30CR2tvD1sWr/Pewf/+bKIsiLDLpBEFiZeu5wPmeL0voCvKM3GyzAJJ
         Varf5sX3wLIAFlJvhQ6w1Piw4mXReQ0107EyFTP4Tykn0203lhJemitKL/JBCKPD8tor
         ml8ajbpf9ebmsIMp899o6Nl6GWFJqeFJcYCDiPWFIjRI6apKYao1Ky0mjTpTREoi4J3r
         XiEjwKbUr6WWtoY0nqP6a+k+/9zEwiPnN6NFsYyiFoNQImBlAVh/gyY8A1t8uqisRPpO
         0iaKzKerZ1rU/7IGAiwNoZQn6C+zCW5TRC8x7+OR0zJDW+JKCp7Zq2W75tCMDA8u2S9C
         PCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=WkWV1k3AtHX3k8m7AWUwZLJdF76HdaLFfujblAg47N4=;
        b=UC2e0CTTo0BoOl871z5O52qAvAYmulatGcE0SqbICJCZ8CIr9PGeSbWTU+EDEkXbfa
         5JNltrtMwPV/ol8DI/ytZlsRFFKSkdEdM52jSk0ICRHmMA0EJO5VPeXWP2Gm05J072fo
         PjeR6OsPg/LvsRyRTrsHAlfALj+1J4G8qwyFSXRgnMbipgJZrAuuHcjMmnKTm6q5IKKB
         1peJNIGJlDiEt1eUFci8TseD9IgRfoX/ZZySt3oav88FJJmd1++dTEOYqJChSd/n1tCy
         2mDPc45NpDbqAzinux78KczmsKeMK1Y9ADNhLG21bZth33L1dWM0TMxd4q3EB96v4NpV
         0A4Q==
X-Gm-Message-State: AKaTC00S5iBVv7k7zPr7JM8Q2NT9AVdL50jXFuZZHXShEyPleXVQl0798Tyaqi7cIVic8wz0VesnbzBo8ZXomQ==
X-Received: by 10.159.48.91 with SMTP id i27mr45356248uab.13.1480972760830;
 Mon, 05 Dec 2016 13:19:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.83.87 with HTTP; Mon, 5 Dec 2016 13:19:00 -0800 (PST)
In-Reply-To: <20161204140311.26269-1-larsxschneider@gmail.com>
References: <20161204140311.26269-1-larsxschneider@gmail.com>
From:   Ori Rawlings <orirawlings@gmail.com>
Date:   Mon, 5 Dec 2016 15:19:00 -0600
Message-ID: <CAPv0x+Ps9YiMgHsJ0_VKzjbXRtqybDoJryt2NcVmE38JvUCeWA@mail.gmail.com>
Subject: Re: [PATCH v1] git-p4: add config to retry p4 commands; retry 3 times
 by default
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good to me, too.

-r flag seems to be supported as far back as I can search in the Helix
release notes.

Ori Rawlings
