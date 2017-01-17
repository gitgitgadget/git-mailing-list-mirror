Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F327C20756
	for <e@80x24.org>; Tue, 17 Jan 2017 17:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbdAQRIC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 12:08:02 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34704 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdAQRIA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 12:08:00 -0500
Received: by mail-qt0-f195.google.com with SMTP id a29so22904921qtb.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 09:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HHjl02cLS0H0DTHKXlf2uM9FloLuvkMFYuN88ABl4FU=;
        b=DJ/Cbx3bFl8JCvlJ3iBtJ4B2eXPAYM1mrT1GRv8zlKQvYiGQ+Ahh4Od6lSf0vLfAIx
         2KAHCThwbC1pRjx+lzADgAsLb3FPT80HEJK05/kN2f43tjtFTpgimvQ0eTsnQReIvY8F
         byd92SNSoExWrhXKrES6GdsSm37G0y+c3bJ8CZUHWI4SNezMT8Mtqs6Lhshb9kI3d3oR
         R3DWD7lyu5m8AssvFJtpojlrXs4EJkxeNxkIRhJiUQTW30N5y3jxxPKewPFmqqKdb9cJ
         Gk9Vr/NRTO1Rxb1iFZO9FmZfechxhrQ9vTPEQjBSjv/btIbydIhg6SQcUFYqswnmnm+3
         CgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHjl02cLS0H0DTHKXlf2uM9FloLuvkMFYuN88ABl4FU=;
        b=BPETn1gcOsMYDM0iVlvrYfrE3jrGvfzJIilmFYT1kXAgf0L0c39e4+5LvHK4nkuXbL
         +XvBt96MxKkcC7GYqcQ2Ejwge02d+UXXGoU+i+uPYOHDmIVWqZ1vH/0e/KLn1IR5NYgE
         nKi2hPqFeFPdi9X8A+kny6QjZLBdHuB9CCl9heM2UykyNE1bXLH/87QxJn2MkF0vJ7lp
         0mn6AZBnMePFx9ENU8/9uGQmxRznrwTgcoq8v9L3irPTXvUQjtUt0S2r7TDDmbGwuhaY
         4rkDxhaKoAgIGO2BldovG0dKiGmCp96NxTT3iJkVuStODHiFYKa4u/7B14DGux/bLVd8
         XRCw==
X-Gm-Message-State: AIkVDXL5eiVdMZgSi83OjnkxJeZN89/i9vEOQuRTiMqvRgSibNDXshQee1mMmSM/ZMOkYc2z
X-Received: by 10.200.42.182 with SMTP id b51mr33670461qta.101.1484672419852;
        Tue, 17 Jan 2017 09:00:19 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id y52sm19289698qty.11.2017.01.17.09.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 09:00:19 -0800 (PST)
Date:   Tue, 17 Jan 2017 12:00:19 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 5/7] builtin/tag: add --format argument for tag -v
Message-ID: <20170117170018.nqk4yy5rrpomxr32@LykOS.localdomain>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-6-santiago@nyu.edu>
 <20170117153404.jp3ftdlzeyut6e7a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ma5mzdvcytznn6r"
Content-Disposition: inline
In-Reply-To: <20170117153404.jp3ftdlzeyut6e7a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


