Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296DE20196
	for <e@80x24.org>; Thu, 11 May 2017 16:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757945AbdEKQfP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 12:35:15 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33461 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757906AbdEKQfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 12:35:13 -0400
Received: by mail-wr0-f178.google.com with SMTP id w50so26150354wrc.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1pvwksKYKE+rYl9qv4qJHsOcpvWryFVT8NxjUWWCdSE=;
        b=JJF/ehTB2tLAVYqAcTPH76zbrUxfMi6/FXptBRF3DRDrjbcti/PP5ddeFQkNmV1sKB
         7RxeSeULNODmPKlRug2K0oxGLfHnV4ASLYPYcMb4Na8hC65dKEFErayk5/PdZHTs6+VZ
         UylIsgCBG+i58r44FCgBOmS5OrywESBC33GUIj+u7JV8fPMSvb2ecySFFpJ003Zwptdk
         2jm5bibqVM4Wk8Rb/zAPDGORv/EKGP2/R2S9xgJmI7PqZJgPM2i7kCqzP8G6e4GgrsT1
         rsXeimuq4MPeAbOwIKRbCI8U/SKKR3iNigFud6A+AVKN6FSDLK8uhVQyTQ7tEa4nv8Dv
         sn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1pvwksKYKE+rYl9qv4qJHsOcpvWryFVT8NxjUWWCdSE=;
        b=EqH27fbuDrWVad8nH6DydtuW0Icb+8nlLt63syvZ//ulj3MW2rX9ZrRcAO+Evcpurx
         UsPzREz0OnORRcH5bDz7yU8hQOGDF6PStggeucAVlsTfUGnvfvkYeG7qRI4TlUZ6NyCP
         r/WZ0yN4HNKS4n3LKgXzS/gnLZqkFh9+j+wulTGzcUbNkCu2gxWKs8BgoEqGWcE0A0yx
         yDVBBKtNH5RNLA2tsnVW5NaEZmbjr+DrWStqcmJVgvSEpe59j9F0aYrBSANtxTU6WwaW
         9US/hDiy/Wt0EOJ184p1vfFu5CyA9AtBuL8E79QCWWP2PWuG4Hwz/XeETS9HiPVDIpSo
         fb4Q==
X-Gm-Message-State: AODbwcDFPaWPPKeZyr3Ww6OfNqq6lJYp7qG2Bapmn+RNCV3mONJ25ahZ
        WqeDt1XR3/tZeOpq0iE=
X-Received: by 10.223.134.80 with SMTP id 16mr29006wrw.62.1494520511361;
        Thu, 11 May 2017 09:35:11 -0700 (PDT)
Received: from remcw58g72.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id y3sm652167wrd.23.2017.05.11.09.35.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 09:35:10 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.21.1.1705111509120.146734@virtualbox>
Date:   Thu, 11 May 2017 17:35:09 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <34AABF45-1F6A-4CE5-8FA0-C97452DD37B3@gmail.com>
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705111509120.146734@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 May 2017, at 14:09, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi,
>=20
> [making sure Lars reads this]
>=20
> On Wed, 10 May 2017, Junio C Hamano wrote:
>=20
>> * ls/filter-process-delayed (2017-03-06) 1 commit
>> - convert: add "status=3Ddelayed" to filter process protocol
>>=20
>> What's the status of this one???
>> cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>
>=20

Thanks Dscho! I was holding back my new round as I wanted
to wait for 2.13. Right now I am traveling but I will send
out the new round ASAP (next week).

Cheers,
Lars=
