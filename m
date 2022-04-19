Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0973FC433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 15:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347200AbiDSP6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiDSP6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 11:58:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867FA2315E
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 08:55:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a15so1081025pfv.11
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K1t0Ph41b/Thg/ZUaESU9GqNxdgSbTeIBM/HWbPc02o=;
        b=m8hzDTMZd7pSovsCSdJ61a4vtG8pJuUBkD1mFnhvzGdcZKa40HmqO2/nUF1u9u6OCp
         QTWbITm7AvC8exdK89bZm7mZA/YboZAdLvQRN+m0QpLHw1A8XyKp/cH8p1wxRPihpyDg
         A/+qZA9K9DoqBkkPOqwOTKBOPO53AS6dkyTvCaClwBpdtoYibcFhdbZJzT+7v17iqpGw
         voVP4XO9m19TDw30zuvnxDCZ0H/HcC1PINLlYMUs+Y8s9pHIoM9B524XfaHDcSGd99PB
         NMGWh6EzHqBCU0fNnlXOCrEk7147yUOUYg4NhiKbz5HklbhJfGcKPVWQpwMkxN9hAlEG
         4FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1t0Ph41b/Thg/ZUaESU9GqNxdgSbTeIBM/HWbPc02o=;
        b=0PwfyM+HxN6lWBbfT/jFDCioTqjkjtqy+avQiXlzgVYmhjnrW/bB1YcJfuCCzFGy8+
         UsJSA9edLLD2TBq0MUefoq1nc90UFOKdC87702RB6ATjNWyL7Jkjm32hqeSdEKQEMhRN
         XpHMQKPqgTKRmCZELdwN3oyGZlV+JqRZRUfWY3rgLBJYQ67X9dlmG73+QPRDE73UT9JX
         O+GiSw8lzrDuZAuBkRdznyKoMNwNY2J1pwtwIemZwLX7/yHGVpuBfeCyvDS31qOAkVYs
         Xab4L1VIbdmMqfh5iseu1ITKkCh34OGqq3V2V+VedIA77Uu255WmoqYuV7dTVmla3GEQ
         qexQ==
X-Gm-Message-State: AOAM533LyWOe/bzNv3uJtIg43g7Md2Nkxk+1wsGtrOtiRjlZwEXaZINY
        QNyvCsAIPENB0KXtuPkyNofEULNIpsQ=
X-Google-Smtp-Source: ABdhPJzru2Pzgs+Nxzx3BwsWM68wwwJVBzriqBys93JwlCDrxgADI33FF7pbCGJAWuMxwW/D38bWhg==
X-Received: by 2002:a05:6a00:1346:b0:50a:8fad:2b6d with SMTP id k6-20020a056a00134600b0050a8fad2b6dmr6380863pfu.79.1650383718856;
        Tue, 19 Apr 2022 08:55:18 -0700 (PDT)
Received: from localhost.localdomain ([202.142.96.3])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm18118194pfl.70.2022.04.19.08.55.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Apr 2022 08:55:18 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [GSoC] Contributor candidate introduction
Date:   Tue, 19 Apr 2022 21:24:57 +0530
Message-Id: <20220419155457.20985-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418180616.14954-1-chakrabortyabhradeep79@gmail.com>
References: <20220418180616.14954-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> wrote:

> That is the initial version of my proposal. I will submit the final
> version soon.

I have submitted the final version in the GSoC portal.

Thanks :)
