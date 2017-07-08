Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B366B202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 12:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdGHMug (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 08:50:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36639 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdGHMue (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 08:50:34 -0400
Received: by mail-pg0-f65.google.com with SMTP id u36so7190110pgn.3
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=5AeC7W/tA5Id7aE3VBSbmMSHq+LSjQnUTBjAUwJQGHQ=;
        b=s7Mtcn9b9XOI6y1wjFG6jjaqCBpXVyiIDroUEh2AzdLBOqdCeVE2FjRRcksTcWKkRI
         NXGAeWM3zjWtm0FrGAOajkEXBh58lBSYz6E2Ib4RBz7ubJa69yWrV4h8ZswzVrO41IvD
         zgBqa86WocuAzBTL7e4a8AgLSUR4a0rjeu/dSXCbV5aRU1onU1Qt38HXbbos6PHbrBwY
         YFRH65shWyrBDzI8kwHbnSRJzyEqbxNwdoE3j7ele1xdZi60kQYz2RfsUwJMH4Eu++oa
         z4Z4Kh8kFeyFR//RBLOwPwUkW0b83/7QQ/gUpq6XtPWfEC0S9BIQX8PA/A5QMzjnp1oL
         bEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=5AeC7W/tA5Id7aE3VBSbmMSHq+LSjQnUTBjAUwJQGHQ=;
        b=q0uNbwYye++PszDyvQMzJUdjmn98RHJ2ng+XoRumj0JZRto9pTfkeQLnS+K5e6CdNY
         2ubVEmk+Tms1HzPKHLr1/Jjp9KfI2mDrYpeAkDTjZoEybPWFlcLSUHvYzhzFW2WYWw8m
         RM0EObdHTxPJZB1T648HI2mt/2P0jUE6AOxFN3DFT7zLlcXnx6dIPjDqyxsNLJ/kvCTp
         tmiiyJWAUqpx5kso37bEM4M3vkxolVWWUOjZLwOSYQMu/CEyqtyZXE8NOVtDQz8mnvKb
         aJzkI9zK73/JFNGHLWINg5wqdWO045ZM3vfkxzLaD0aml7hdIIKgxCxi9YU0DheT8DvE
         gI7Q==
X-Gm-Message-State: AIVw113ayFmuEXGNQlTT9DcXnflwMz8RRbyxH+Y2+2iD+AOTh0oXtr7t
        UgXwck7bVqKNkA==
X-Received: by 10.98.224.206 with SMTP id d75mr36427077pfm.12.1499518234180;
        Sat, 08 Jul 2017 05:50:34 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id r63sm11008619pgr.65.2017.07.08.05.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Jul 2017 05:50:33 -0700 (PDT)
Message-ID: <1499518240.1914.1.camel@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #02; Fri, 7)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Sat, 08 Jul 2017 18:20:40 +0530
In-Reply-To: <xmqqa84gaw0l.fsf@gitster.mtv.corp.google.com>
References: <xmqqa84gaw0l.fsf@gitster.mtv.corp.google.com>
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

Just wanted to know something out of curiosity. How am I actually
receiving these "What's cooking" emails though I'm not a subscriber to
the mailing list to which this is being addressed ? Further, my email
address isn't list in the To, Cc or Bcc fields.

I wanted to know this as, this has been puzzling me for quite some time
now. I'm not able to find my email address in any of the header fields
excepting the "Delivered-To" field.

-- 
Kaartic
