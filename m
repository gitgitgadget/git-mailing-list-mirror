Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A33F1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 12:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbfIPMuW (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 08:50:22 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:39323 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfIPMuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 08:50:22 -0400
Received: by mail-wm1-f43.google.com with SMTP id v17so9688161wml.4
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=9Vm48RrKrckK1KgyZ0KdJtGi/xr1xyI33OTM5uOWyfo=;
        b=Ufo0zDFKmRvBwS5m9UPla3KpGkJDj5ZlgXMMt3Fc16Jj9kq8qx20ikSgYZAaZDU/Qp
         KALCsdHU4vCLCvaaEes0OowdPfpJh70ychPZeiGgIMtMor5mBE9O7D6Sy82q5k+ATEGo
         CnVCZRzOmAHdO5BakpECsGtpsnogUJlRALnBZ7g76VcSoMqgmoIJvT/yXDJL031qlyk4
         F3JQEUAoI/Gu1PEq3WcRgY9n9ewDbaKBN9S0Z00EbYLVgJ4/GV87W71raqkqEmAYEDyh
         39bCn6yZCJq7ZF/loW9xw/skCM7ntbsWIOYXfShifdt3kObd9FD1Mavg519dsYhNm/SS
         yeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=9Vm48RrKrckK1KgyZ0KdJtGi/xr1xyI33OTM5uOWyfo=;
        b=duLSXp6ZVC2M5t8TXN79w6kZ0oP+79rfVBOx7laMtceTAAY6pyqTIScXodAqKxnIqb
         gBdkpX3irvyBNGx4XZLnkSYnb2/RgqXogNlxOOtJYsHS5VZnNhOG24LIRlSpEBlmMV+I
         uQQAq1hR4JSK/G/edY3eyKxRJtj+r/1mdU9NJLa6sCfmVTCEzMmI43zL5A+PbYvXotoT
         xetFKjbb4v4loRhb95OCvHwf/4+Tpmuumyf1KMfRE9YeKt1gVBYwgMvdqVMPG+v4yd/2
         bSZy8M8pZ4LebUuRA2j2khycY4RyZvgaiaoeJiVq188V7PkSuRQZocidUAM4vxKsbuaT
         tUvA==
X-Gm-Message-State: APjAAAXpGUkXDo/D9YTcXGcOd/qbBEWcl4eRBULr3yf2D16vbDoB3c2t
        kbLahgO1FgW3Px4b1BCKTROICECxOz4=
X-Google-Smtp-Source: APXvYqxFV4Lw/FqwXYuzZExFizfvJtC9cvVSfHbeMgPvBhYfhIf2sq3DpFBP35zl+2XSk4P5EybuRA==
X-Received: by 2002:a1c:4945:: with SMTP id w66mr8443600wma.40.1568638220146;
        Mon, 16 Sep 2019 05:50:20 -0700 (PDT)
Received: from [10.10.11.24] ([85.132.78.78])
        by smtp.gmail.com with ESMTPSA id c10sm49218707wrf.58.2019.09.16.05.50.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 05:50:19 -0700 (PDT)
To:     git@vger.kernel.org
From:   Alicenab <alibutlow@gmail.com>
Subject: Git documentation in Azerbaijan language
Message-ID: <20a404f4-929e-fb87-4ae5-b0e8707b15c7@gmail.com>
Date:   Mon, 16 Sep 2019 16:50:17 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
As far as I know Git documentation does not have Azerbaijan language 
translation. I have started to work around it. Are you open for this 
commitment?

Best regards
Ali
