Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E2E1FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 14:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdF1OsE (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 10:48:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33299 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdF1OsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 10:48:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so9348596pfh.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=wLK2WxPxH+nCyM3+PEFrgdkCBaUtuSJFV8Ln+yRzfyI=;
        b=cllSt2zYtwhp07bhgH2eYa4VpP0eLqytlpz4YW+f/Ll7dcJlxtWOuSszvm/8WVPvdE
         iuQ/LQlalPwhA49nFYeteSoyhYI2e5oakLEvJDXL/lTtKLmL2bQEqnykyJB1ccyw/3FA
         yW9QPA+zvSCNlMobnqocbzuxjx5/7MBz9x/Qntf+z+bpT6xBHw+vuI2PMuiA8cyF9AB0
         kGBPdYpzT+FzL9ylna6fAFFhrdY8GxME69zD03N8PyDOJN96NUd1qPAC3xZfDUDk2tYe
         pwM7iYK11en+40Oubmh9IpWg2jyohgQu7uB0xb9VZcFwQ45UrfnYMquDkUVCQYtLlROp
         Jeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=wLK2WxPxH+nCyM3+PEFrgdkCBaUtuSJFV8Ln+yRzfyI=;
        b=AwE8GCuDkstYIhC0mnJ65SLbYp1tI/WmsjlUBdRWjrqQGWQGqG7QgBwt0CGuPdB70o
         SBRU1FLCvYjrSlO/3NE9CccQ+OgqG2AbiFSuYJHJqx9gxCzkqXGT/euiqbAfRc+JCRIE
         Mtd2WqDYkgaON1OMeLvvLO2BYgiLZcqouugQeJZyJtbtLk3k0Ky3w6b9Sz9WgdiSBvDs
         rFYJayu7P3RVOl3DT1e34AIQBJXtq0K3DwQCBx/bNJoUSjeHTNtX9AYOUUxAsvFC4D3g
         NVXXYlKqN8rfyKmxZz5FNgqAQ7TmpK+26267lIV5+vla9YKzyPPuwYnvvPAxegz0urkE
         Y/BQ==
X-Gm-Message-State: AKS2vOyxAsVZ08Zchw6GSrB2npG30+U9gF8I/WSk0FRzI0MkngOs8mfD
        EQMWqgJB9jaV+Oo6N6Q=
X-Received: by 10.84.128.67 with SMTP id 61mr12644405pla.246.1498661281896;
        Wed, 28 Jun 2017 07:48:01 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id b8sm5899288pfd.65.2017.06.28.07.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 07:48:01 -0700 (PDT)
Message-ID: <1498661277.10011.0.camel@gmail.com>
Subject: Re: [PATCH] commit-template: improve readability of commit template
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Date:   Wed, 28 Jun 2017 20:17:57 +0530
In-Reply-To: <20170628132910.7940-1-kaarticsivaraam91196@gmail.com>
References: <xmqqwp7x1fie.fsf@gitster.mtv.corp.google.com>
         <20170628132910.7940-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to add the RFC in the subject in a hurry. Please consider it's
presence.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
