Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2882A207F8
	for <e@80x24.org>; Sat,  6 May 2017 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdEFROR (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 13:14:17 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38669 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdEFROQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 13:14:16 -0400
Received: by mail-wm0-f47.google.com with SMTP id 142so28827460wma.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=c6kC6MgusozTPwvgcB03nZViVr5ANPQRHrviGiPJLms=;
        b=ci8CZvPs/sUNejA/uoySOYGh9DX0JWmmRfzVBFeMxnxO/VUQ3TGySI2L6xXXuvzpEn
         nS14grVLVQj0DskIDKinwa4+ZG4ZMFtydPSaiDxQ6gySru838gk1FkZMaqckuPW+X2zV
         V0lMZFlY2eo+LMZJZCY65IjO1On95O9pI63sH+XVi/XG+VtKmimE18vaSKZX87ZrOAIn
         YXD3Nr4byH22PTUkhb5NdiJJAiUHUlb3xoSByinRWXUXwqkRP59Pt2bw7pNK6E2NNOUg
         WrYyR0fHkdlVbaXthG86Mkq4zbPPXHV2cfI2TqFaazxGIwJmG1rgBDTdVkfoVgc54ADo
         mb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6kC6MgusozTPwvgcB03nZViVr5ANPQRHrviGiPJLms=;
        b=Fqp9FSb6u0aGc4KLPtySctNPPLZwPMR6uAAojPlikYEtStzgaz6PY+aWEczV7qQ4rz
         dfnt5TWSbAQdjnPIUwZ/KCYtpBNOEjS6DTTB0fUSA+jbXaUDYd1Q0MHdqaV8OzSO6akP
         0zDdsGMMVplmZ6WgIxFtIbuFeRty7ieaoqi7gN3SqCAH3AwkEKhxxjJGRM9UPliEQA6q
         Ss3nk11Uo5U9thc54L/CMnHJdBcOKx677GW5tu9wg/sq3jpZIgbEo7exDUuFPnxITUHN
         MjQj7AagoOpXa8ZMAxf+LAlNYClnfKr1wlRpeAMmvya0Kj+Ju9XElyNzQ1/i3a1Sl8vk
         +oag==
X-Gm-Message-State: AN3rC/5R4YnD+F31sTdsI8oSRoLJ7mXGPxDNAwDcjEaAIYWkJ0uIzQ5q
        qPn3DCCA9CGtpw==
X-Received: by 10.80.172.28 with SMTP id v28mr16857079edc.38.1494090849349;
        Sat, 06 May 2017 10:14:09 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id i28sm2620456ede.38.2017.05.06.10.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 May 2017 10:14:08 -0700 (PDT)
Message-ID: <1494090847.24179.7.camel@kaarsemaker.net>
Subject: Re: Script to rebase branches
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Sat, 06 May 2017 19:14:07 +0200
In-Reply-To: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
References: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-05-06 at 12:23 +0200, Lars Schneider wrote:
> Hi,
> 
> I am about to write a bash/sh script that helps me to rebase a bunch of 
> branches (e.g. select branches based on prefix, conflict resolution/
> rerere support, ...).
> 
> I wonder if anyone has such a script already and is willing to share it.

Dscho's git garden shears perhaps?

https://github.com/git-for-windows/build-extra/blob/master/shears.sh

D.
