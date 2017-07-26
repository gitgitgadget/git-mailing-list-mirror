Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE582047F
	for <e@80x24.org>; Wed, 26 Jul 2017 16:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbdGZQpr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 12:45:47 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36994 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdGZQpr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 12:45:47 -0400
Received: by mail-wr0-f179.google.com with SMTP id 33so77429113wrz.4
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8UTDH25lx5yI0P6YYrCKi+PJM8DmWVqKFQ2m8UgK/h0=;
        b=SU2UkLg298h6uwiAbb6GtYMDrkUswmUkNiBAEgk1N7JrJxsHdHkmqxpv32Bbsa6Gxw
         Upr1aanhfOnJ8qIEtTw1CO55wCNSeqa18mOTwK4IwLGUWzwESx/YTPZveasF8n6bP7uh
         BFkEmKW84gO4C1D6VQB2xoiSmyuHDSY+IMgzKs0Vab2vE9tyD1Gi1ctWb33O2MXpbvIK
         Q7Rw5SrpqFoTILOV8NqIVqnNLs1EbnDlaIz7Sx+baC7Igf2L3L8DF0rrCzApHVCIF1Z4
         rpVzScVr/nSLGKR8UsliZYC7MEGGA+eHcwh+qT0O/WZam5g0dmvSwnfN6tXKBcyXUpzS
         d+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8UTDH25lx5yI0P6YYrCKi+PJM8DmWVqKFQ2m8UgK/h0=;
        b=LdE5Ple5dAkDCY4J2a675OGYd/sCbCftM9NYz3UOC9BG6CfBhzHDYDkYfZdLvWdgJL
         cKhB52Gp3BmnR0yiLNU6pGLGuSbDm0uS/14T6FikV435iQJBWyU67f+9zPCwwT/Iou9I
         JLXprd1ncoxNcixazpoV7reSsLDCe2HqB3AmNWqNAkbTQhukLq91yN6xsMR0jR4GfsE7
         yTkXQWpZJSmR7ttBGUW/1bhhah2KkyCY0sL6GWHOTSUpDBNiX7shQaZR0ygVBKahmZ+Q
         fokX2mU/xj9rEb7lkbM8AAmlr8Jj1k2cqw4vB4tGreby1JYQD0MGysHYhbwo2vxmhQrp
         vlyg==
X-Gm-Message-State: AIVw113lnyJA3NlDweRrvNn16rxa0z2CDSZRV5fY4Hq1/L8DfW9rPqFH
        4kygOCSaiRdPAg==
X-Received: by 10.223.176.251 with SMTP id j56mr1335915wra.53.1501087545816;
        Wed, 26 Jul 2017 09:45:45 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id j31sm17932732wre.67.2017.07.26.09.45.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 09:45:45 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] git-gui (MinGW): make use of MSys2's msgfmt
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <8a13544743fd5e6a3b3b5fdb35e02c9c34695e25.1500971399.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Jul 2017 18:45:44 +0200
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <276F8090-61B8-4BF2-8D5D-7A6306880701@gmail.com>
References: <8a13544743fd5e6a3b3b5fdb35e02c9c34695e25.1500971399.git.johannes.schindelin@gmx.de>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Jul 2017, at 10:35, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> When Git for Windows was still based on MSys1, we had no gettext, ergo
> no msgfmt, either. Therefore, we introduced a small and simple Tcl
> script to perform the same task.
>=20
> However, with MSys2, we no longer need that because we have a proper
> msgfmt executable. Plus, the po2msg.sh script somehow manages to hang
> when run in parallel in Git for Windows' SDK (symptom: the Continuous
> Testing tasks timing out).
>=20
> Two reasons to use real msgfmt.exe instead.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>=20
> 	This hopefully fixes the hangs with the Windows builds triggered
> 	by Travis. It was a tough one to figure out originally, and it =
is

Awesome :-) Thanks for digging into this problem!

- Lars

