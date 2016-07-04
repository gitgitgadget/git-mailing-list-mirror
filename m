Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79CD20179
	for <e@80x24.org>; Mon,  4 Jul 2016 22:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbcGDWNf (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 18:13:35 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37958 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbcGDWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 18:13:34 -0400
Received: by mail-wm0-f45.google.com with SMTP id r201so130105581wme.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 15:13:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=PlZ1vyVsK9LjyO7RcAzkLNXB7fmh1HkuGQi/Zv0XlzM=;
        b=HchEJNiXp/BWoGQMiSsAey2fgMAFh3wM0k8HTh6otSCxV2HQVkBkxgkH4kYyrSpHi8
         zaynbRYriTM8mDm3tbmafuJCt+K+3pCAHiqg3oJDB6T/l2UX3wT4/3leT9YkEo0UTYqo
         cD3DfuJ7z24AfcdgjDQVAKE4V73i1TntLoKGYrhiHw3RlS07lkPwJ53CgWGI/iTZ2/Yl
         7mZViOUmIMCRkZBPzW++CV+wtOSwWW/Cvcgw2AoiTHDxUgGRs1adBfQZyDdX/R8zBM9I
         i9Mf+WDspx5PcI0wgk2LEDKtK0A2fyujpbr+uNLzXSGmISZvquMSfmFz3EcA/38e+pxX
         Jk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=PlZ1vyVsK9LjyO7RcAzkLNXB7fmh1HkuGQi/Zv0XlzM=;
        b=LVbSzz/g2x2Z3/4H6iHFtDPhDrVbHR+SChTTabe+UmEoLdCENRF0gXJ5fQbrkExDez
         jz/0cbeXKSKV7izUmMyPRZWetnPRu9kJCTey3/tN2cT0dMAB5K3YV0cye+3B9hbFWPgJ
         gxc/CuZ0JbTC0mUue/6kkJQZ3hhzVnH5t9X9Y+os/viIVyxM3PJKlNX7p3cG7fpYqMam
         QZ2NSpIwukS8N+OQzl46Tkq7eZSPIlrgvH4BVE5fkrs3UxBLCZCMDFAgCkkB9xKKpqty
         74Yuogm4vK6L0ck3yP+k9R7Edbq6F1dankgX1qTlsGVdAEPBdK9SnU7/3eDWzYA+TpHI
         6eaA==
X-Gm-Message-State: ALyK8tLMgT7aC0klsf91yW4N0Fsa876oWHScJkXlUzZ87/ByXZ4ZE5xY5yLHe7MNbfOEkA==
X-Received: by 10.28.10.196 with SMTP id 187mr13390512wmk.48.1467670412946;
        Mon, 04 Jul 2016 15:13:32 -0700 (PDT)
Received: from christoph-laptop-16-04 (ip-103-010-005-185.cpe.my-wire.de. [185.5.10.103])
        by smtp.googlemail.com with ESMTPSA id g4sm5719118wju.30.2016.07.04.15.13.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2016 15:13:31 -0700 (PDT)
Message-ID: <1467670411.13990.4.camel@gmail.com>
Subject: Missing Package in git Installation Instructions (git-scm.com)
From:	Christoph Michelbach <michelbach94@gmail.com>
To:	git@vger.kernel.org
Date:	Tue, 05 Jul 2016 00:13:31 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi, I noticed that the instructions on https://git-scm.com/book/en/v2/G
etting-Started-Installing-Git don't work without dh-autoreconf
installed on an apt-get system which isn't listed on that site. Can you
fix that or tell me whom to tell about this? The website doesn't offer
contact information. Just tried this on a fresh Ubuntu 16.04
installation.

-- 
With kind regards
Christoph Michelbach

