Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_SUBJECT,
	PI_EMPTY_SUBJ,PYZOR_CHECK,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3D01F453
	for <e@80x24.org>; Wed, 23 Jan 2019 10:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfAWKvB (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 05:51:01 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:33104 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfAWKvB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 05:51:01 -0500
Received: by mail-yb1-f169.google.com with SMTP id g17so698609yba.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 02:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:message-id:to;
        bh=RSCiMCQs1TtLVD5smq3HzDTTN5H5bt0Yo0h/AIXDUpE=;
        b=lFgMYlEZ2sZ+b25UCnLSB+2pM2JQOVHN6Xt8KWtQ3wWaZEIjtQjx2TW05wcHXaXJIM
         7OiM9KZpqwK6uMHaFr/267zzHRmGdUZaEknalKvoknrTIn8ihEA3RCrJ5gaYDKORxcAV
         RYpNIH4iVd004r6qeWo6E+U81HcBSQYkT6Sof2e16Gt38eGMtiS0JihyuMw+zryR0VcZ
         OYGni27inQK8T90IDKdYaudXDH/oZI9xg6aGBw0HyRCU64WdnfHy3VZFZgyjDc/UW0Is
         F5SwN1BOqzXJWixJoXPj+ixo4/3BtFMUXnVnFULR8k7+L/98paU8Sc+U1Isx2bAByB/q
         Q2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :message-id:to;
        bh=RSCiMCQs1TtLVD5smq3HzDTTN5H5bt0Yo0h/AIXDUpE=;
        b=MF/gPUD2f+sRFjKfNVIXHE86Da1QmDihj6DQkIOsMYvtg88G9R4l6JFhBg2e1WE2Di
         rWw0ilMlCOTYJFC6uu4iAAnYnhnTVSEt2XG/BQKMM1UNTlDHYakbtAQOHB7ik8trqKX9
         IIdSOqoBQwLHCDKvsHv3QQAnmvQ8PNiptXJUrRN2yl63W7rQCuIDcXrAoQ8jAO1FUKjP
         uZTyESJKb7lO+PmVQpn+Y6x35Xoee3SgxyOV34jpEcXQurx4eoFdjAhcuFUy7NlKKQE6
         BdWxOkRBDaMv/ldqG2gPu6jolRtaRfX5PWXACBhW3iFFkaqkI+8Z8h+O1JUUw+rBghu0
         YY1w==
X-Gm-Message-State: AJcUukdo1k/3pttZeyBlFPa/bivsfA0zOdY0yAyPHSu1fafFkdi+AXVE
        sBaSlRTVbOaTBpkKu9mMgDIEs0qS
X-Google-Smtp-Source: ALg8bN5kBfdtK2EWRSa7klIyyN7uW2GJSXv4bHM30yNmLhUF3KScJRy80PvTN3GbK3ZuY7bv/YqChg==
X-Received: by 2002:a25:b80e:: with SMTP id v14mr1355311ybj.387.1548240659749;
        Wed, 23 Jan 2019 02:50:59 -0800 (PST)
Received: from [192.168.0.15] (user-24-214-138-140.knology.net. [24.214.138.140])
        by smtp.gmail.com with ESMTPSA id l83sm7465501ywb.23.2019.01.23.02.50.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:50:58 -0800 (PST)
From:   Christopher Hagler <haglerchristopher@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Date:   Wed, 23 Jan 2019 05:50:58 -0500
Message-Id: <4FC35B6B-457C-4E5E-9B00-7C80F075963E@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16C101)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unsubscribe git

Sent from my iPhone
