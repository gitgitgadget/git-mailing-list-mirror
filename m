Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4581F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 10:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933169AbeGJKle (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 06:41:34 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37438 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeGJKld (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 06:41:33 -0400
Received: by mail-wr1-f51.google.com with SMTP id q10-v6so14066321wrd.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WizTOcqK2QUWESK07N1vWaTGDlCCgsTBpGTGiHtitIQ=;
        b=q3qiLEXRR9SpTj4TkbIOJEcsI93Wl4CPcm+deOWqx2oTdcSgVAn1blmplDN6ZhTASK
         GjhM32ntBPP2fEBHhUsTlry+NW66HcgnLoGd2Qi86Srd7F0e781S6lDEVHC2Bjamjcps
         +a8rxroloU/1lSdsLYfB999go9BDt50rR/4RBJXqnDLkhPivODMPZKV3XRA0FQAZ9CpH
         A5mr4MgtoIj0HUodhZ+XjCgTm6in0vlIgvHWm05tjXYFFX83G2KuGQVKS8UQv8h2pPRk
         nmplv+aRlwZ5m5PcqXVObCgS8EtUT4LeUZnkRjwW/gQEv80UmA0QpdLwfnnqS/bcteaa
         bMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WizTOcqK2QUWESK07N1vWaTGDlCCgsTBpGTGiHtitIQ=;
        b=QxHij/nK/VNAgUF7MRp9U4pXuut3Di7V0qHTjfaPxK9adSE/X9AobegQrTmhYeC9x0
         SGgUOz60tpkIkh/T+ghkuXPBW6SarfYhyx5S6AYlBjDnOH3zdv6Q0/NZdTmY+VjZ5WzC
         bXxiscLBu1Gz/Kl6PrFG4BL1tvDOBqXNa9iUw0RXUxoUOSazQdFuSSdRScNA2trwISps
         +wssq5FX77m0ZNps6I7PKLCMuygs4opQZx4BYibpDTK9Vl0gOPHBtHsW7uxJe7xlOvhI
         HyIV+pKVi/xxPcMm4MfPViXXji/k3NR/TxmP1h25I0L84A5YHbBqCSMsNwyMKPfVxdV0
         RfiQ==
X-Gm-Message-State: APt69E3KvM732EY6AXnbgkF7hhgpiHqWfPOJmo+DF7r5g4pXK4bI2tpY
        30GRP4JnzoJ5V0wM7CyCgxSVa12N38wEB7FXtTA1kQ==
X-Google-Smtp-Source: AAOMgpfobM2mGAPvG24H3aYZ16064/Fh7X5nVcItDhUbLhW90oKLuR5VJ8qiBzMMOSf+96n65aj1/jKeaYNUy50/+Y4=
X-Received: by 2002:adf:cd0e:: with SMTP id w14-v6mr16244285wrm.226.1531219292657;
 Tue, 10 Jul 2018 03:41:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c6:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 03:41:32
 -0700 (PDT)
In-Reply-To: <20180710102937.12499-1-szeder.dev@gmail.com>
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
 <010201647e19c24c-fd353913-225a-4153-aa0f-6ddf41ae6354-000000@eu-west-1.amazonses.com>
 <nycvar.QRO.7.76.6.1807101115570.75@tvgsbejvaqbjf.bet> <20180710102937.12499-1-szeder.dev@gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 10 Jul 2018 13:41:32 +0300
Message-ID: <CAL21Bmmm3rO0DjE5aq1NNMJYcUViG4GEXHSgqqmWMnmZt478sg@mail.gmail.com>
Subject: Re: [PATCH 3/4] ref-filter: merge get_obj and get_object
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fully agree, thank you so much.
I have fixed it. Waiting for other issues that need to be fixed, then
I will re-send the patch.

Thank you!
