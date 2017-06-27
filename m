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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3755920401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbdF0RVW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:21:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33440 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbdF0RVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:21:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so5561137pfh.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=dE0ZFxiK6rwPyhhecu3zwKUBHsqZIUen1HkVR7pb9tY=;
        b=JHtR7weCcNgliUZIm9IP9yXw3UOV/NcE+Cj5RmYayH18ik2y2RHX/+x31JogvF+DT9
         G+DH328F5d7siDPbzGW31QZYpj/rDLAU0WXrcNTi/+g6o77oAV37xt0uv02iclPh/omY
         VKK27TXZWMT6G91Yy25woKsKIpqvKYDkPmZ914Mc0ZUpcZ/iq/aoYkFKfLGYVMiB+drk
         oO3uizqRKD46VqSquS6HMC9DaS1c0wOFjO1ZVZauzaJAuO/hY4t2EFztjq8S2J0xiOuV
         +jRH6Zj6XHlIoi7Jkn/U5Ksor0g5rAuUlnUJ7CdwbfwgNcVwvUp0iYj9j2WDqSIa42xK
         bvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=dE0ZFxiK6rwPyhhecu3zwKUBHsqZIUen1HkVR7pb9tY=;
        b=HBt3gyBUKDjMNMkFfF50/pOp5KH8oY7ZDTRQ+qpgEx7QHZpiRsNN1NV4KoFR7yngHk
         Dp7Yue9u0iuvzj99vfE+bjNcZ+ggfjyJwGoPCtbfrWiGvuHqfxBgSwF99ChkKiGN+wvp
         TDxOriBs00haNzBKaJQRT9rsTOzQ18s21unEELB6nDOaPZ+Gt/H9QkUBHAUsHKxQl+xg
         QDU54KupEppcbzO2CTJDRggcMc8eJvFc4wevPOAj5wki/pQU55F3KGDBzBNHaa+N31X7
         w4I0EzueN8XVW1vYkVo1jNxUdsXw7s5/Dwsym7cRemHQDom5Jv3A/qmfQtG+b7drYnKq
         EyPg==
X-Gm-Message-State: AKS2vOx6/I+4jEukkyVkJUL6LGBzpJW0HcFNrZi/fNGBkZ6F4Qu5O0jN
        gLRuyCamXL619gxyBpY=
X-Received: by 10.99.154.18 with SMTP id o18mr6262229pge.251.1498584080511;
        Tue, 27 Jun 2017 10:21:20 -0700 (PDT)
Received: from unique-pc ([42.111.175.240])
        by smtp.googlemail.com with ESMTPSA id f87sm7216739pfe.35.2017.06.27.10.21.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Jun 2017 10:21:20 -0700 (PDT)
Message-ID: <1498584075.2737.5.camel@gmail.com>
Subject: Re: Requesting improvements to "status" in commit template
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Tue, 27 Jun 2017 22:51:15 +0530
In-Reply-To: <1498583779.2737.4.camel@gmail.com>
References: <1498583779.2737.4.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-06-27 at 22:46 +0530, Kaartic Sivaraam wrote:
> Hello all,
> 
> There's an attempt to improve the readability of the "status" shown
> in
> the commit template[1]. It's been quite congested (at least to me)
> 
Sorry, here's the link to the thread.

[1] : http://public-inbox.org/git/20170626172433.19785-1-kaarticsivaraa
m91196@gmail.com/
