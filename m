Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C37020372
	for <e@80x24.org>; Wed, 11 Oct 2017 07:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756661AbdJKHv4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 03:51:56 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54901 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdJKHv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 03:51:56 -0400
Received: by mail-it0-f66.google.com with SMTP id 72so1773772itk.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2+eJe9Ma47Pxnofxb2xWJ5soL0Ck3dofGEJhHcZdBBA=;
        b=NpYsmDMs6l+liYEEuO9OQQKv+/E5Y543ejdPWBmd2KPcjNoLdJ6v8yP9UOTtd7voFS
         t3nsjwHLgpdS5ydPmPdPvo0xfCwSyQ1Ul8XBaPb1tucg8AzAsPETaXlIWk9PlekCe7hg
         cJapCujRIwCxAY/4VEsTYqfbMISZ57NzSQ4PEs76cYNfotMNUkeb1Gu16eRAYJdMxRpn
         AwXBccTwReWNG6uThTuG7sp1QIa110TU7R2KhBJFORrzmguXE9ucktW+46KgP5A9wXxU
         1jfT4B5vjnPJVIro3WYldIEYACClT6tPbD+IkD9WDQbUqFnNw6KcUhOKBBo5AOHZQp1l
         Da1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2+eJe9Ma47Pxnofxb2xWJ5soL0Ck3dofGEJhHcZdBBA=;
        b=mL9ZLEXnjpohJxFKXxDxtsE/GpuQXdcnp0jVjoLumjciLfqzkFlsCRYU4n2G12jpKt
         dXk5xNaSyuAgXVRS51AncmfpnRLKMNnBxpkP4J44PS7qpMvzAPw+YsF0Z2cUpWtpcafS
         OAaXE5oGawnS9w52pVw4K4PN2YZ+zksQaeTpCRKCRhnpnCSc7/ouBi0Efhv6/hJB63Df
         onbU9nxvb96q1/RzgD6KrZJphjN2zyojFt6AWoZghEJs0eZXjPD5QevTanvSGVAyVpHZ
         Mpi35Ua7JxsSxsyAX/HiMlvArYnrtOJGKwQv2zCwiAhbo/LhZyqrdkUD9hKFT5AEQzra
         A1KA==
X-Gm-Message-State: AMCzsaWFQpqEDjIRQWN3Xr46gvlCyudWOJBWbKbVG0kZIjIL33KQUj1/
        9MksCtORXc7B7CnabVcpFRDrneN5f56VOyHH3Msptw==
X-Google-Smtp-Source: AOwi7QB6hoT7aDX8pJ6FNtyWmUEbQ9vpd+AlGhWGZog7kqOg0v+wgXfbBChzxZ249Ql0DLCIDG2xjNywx9BYUOG+nLs=
X-Received: by 10.36.65.200 with SMTP id b69mr23022763itd.116.1507708315069;
 Wed, 11 Oct 2017 00:51:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Wed, 11 Oct 2017 00:51:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Oct 2017 09:51:54 +0200
Message-ID: <CAP8UFD3ubxC0VkkOs=VWOuFNPosA_FyAYdUeVRN4-DdX-D09Rg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 32
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Andy Lowry <andy.work@nglowry.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Marc Herbert <Marc.Herbert@intel.com>, Eric Wong <e@80x24.org>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 32st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/10/11/edition-32/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
