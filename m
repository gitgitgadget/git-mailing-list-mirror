Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C535201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbdDRTS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 15:18:29 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36595 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbdDRTS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 15:18:27 -0400
Received: by mail-wr0-f176.google.com with SMTP id c55so1507947wrc.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=40KDlBM/Tuh5iy9yEDDRFElR3aoovRm528d0YTvGeG0=;
        b=RcDIEMoerkMM6hY1nR7DkIRCO30l8cEH40z+B1ViIHheuZEj4MiRfz2ugjP88a7rqs
         bjuH/7XgLwwWtIRRlFECT7CEqOF4WqSZjkZKnQy6sFg/Nz1FZeL1Cgc0IK6XfjzYzU/J
         /9KErLebSd7GPyzhv6fmjpV0MYFHwUqeI+pkHoU9v9FasrQtJTgI7q1UhNX0/lbrWkI3
         lSTHpIxqoCfvf2k7QK7EwpFo9BPHvhGRfDJN7S9lT/Hn1CZF8J2UF82ZA7OoF9d+m/9F
         hStJVSDszq/bM0IWJKJAvCXt8kDORtUdD1vKescz5wVM3q5DEPOpT6tToRjC+TIk7kGH
         W/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:newsgroups:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40KDlBM/Tuh5iy9yEDDRFElR3aoovRm528d0YTvGeG0=;
        b=pBzBsk0McqxqiaChrX1guBDJmwWpG2VtWtIbSv5sjJdPAR3P9dR0o9RZxHK+txVQdw
         TA3//u7aUn6mkHmhSn4uVCMqfPqK9qmGgqkcfUfZer5SHJw7rbKXlx3kij45PvvPP7RZ
         tDEChxRdCFdn/3WgGH/H7cfHVX774NC0votzx8D1C0lhyuPU/ZFNUyfoMSlKLHZgoITj
         UPSdYKYJMNctodCbz/Mj/ROCziAHg+wei/RDeI9N0o9JapimDzwgFQlWmQs1tuSfMGq2
         kuwqnvl5bF99hXznKYgduerOWnH3hhwuyKE1QqArEo5zwqbqfs05gc2zHAk3AV62eHJY
         QlRw==
X-Gm-Message-State: AN3rC/4nXxYtE7Y3P1xSpqaubpD1dNbInPnjPF1N1Evw/frQFhmPRD7h
        mMtQDZB25RPPzS5Ic4E=
X-Received: by 10.223.171.182 with SMTP id s51mr11000040wrc.181.1492543105918;
        Tue, 18 Apr 2017 12:18:25 -0700 (PDT)
Received: from ?IPv6:2a02:8109:8dc0:a7c:51c2:849a:df9f:475e? ([2a02:8109:8dc0:a7c:51c2:849a:df9f:475e])
        by smtp.gmail.com with ESMTPSA id h199sm9534074wme.4.2017.04.18.12.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 12:18:25 -0700 (PDT)
Subject: Re: Fwd: Failed shallow submodule clone for fixed SHA1 falls back to
 checking out HEAD
To:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
References: <605bb444-8d8c-7fea-d3b8-6f8414636d87@gmail.com>
 <CAGZ79kazh5+6vx87PVXUNgyJebO2m6pEkT1G8rSFvCmWQZdSuw@mail.gmail.com>
 <CAGZ79kZy1rBUaF1XbUOPUxDPzT1FwCp92jbbiO4RX3aiCoNkxQ@mail.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Message-ID: <bf1bd6e4-e099-53b6-428a-85d1e02ee75c@gmail.com>
Date:   Tue, 18 Apr 2017 21:18:23 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZy1rBUaF1XbUOPUxDPzT1FwCp92jbbiO4RX3aiCoNkxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-18 21:12, Stefan Beller wrote:

>> Wouldn't it make more sense to unshallow the submodule clone in this case and checkout the configured commit 2aa4cce7d7fd46164030f2b4d244c4b89e77f722 afterwards?
> 
> If I remember correctly the conclusion of the discussion at the time
> was that people are more interested in "less data" rather than
> "correct data" because otherwise you would not have asked for shallow.

I do believe this is an awkward choice. What does it help to get less 
data if it's the wrong data?

-- 
Sebastian Schuberth
