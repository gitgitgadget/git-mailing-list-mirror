Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA1C202AE
	for <e@80x24.org>; Thu,  6 Jul 2017 03:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbdGFDRV (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 23:17:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35837 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdGFDRV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 23:17:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so1157784pfq.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=zLUWenRq1Q0YxIE8hb970dUIggcP2OIbPC+YlW3KT3Y=;
        b=g7Wa2XL+M/DKCBnJIwagVt+09Seic9WY7UCLYwDQaYrN018xVZ/gePRjKW8hR2VpkA
         3o39Ndc6jvyvAvc/Ev+iQV8Z/sJ9/0/yUCz/gfRIrzzF5YToGIgRfUjK81/2qElevVDV
         +NLIeXdldZ1y1ua9ZZ5zp7xsLdrrqmNqJ2OWCV81vJxI1dUgi5KsYENXOtpTRKWLQq4a
         lmTOgR0xZks7DCA1pW37gSkTZbpzOayEhQAPJfkB0zt4412K0aMMixwvTjBb2lpSrhnw
         rGUbEU+BTa23VhTBVbv1K5dAkSTLB5cPYPU4Y/t/d+ODk8aUQRohP1cCMCV7q0Hb2Du7
         rByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=zLUWenRq1Q0YxIE8hb970dUIggcP2OIbPC+YlW3KT3Y=;
        b=oWM5JDyaZEFxztYMc1IHE9fDno5i2nLhdY4hDtpzjYt4c2lSMoKaURINHZGjf4XXXI
         cRErejUz5np5XNWJzlgCrZDRKtM+BT+w8hRYPM0pEIo9f2I6ePj+DEdKTCatDJmM6e0l
         vYE/9KH197r1xkBLaqpwXBmcadeVXnVqs64VqA2bbtMqoxo/sU2RGT3qXCUOnRrGCBZ1
         JQkx3f9JzKizWfMghdCTLkBahInyH71pGqKhc7qYTcVoYVOjwqy/xIXwzJzyPK2sEzRK
         4avpb9EKKnE/JQWz5AZs2eM7klx7d/Ncg9ofgS4sVR5A4osL6a9PXXvXPHLuTxWqIkWG
         V4ZA==
X-Gm-Message-State: AIVw112+aqqNnpBAf+A7bZg9VGcaXXdJvYXzYSMd3CziImVUk1jb5Ec3
        +1LKjDb0lJsPK+dSKmE=
X-Received: by 10.99.44.68 with SMTP id s65mr19086041pgs.101.1499311040353;
        Wed, 05 Jul 2017 20:17:20 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id v62sm983481pfa.6.2017.07.05.20.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 20:17:19 -0700 (PDT)
Message-ID: <1499311044.1776.1.camel@gmail.com>
Subject: Re: [PATCH] comment: fix a typo in the comment
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 06 Jul 2017 08:47:24 +0530
In-Reply-To: <xmqq8tk2iw87.fsf@gitster.mtv.corp.google.com>
References: <20170705170324.21026-1-kaarticsivaraam91196@gmail.com>
         <xmqq8tk2iw87.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-07-05 at 11:18 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > ---
> >  Though very trivial, I wanted to correct this as I didn't
> >  want to ignore it after seeing it.
> 
> Thanks for sharp eyes.  Sign-off?  (or Sign-of? ;-))
> 
I should also thank you for your sharp eyes! BTW, this won't repeat
again as I have made 'git' worry about adding the signed-off-by to the
commits I do on my local version of git.git :)

-- 
Kaartic
