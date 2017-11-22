Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E6120954
	for <e@80x24.org>; Wed, 22 Nov 2017 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbdKVTJY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 14:09:24 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:42094 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdKVTJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 14:09:23 -0500
Received: by mail-wm0-f50.google.com with SMTP id l188so10712078wma.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 11:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9MtQzHz2tjlCP9SF+O1Xg8wIcOkrpxfmckkqLjWoIg=;
        b=c5KPWkVilGP3yfz0eyw0nfGw0kIzKyADh+8wJMnyw27wKSaa547HSe2bW6zuCxdBsr
         qQqZ4mduGrJ3zPtBTPLG+kD8xQHfzu8iMtNR4AXInp3qt9IFzB2orQG16BHUB5hPYFuQ
         js8jR73vVAWtTojI1MAx9uSCCXWDkLXnZaAY759USkQ6oCJtFixEhBejZr7RtNcTbJxw
         Hv4ZQCPJBTsXmQAlh2rI6A6vG8wEehzMIKP/ohVNP4tMbjSRY6eOLKOR90ucuIeV/dEG
         tqAKNrIomk/RX0V4R3hb5kkjdhMT8x/WF06LI0EqmNpEHBKqJG2TJOA67mYGDdI/20PT
         S7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9MtQzHz2tjlCP9SF+O1Xg8wIcOkrpxfmckkqLjWoIg=;
        b=lDVqKfojtWc4nB0lxQEQQMtRRfED4ruMBJBhRJcFEp/y7mEpzlC0iDXzxiXhCDDG+i
         jSEV59xfIHu58VwDicGqF0fKQ6CjaGWy9/CS8RTxRcf8Fjg8kNNGYG3ssOGCF8k4APRQ
         dwIU4AFwHlZ54t+kQMvXJHSuT8uhDprzBbHF3+gaT14U3FrfyugJddul0Z305zFLc6dp
         vpKmGIdXSs7zDV4zs5GElhFT/YFrn1a5Zoybw33VjCUbZZTWRvVA0IoMdR3PkaAx/IFZ
         SiUTsaNY2f3xePkmwPHVdjGa8QbhewV2bhBd4Cj6KQZtMmnmazjWJNpCbH4BfxboPWdl
         KYEg==
X-Gm-Message-State: AJaThX7+bcCinLF3g2N4Z0/SgPha/AYec3lMXQ5ZiVkkXUxOXLcMOBUo
        ZOWxkQZBT3lq/2e+5+X7W8pgzg==
X-Google-Smtp-Source: AGs4zMaPv1jD6YH0yxwYNwVRuZgoYzyHtCAEUuKxcKbtDAdxBQkshBDA+3fkp0FrJRnkYhiJUM2iag==
X-Received: by 10.80.221.130 with SMTP id w2mr16653302edk.226.1511377762720;
        Wed, 22 Nov 2017 11:09:22 -0800 (PST)
Received: from ?IPv6:2a02:8071:3185:fe00:74ed:c8f9:e099:ae6b? ([2a02:8071:3185:fe00:74ed:c8f9:e099:ae6b])
        by smtp.googlemail.com with ESMTPSA id h2sm11168581edf.39.2017.11.22.11.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 11:09:21 -0800 (PST)
Message-ID: <1511377760.11458.0.camel@gmail.com>
Subject: Re: Documentation of post-receive hook
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 22 Nov 2017 20:09:20 +0100
In-Reply-To: <xmqqlgizyv0o.fsf@gitster.mtv.corp.google.com>
References: <1510872031.23230.7.camel@gmail.com>
         <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com>
         <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com>
         <1511112703.8109.5.camel@gmail.com>
         <xmqq1sktoiih.fsf@gitster.mtv.corp.google.com>
         <A82275FD-C9AC-4632-A5E8-ED86CE2AC67D@gmail.com>
         <xmqqlgizyv0o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-11-22 at 10:14 +0900, Junio C Hamano wrote:
> Your suggesting to mention that particular message hints at me that
> you feel that the users may not necessarily understand that push did
> not result in any update of references on the other side when they
> see it.  If the message was clear enough to them, "when it reacts to
> push and updates" ought to be clear enough description, too.
> 
> And if that indeed is the case (and I would not be surprised if it
> is, but I suspect that most users are clueful enough), it is not the
> documentation, but the "Already up-to-date" message, that needs to
> be clarified, no?
> 
> Besides, we'd rather not cast the end-user facing message in stone
> in the documentation like that (especially when the message has
> known room for improvement and will change).

You're right (with everything you wrote). Your proposed text sounds good.
