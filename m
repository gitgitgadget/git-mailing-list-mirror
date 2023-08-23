Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB2C27C40
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 20:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjHWUlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjHWUkw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 16:40:52 -0400
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAECE54
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 13:40:44 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-14-64e659d97099
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 5C.14.10987.9D956E46; Thu, 24 Aug 2023 00:11:22 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=TtZhIDKW54izLbkd1g/a+gvCwnsaqxckTlAtf4t9FZ9TWJMX5MhAjEZ0VFBTDfBMY
          hjX534n/dqwutevCjp5j1FcAz0tKt4y8Ga7jQoX60lMz8QYWBDQ7mMEN0Xn10VKco
          eaIoeP4xAR0hEFMK+wv/Np6nPQHtqIJW82hYFgZJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=Cwy/L/XnJNPCe9KFHd0GFii5UJaQqbI9EfraHaPYJmJUnb3O6MDPAfVetLCVtkn4m
          oENWkgZH7kyIaClhEkZQ4gIUDhz2S28K+GmrSCaPaMgAh6Hd480I+x+dc69fvPuxY
          tRYku6ZVJCgduLIBYjbOvVQS2EquHLitgUqlGkaqQ=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Thu, 24 Aug 2023 01:37:41 +0500
Message-ID: <5C.14.10987.9D956E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     git@vger.kernel.org
From:   "Chen Yun" <conference@iesco.com.pk>
Date:   Wed, 23 Aug 2023 13:37:56 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVyyUKGW/dW5LMUg2kzWC26rnQzOTB6fN4k
        F8AYxWWTkpqTWZZapG+XwJWxZN0FloLdzBVt/YtYGhgfM3UxcnJICJhIzN51na2LkYtDSGAP
        k8TGnbMYQRwWgdXMEnN2v2GCcB4yS7w4f5wVoqyZUeLW/pXsIP28AtYSW5ddA5vFLKAncWPq
        FDaIuKDEyZlPWCDi2hLLFr5m7mLkALLVJL52lYCEhQXEJD5NWwY2RkRAXOLt8ZlgNpuAlsT/
        +XvBRrIIqEq8enoJbKSQgJTExivr2SYw8s9Csm0Wkm2zkGybhbBtASPLKkaJ4srcRGCwJZvo
        JefnFieWFOvlpZboFWRvYgQG4ukaTbkdjEsvJR5iFOBgVOLhLfj5NEWINbEMqOsQowQHs5II
        7xefZylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW2FniULCaQnlqRmp6YWpBbBZJk4OKUaGM84
        HxIzruqXO3HAONXL0kuAT8r8++FD7tHK3leDfy5q10m0dVLaN/dpoKR3UuEk13l3dV9fKBAz
        /n00x6qpyMYie75zb6pZk3jX86JJtx7oa6e6m3J49a5dGHnPmLlON8tFLkm5aoGI6HOfmM+O
        5XFMgQKHPj/zWb3j8ddj3yMOP427mmGhxFKckWioxVxUnAgADbTR/EACAAA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

