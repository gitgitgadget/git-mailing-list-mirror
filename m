Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE9120437
	for <e@80x24.org>; Tue, 24 Oct 2017 07:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbdJXHjG (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 03:39:06 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:52235 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbdJXHjC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 03:39:02 -0400
Received: by mail-pf0-f177.google.com with SMTP id e64so19055471pfk.9
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=dqLdWtSBQy4va+rC5tfimt9DZR+Kq+rTLpSHsq5I2Kc=;
        b=sZPA/aFBYl7rN/nMIO7BPj/3AhqevZY+5O9PrkrlO6Ithg0Tg/PPzEUvTu1NbS2WZl
         sIooxYFxvvAypsM9QtOOzukzovIkk/W4Fz9KHxLJ6yKILnWflnyAMqbvhzxMCHH0biVq
         0zfSyvueKyZvuX11Suel6f6dZ18CTumLlbWPt/t/QcMIRMB/gb7QYNUXDSypjpjWLyT0
         soef3z8WNIBN5rp64xwhm1+I2bWyx5Y5aZv0RfkGm26CdP+lJddOYea29agjo7qOztrS
         /ghdbml3B84+HTAJxbJHo2JEopR37N9eRSRWuxF3kbig29Mc6HyWNmaxRs8fKR86IYZI
         +aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=dqLdWtSBQy4va+rC5tfimt9DZR+Kq+rTLpSHsq5I2Kc=;
        b=rpUcpVHxfRqcftFVEGEe/exxycs8zFR0WDCqdcGNaZeG2Z8/QoW+hwFj6/fPMpitpG
         O84/AzdbXU5DPLn8duknovs2hXhdR0y7U5FsTog+mENn8M3EfP8kIi03fy7VffJzNskR
         6YvPGIvsh7gkuxI/xJtxA1e1TDLMVWMLBz5WOQY+1zCz8EO8pHXJ4sRpFeBJmDe6zfZg
         zau3SKo2QBcRuoDR03N0ghqKhOJECUb8Mf4++Ehhzv74bW4j9Y3f6bkdEniY30gS/Lzm
         09IwRGOX83x525SVXdSLpXdkYX/jW96kj6fy74/XosWAhF5sdo4xXl5ei4a31PaIa630
         4I+g==
X-Gm-Message-State: AMCzsaW9W72IjuvsDXkoIzlvLK5rlqZKOwsJKAI0MDmJDwwhLiPLOvi/
        kbmNK8754WMEIrRW4hnls5k=
X-Google-Smtp-Source: ABhQp+Qlqwe8glHjgwqD3Ms0FPMhxCcc2AgX/48MA7ThytJ5OZ2Rbwn9OVK4HaudnF/Ee/lbeOgcIg==
X-Received: by 10.159.195.7 with SMTP id bd7mr2639815plb.366.1508830741919;
        Tue, 24 Oct 2017 00:39:01 -0700 (PDT)
Received: from [192.168.1.126] (50-39-169-152.bvtn.or.frontiernet.net. [50.39.169.152])
        by smtp.gmail.com with ESMTPSA id k7sm15214280pgc.4.2017.10.24.00.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Oct 2017 00:39:00 -0700 (PDT)
Date:   Tue, 24 Oct 2017 00:38:56 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <1760206035.56692.1508594211365.JavaMail.zimbra@laposte.net>
References: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net> <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net> <CAGZ79kYRq4OugvTfb2WNdk-M5DMAZC0JpJHqC1KSeJY2eNN1=Q@mail.gmail.com> <1760206035.56692.1508594211365.JavaMail.zimbra@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFE] Add minimal universal release management capabilities to GIT
To:     nicolas.mailhot@laposte.net, Stefan Beller <sbeller@google.com>
CC:     git@vger.kernel.org
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <7DC2A15E-0B47-4398-8B62-DC39C5EA1343@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On October 21, 2017 6:56:51 AM PDT, nicolas=2Emailhot@laposte=2Enet wrote:
>
>
>----- Mail original -----
>De: "Stefan Beller"=20
>

>> git tags ?
>
>Too loosely defined to be relied on by project-agnostic tools=2E That's
>what most tools won't ever try to use those=2E Anything you will define
>around tags as they stand is unlikely to work on the project of someone
>else

I think that this could easily be built by a separate script which provide=
s git release command line and uses tags under the hood in a well formed wa=
y=2E I wouldn't say that the method outlined here works for all projects bu=
t I do agree it's fairly common and could work for many projects

I think most large projects already use annotated tags and tho they have t=
heir own format it works pretty well=2E=20

Showing a tool that could help projects create more standardized release t=
ags would be helpful=2E

I think such a tool could already be built, scripted to create annotated t=
ags with a well formed name=2E I don't think you necessarily need to have t=
his in core git, tho I do see that your main goal is to piggyback on git it=
selfs popularity

Thanks
Jake
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
