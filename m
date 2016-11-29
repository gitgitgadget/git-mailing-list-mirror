Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645351FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 10:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755000AbcK2KOL (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 05:14:11 -0500
Received: from mail-wj0-f180.google.com ([209.85.210.180]:35506 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756888AbcK2KOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 05:14:03 -0500
Received: by mail-wj0-f180.google.com with SMTP id v7so140480557wjy.2
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 02:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marvelapp-com.20150623.gappssmtp.com; s=20150623;
        h=from:reply-to:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=RTQ8hQkEmLaPhKZspleavQpgj2CsDV+HeXbJrfAHC+w=;
        b=BqxIn4cT8XA+boyNgbQUo9Yk0Ntik4eA7c12RvwKWDdRfR+a6Wfpivh3NnI0L0QIQ2
         t8YlrzUKIXw1mrgnY2g5SNuDuu8nQqpUU/fQKylBjc9Op1R5nwxBX17szSd2dNt1ESu9
         R9BPZXaWUOYkHt1hCPaYeKaHW7xWItX5Y8gStz+vAntejslOhv9CSc5AWJuZnGoIl8H2
         uarwPBS06metLoigXUa0he0dWkiCWSif6Sr5AvAtGUWDpws7OA+r9rT4LkwxmePtWhER
         iXW0fgWd0vKoSheIv/H+637n3mPLdYYMRuYEYpAqyXKs8RxiBeIOKUkDOfIPlHfNXaOB
         rfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:reply-to:to:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=RTQ8hQkEmLaPhKZspleavQpgj2CsDV+HeXbJrfAHC+w=;
        b=F7OJJWoVgJL6l4iOZ1VhnVNbTd2sZ2HJKjpLxuTLe5pIASoCj6c7b6RgPSwZASxs1h
         n298L1x1VX/NUJJJ19oNwihh0dKOG2PAVpdDZRAKkDNLNGBnSE7VQLeIL/eM0eEDbw3p
         bpiZiwa/fh8itOW6eidjoSrBsH3EUWSHgcNd3tppi6H4YHCqhS8FPIXeNY15FqZ9IYRw
         M40bZ2qBULrH1DF+IBAFyea+SJVDguW83Voj7Vh6i3xCXvvUblXMj9T2Wt2XzZBWvTt1
         HOqSu1nW+QDeTJRjMrOaiCVUr4FiLFwJ5oQzXcv0PALb6e/MpA+mpSrAiLelRE0NLdCo
         r3Lg==
X-Gm-Message-State: AKaTC00QLRr2bzPVzJhhTEeZxNt438e1lqrNXmP6XB8uzHxLgDOA/kzfSowghu4McyA+VS+9
X-Received: by 10.194.223.70 with SMTP id qs6mr6276995wjc.124.1480414423709;
        Tue, 29 Nov 2016 02:13:43 -0800 (PST)
Received: from Peters-MBP-2.fritz.box (164.1.208.46.dyn.plus.net. [46.208.1.164])
        by smtp.gmail.com with ESMTPSA id x188sm1989114wmx.4.2016.11.29.02.13.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 02:13:42 -0800 (PST)
From:   Peter Flood <peter.flood@marvelapp.com>
X-Google-Original-From: Peter Flood <peter@marvelapp.com>
Reply-To: peter@marvelapp.com
To:     git@vger.kernel.org
Subject: git-gui paste not working
Message-ID: <43d6119c-b815-efc7-70c0-0a3158178b70@marvelapp.com>
Date:   Tue, 29 Nov 2016 10:13:41 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've just upgraded to macOS 10.12.1 and now I can't paste into git-gui 
(the commit message box).

It seems to work if the text is copied from within git-gui but not from 
outside. I've tried using the latest dmg from 
https://git-scm.com/download/mac (2.10.1) but it doesn't fix the problem.

