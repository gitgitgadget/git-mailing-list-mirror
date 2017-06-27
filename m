Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277A620401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbdF0RRJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:17:09 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32982 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdF0RRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:17:00 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so5038173pgb.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:disposition-notification-to:date
         :mime-version:content-transfer-encoding;
        bh=GGHRzklH55pkilpv4Cnt9m5WRV3az8gwbKch60/tBFQ=;
        b=WDi0+f/4BeHzPL5+7N2EREsxRW7CWusYZAKjDLe7qkjlGv673EgwmXuX0AkVXiRMHP
         Dc7TLnMJfoweEk9E9Ig63/sWoMRMsaOAngBPkehOj8ri2svx/Z4feViGBB8PS+mVhH/n
         Ud0G5htE71tyCPxAMO+NozPb39PA35T1aXtDTP1+vobNk/L/zJZ4PIISi3GsASXuWsb0
         w6QrZO+9AkTIT5u8FmSVB2+SzE4dGelcl7NHsi6umbKIxJTuF63zzRkRBNj16IwLoa7Y
         UHE15ooKuvTxpAReyr3LcRfOtZA1g5+7GQWxXtNLVfV5wCTcRjaUdvJ8Ogx/wOAnXoQa
         GMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to
         :disposition-notification-to:date:mime-version
         :content-transfer-encoding;
        bh=GGHRzklH55pkilpv4Cnt9m5WRV3az8gwbKch60/tBFQ=;
        b=mjqZMTXnLFyAK45AtnsLIokrz0EjX1fkBpxsobxhG6pYzr6dTOX8ZNJWO+erm8o0jn
         iVTXaxG3S+OqE3X2uIoORX5i0qDgsElKi1XTo/M90w9Lbn6l2q4lztjrOZ2TCrUSSNH9
         tdISB/pQsqnfgOy82iyJsMzh2qrjnrYzJmah8hjt8xW6995aWRAhR8eKniZ+WSKcB3rk
         gMWO6WhgnA4qPnS3DYVAJOT9ucYj8wgtnXtE2x79PHcUJ+CKecj1r17HtapCATOroO5P
         GoGrDoCFRiwHo0DRqCbRlaHQkBwBkUGENrNagAf8A3DnRHEcgNsTNa2UgWv93Y/rKDG3
         vT9w==
X-Gm-Message-State: AKS2vOwrl9uxted72kknm1YOkWWFX7k+5W3djzdMY4DlPWtEr+cPT+Lf
        pqi/tjnOQCxfK1ozAO4=
X-Received: by 10.84.231.134 with SMTP id g6mr6907066plk.86.1498583819780;
        Tue, 27 Jun 2017 10:16:59 -0700 (PDT)
Received: from unique-pc ([42.111.175.240])
        by smtp.googlemail.com with ESMTPSA id r27sm8055435pfe.0.2017.06.27.10.16.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Jun 2017 10:16:59 -0700 (PDT)
Message-ID: <1498583779.2737.4.camel@gmail.com>
Subject: Requesting improvements to "status" in commit template
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 27 Jun 2017 22:46:19 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

There's an attempt to improve the readability of the "status" shown in
the commit template[1]. It's been quite congested (at least to me) all
these days and thus this attempt to make it more readable.

In case anyone wants changes other than those found in that thread
please send them in, likely in that thread (to keep conversations
intact).

Thank you.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
