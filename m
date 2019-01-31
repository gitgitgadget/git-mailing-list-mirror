Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0C1211B5
	for <e@80x24.org>; Thu, 31 Jan 2019 21:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfAaVAV (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 16:00:21 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50519 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfAaVAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 16:00:21 -0500
Received: by mail-wm1-f43.google.com with SMTP id n190so3962996wmd.0
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 13:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ykU2qIRPBgYaPud7w6NA07osnNr3Z7/Sa1IZrgckWDw=;
        b=uyJ5cSRPbQOVXNgDSiOhuVoDveB2B+rvXwxbl2810EWn26fhF/MS2IcBTWBVq9UjUQ
         Hbu/3fnRZZajDRcSHllk9OuIzphb/d/zDYt7gumSm7UpB206+oobGFtOV/0tkqZBdAgH
         JBxf2q5VKWRXUFaealqF8lPTdRQTdIhASaQWHbbeWtdxWDK7FPIj8MGmBm8eHGWKRkpK
         1C5S8/evOezZXbrRSg+StKocYeLclpjIK+y9OQ4al0MxKLNeFBQbCnKYAxkalOU61vCb
         F8iAepEFdb/+vysr+KYXmWiepTewCVLMurIwvccZpZJBHTnIdHlzepZ9wr0l0Q+r/Tyr
         MNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ykU2qIRPBgYaPud7w6NA07osnNr3Z7/Sa1IZrgckWDw=;
        b=iRuHS07gKYKj2nD4kbJhUSWFTfyCJ1egli+ZIDkyIagCSI9ZCVTXVmhJBPVzIGLPtO
         oBIbamoTM/k74EaU4pXlXE7VqtQ5YmpdQrsN4u3atuHDujUpdHspn9UN9BL2mUpqlAn+
         W2jJIHwpTTu2yiha7tZc8BjR1iwPV84ucWkSVxEMHRUS5N5v/+FMJu4fqmVptQhQwbKK
         lxgQDij64k3kLPHivTFqkSF64FHlL6zwfwX8QntOJmNY9A+44hp7jLJBQ68RhbFlmgPa
         ANd3z4qEpYV1Gq1Sirrex9UnclgVZKOzga7L12BEvCxSVXwPfehCcKuOqXuQfG+l9TZb
         LVvA==
X-Gm-Message-State: AJcUukdSdOEVljvqjtEs6MYq90+0lAptcXuTzo3hRAXllszFF4UY3vbe
        gSgk4XDbtijU85cAtXlHF3g=
X-Google-Smtp-Source: AHgI3IYXjiYN+XQwKDXZkuPx/4Efi/gkpCiceuEMsmZxI73JkcQZ38WWLqDWTpHbiDmrgeZbNBdj3g==
X-Received: by 2002:a1c:c1c9:: with SMTP id r192mr19887576wmf.146.1548968417369;
        Thu, 31 Jan 2019 13:00:17 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.gmail.com with ESMTPSA id w80sm275960wme.38.2019.01.31.13.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 13:00:16 -0800 (PST)
Subject: Re: Broken interactive rebase text after some UTF-8 characters
To:     phillip.wood@dunelm.org.uk, Michal Nowak <mnowak@startmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
 <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
 <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
 <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>
 <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
 <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b3360111-df25-bb11-b895-15418e58d901@gmail.com>
Date:   Thu, 31 Jan 2019 22:00:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 31/01/2019 à 21:40, Phillip Wood a écrit :
> Hi Alban
> 
> On 31/01/2019 17:43, Alban Gruin wrote:
>> Hi Phillip and Michal,
>>
>> I think I found the bug.
> 
> Good find! Which os are you on?

I’m on Linux, but I found this on OpenIndiana running under QEMU.

-- Alban

