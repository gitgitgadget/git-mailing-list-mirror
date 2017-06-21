Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9839C20401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdFUSMb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:12:31 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36663 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFUSMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:12:30 -0400
Received: by mail-pf0-f172.google.com with SMTP id q86so4507372pfl.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=G4tRlrOnnX6YUO3W6Y5G40qmCPbSNcXETTATI2lCUjw=;
        b=pG/l5JDX5A5ZAnEHjXaTNDKrao0WhevX0mfgmwoofxwdj2ChOabuB+5tXQd1rAZGiq
         0di9X5QNQO3qAkdReMxTU0hORaiKWBaIgq+qJq5jN8tBsYdqJ7ANJGJ9d3Sj5HqlWUvz
         e0KH/w8R2olRPbLG2ip/n1fxR9dDxB1n+OsCnQqmBePNt8sBcBLh7SxfuBWTut/9wLEj
         bm+UR7IpGHKp1KhPAIzi/gQ6sJvOPrfinBbRWOJUKISfDlA6DI//lb6XNYZ/nojB1EOd
         mwdkV6wQ07coskm46Zsd23/jY0Mwq4tfr1os+Tt33FP6VF17DHtkABk52zGga6Srb12R
         254g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=G4tRlrOnnX6YUO3W6Y5G40qmCPbSNcXETTATI2lCUjw=;
        b=Jr3W3AVmNfxmQdIVtiZk+4sW2eItrCK6uTWg/SeaL8wuPrLbc13MgN4uh+G0CNyQx4
         a9LU78L383/ih4AslVyXccdmrd0N0Uwx/Zstxz/UugN0/G63Dvy99mXrZmdI+5EWOWKn
         ndZzA6++YQCrzymD1wmD8PdZndUso2R8kSscYq2H/qQlTutuT+kf+chbCd283rZkRIMz
         JP3UEYS+elmsozAldopefXKUtStyD68NZm3fn0b/vxMbsS3FiNdSadsLRYUPcUU2OgW1
         ImtVGhcMu91Oiy5XOk4V13PMQKXomlOu5drSAaZlZaN+KbcuFg4dyfqJUBSMFJqN98oK
         bXzQ==
X-Gm-Message-State: AKS2vOzRRrfpqK2lxPAXzYUIuFU+t7dQ2f0jxCbGnYwQooYCXEYaDDvf
        L0lLA2uIuRKNbxfsXpS9iQ==
X-Received: by 10.101.91.8 with SMTP id y8mr17417213pgq.207.1498068749747;
        Wed, 21 Jun 2017 11:12:29 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id j6sm35281655pgc.1.2017.06.21.11.12.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:12:28 -0700 (PDT)
Message-ID: <1498068738.32360.7.camel@gmail.com>
Subject: Does 'git config' accept the '--remove' option?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Wed, 21 Jun 2017 23:42:18 +0530
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

Hello all,	

I recently noticed that when I run 'git config' with the '--remove
<non_existing_section>' I get a warning that section doesn't exist.
When I scrolled through the man page of git-config I could see any
mention about the '--remove' option. I only see that there is a '
--remove-section' option. Sample output,

> $ git config --remove test
> fatal: No such section!
> $ git config --remove-section test
> fatal: No such section!

Is this a bug (or) is the documentation stale ?

-- 

Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
