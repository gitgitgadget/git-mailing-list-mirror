Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0901F597
	for <e@80x24.org>; Fri, 27 Jul 2018 09:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbeG0LUp (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 07:20:45 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:45652 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730244AbeG0LUp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 07:20:45 -0400
Received: by mail-lf1-f52.google.com with SMTP id j143-v6so3141012lfj.12
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=Z3oVN3Nj9dMCBYuir3gAbrOu7I0o14pXf7tdI5xKPy0=;
        b=ctRj4uYqNkPmCMkfVFIXQLCzX8uxkiQr/ncIqi3Ne/UDVhpsTEBVmuOTU6oAIG3JP+
         c6i+qgfcFCbwMVYRagFo3dPIJNuPB2fztA8QPN0n0XVecWeQdCbWmldMxdf39MpSs3jw
         qyn3uZAr5YX6yX+HcP6FmDxqHfaxJcHd0kQcT3z6DwFG3ixPwUXfdRm2G05uYcwizLgQ
         0U1YJPQGUoPt06lCkFSPNJvZYHmVUvfcr+kRsLbD+5XvXxmf8k45ABKp0+S3jRvCkF9r
         7XS5fcFXMTRg98TgkJZnVL/109FPLz6fbxTH6PBvfAhp0mN/pft/Y4KqqhMnQyPGqh+Q
         YvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=Z3oVN3Nj9dMCBYuir3gAbrOu7I0o14pXf7tdI5xKPy0=;
        b=jI/1xP2HW/9ekNNEcccwfKZSl3HGJHK9mWpJf/Bi12zcZiU59ctvZ8rtpRCX0RG926
         +bEYElaS8JyBvOx4u6lTcIUmRENxDNvljUUac5QpkiwCyMdDVnkS32ZzCHT85aqDQmXC
         ATLNlziSAD4cQ9eJGDdyVOUD2EXzGcNL+BMi3//qBgAQEwlr5bHCHm9nk0z5iL4W8GED
         Tz1CngEPe/hkk854yPkefN5ycBw+LSAyWmMfKNrXGyElsRfVRoZ1a6+6JkF+FL6zeUJu
         LqX9rJ5XDuXTomWNKY5vMGqLh4TKh32hIFy1Cw3cUFi8ZT/xZ8RNBDRzgPNMlrTi70JE
         Xw8Q==
X-Gm-Message-State: AOUpUlGBDQQoSv/ZrVd17NYTDiW8XvX5lbw6znCN07TMXrolo0qYicgk
        B/S4nwR7rVDJjkehyOlwangR+3R2
X-Google-Smtp-Source: AAOMgpcZmrT8pGxomx89JMu0kPFlTJY/BBSx1PBe8oUUbrT8qWx4wDUDdgHbi/SMDgwn0dUuPSJjRg==
X-Received: by 2002:a19:6902:: with SMTP id e2-v6mr3440117lfc.70.1532685574943;
        Fri, 27 Jul 2018 02:59:34 -0700 (PDT)
Received: from [10.95.176.192] (user-94-254-149-103.play-internet.pl. [94.254.149.103])
        by smtp.gmail.com with ESMTPSA id i15-v6sm483183lfb.94.2018.07.27.02.59.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 02:59:34 -0700 (PDT)
From:   =?utf-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Fri, 27 Jul 2018 11:59:33 +0200
Subject: Git clone and case sensitivity
Message-Id: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (15E302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Lately, I have been wondering why my test files in repo are modified after I=
 clone it. It turned out to be two files: boolStyle_t_f and boolStyle_T_F.
The system that pushed those files was case sensitive while my mac after Hig=
h Sierra update had APFS which is by default case-insensitive. I highly sugg=
est that git clone threw an exception when files are case sensitive and bein=
g cloned to a case insensitive system. This has caused problems with overrid=
ing files for test cases without any warning.

Thanks in advance.
Regards,
Pawel Paruzel=
