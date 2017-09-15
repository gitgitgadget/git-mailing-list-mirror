Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697FF20A21
	for <e@80x24.org>; Fri, 15 Sep 2017 01:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbdIOB6N (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 21:58:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34999 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdIOB6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 21:58:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id i23so507611pfi.2
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 18:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=T015nJE2lWAqbbcMcH7WURBZyuUA+i+ZxJvXw6/f79E=;
        b=GD64EEnqfhzHfb2T1sv/cbYYNUZ9YcikSBniG2/zq8CfAfknUubtmLy/yGoAe7ak2b
         3WqCc+9EVENYN3CsHSnl7cWJqlTUYjRdDEt+hQ4Bs87e2bI6HOQGFUHn9W4IAGdaEizu
         QQArJ8ESd89XnUZSxa5RDUcfhkQxR+seUJeloun1Z2GZNcJi1lV+i229AfJyUULNzmX1
         DkhDUo2dJnvLi/LmkwswHKNeIwhPnz3qubAOGAlRFDnIGG/IlzUDFRvojORJc9542zO/
         kyJnvWEylJrPgFkn9Qefc1i/uLY9tbYdPHloBAWy3DL8oJ/ukC1h0/8rQXeKyZKH4snf
         2Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=T015nJE2lWAqbbcMcH7WURBZyuUA+i+ZxJvXw6/f79E=;
        b=adp3Rj9OYHPFVHM8h/qHuWpSI2m0buSw0AkhS0IyiKxNfX4al8iRzq/+NcAfXbU1LT
         Yu0orUSpelssK/j6gZEk1bV0bip28Y/Q7vtzobgLzcGORen9i3vOtHGMTBZo5y1EPcUn
         chIfpBxx6uNPVP3bU6p5uMd+jWxSrouArExY7jPwF9joOWws/nkGEU9nsIdTqKINxSV7
         If5K8oCmYaw0I89sqlaBdmb2CdCUQvYSK5wPCpXadJRNsFF8/zjjpR2NpThvKLSehLP4
         N4sg54qZo3T3Mp/J3yo/7DvwQc3veGTSJ8BeOK3cM319O7EdPoxfR/4ggV+Tm8aQY3y7
         E2Cw==
X-Gm-Message-State: AHPjjUgVWZT1jpPTxgl7L4x9yEnaf4rtuO7Gg6bYCdR+RyLk8rp9uQ+A
        KBls2Y83+FAB3sy/II0=
X-Google-Smtp-Source: ADKCNb7v4k3dvWGFcbWn4bmooDgFJpHZcoHKZAPwiKUxZ2d14AgMxZjbme2bn2IA5JnKD6c5PE/AYQ==
X-Received: by 10.84.131.103 with SMTP id 94mr19159001pld.302.1505440691914;
        Thu, 14 Sep 2017 18:58:11 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id v71sm33440657pfa.45.2017.09.14.18.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Sep 2017 18:58:11 -0700 (PDT)
Message-ID: <1505440687.1862.15.camel@gmail.com>
Subject: Re: [PATCH v2] commit-template: change a message to be more
 intuitive
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
In-Reply-To: <862e71a1-2dee-4a20-d828-69a0547fa5ec@grubix.eu>
References: <<e656d1b4-c95e-e51d-5f48-bb3450580fa4@gmail.com>
         <0102015e7b585037-5f88e775-2696-49ec-8dd9-5e1635a34607-000000@eu-west-1.amazonses.com>
         <862e71a1-2dee-4a20-d828-69a0547fa5ec@grubix.eu>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 15 Sep 2017 07:28:07 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.24.5-3 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-09-14 at 09:36 +0200, Michael J Gruber wrote:
> 
> Also, given all the translations that we have, it seems somewhat strange
> to try and foresee and workaround possible misunderstandings of commonly
> used English phrases.

In case you're trying to say that "Translators have successfully
translated the phrase with misunderstanding for many languages" then I
have to say that I foresaw the difficulty to translate it in other
languages for which a translation does not exist yet (specifically my
mother tongue). If that's not useful as it might only be an rare case,
then this patch isn't either.

-- 
Kaartic
