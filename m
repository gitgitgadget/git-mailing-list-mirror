Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD5B1F89D
	for <e@80x24.org>; Sat, 22 Jul 2017 17:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbdGVRBy (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 13:01:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33707 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdGVRBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 13:01:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id k72so3772625pfj.0
        for <git@vger.kernel.org>; Sat, 22 Jul 2017 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=YX0QiQEY3WE2XcasrrlnoZ1pxOpEiFQnY5itsg/ioaQ=;
        b=V9DUJp7DFKt+SlVInzfelL5W5nG7b/bGqaePo6V4YcUZyi5PUdMpSV6ePVu0enV7/8
         0j90ckXkrnueNzw4HPYKbyonvHYIEIfZiceaSgw7+uEV2/tZ+JcvDOc5J6Elxdkxt0qJ
         Yv1t3FPCBbcAxvIfdjPj9qwG/fFBpuxTzFW3cqFES0cXH6U6LF7lV/nwuhWaVlgiFsdd
         wk7GKelZeVNtbd1mytTz7VtrYh+Bt6dRECDNfCdHgtdBO07xiAd00JHuwQ2DEJWOs09Q
         53EHmMvRai28+nZzMSue/J9ZUaRVqMzoOzQW/xtqcV5t4C29kbuQ6mUA24LQy13z/DDA
         xk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=YX0QiQEY3WE2XcasrrlnoZ1pxOpEiFQnY5itsg/ioaQ=;
        b=Kq/1TydU6pzJhnUqrljlJx1TsD4S8yOcBQxRcyhgHTOGFjMsN/CiBcU/kQUXbXCgwl
         unkGprNaeVqAiNeqErvowlyZ4SiOLY32+w8VxnEe0zx/6kXTkIrT1dwNHGgoyF7UpRx4
         cSjsX4zVGWRzHT1z+8OqHCxth1us7W7kpmXBpEmxvGsV1lEE/blEXJ4gyhmcmKQd7lq4
         28ChL6FJRkLp/MSAokTRGLJqtrKKIZAVWbFt7RpmXhhtzL5hrwkCHp5HGS5EuRwyuDYJ
         19URL4whk7Q0kPXr0ydX4sRvGcFiNEF7nIYDpffagt8qpmnchFVGkkRoOl5RS0hNHu6b
         R2bg==
X-Gm-Message-State: AIVw112JAuDuijnhwA5dOkuc+RitP6UTYT6wS/+NCdwlc/F3LeVpJZ3V
        +II7sUqXn/OCQg==
X-Received: by 10.99.160.25 with SMTP id r25mr10323826pge.6.1500742912802;
        Sat, 22 Jul 2017 10:01:52 -0700 (PDT)
Received: from unique-pc ([2405:204:7301:6473:d1d6:310c:7d8b:6df2])
        by smtp.googlemail.com with ESMTPSA id k12sm13632981pgp.56.2017.07.22.10.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jul 2017 10:01:52 -0700 (PDT)
Message-ID: <1500742926.2744.4.camel@gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     =?ISO-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>, m4sk1n <m4sk1n@o2.pl>,
        Vitaly <vitaly.gorodetsky@gmail.com>,
        "Ying Ruei Liang (KK)" <thumbd03803@gmail.com>,
        babycaseny <babycaseny@gmail.com>, johannes.schindelin@gmx.de
Cc:     Git List <git@vger.kernel.org>
In-Reply-To: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
References: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
         <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 22 Jul 2017 22:32:06 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-07-15 at 21:30 +0200, Jean-Noël Avila wrote:
>  * commit 4ddb1354e8 ("status: contextually notify user about an initial
> commit") plays sentence lego while introducing colorization which again
> does not play well with i18n.
> 
What, if anything, should be done about this?

-- 
Kaartic
