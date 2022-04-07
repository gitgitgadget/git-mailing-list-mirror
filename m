Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB8CC433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 09:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbiDGJ2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbiDGJ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 05:28:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D662E002
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 02:26:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y10so4920950pfa.7
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjlJi54BMHH82Ynj+H4wy3lx84iYoXSxLBNP2w4Wh3I=;
        b=XMDYFemQSKeDrefzQuktriUC9MFaRZYpvHQHXRtBqvVJ7jFmOO6MRgNh0hExaOVy5R
         nZuvezCNYTYzpk+fL0LOhV4UClqBUs5wwmqss6GOpa4Ukmp62NlvOQBmdiYojatqUyX3
         w7b1ChNDDhkeOQMijgEKc4EvADyFpAiq2fQakxQyLXJ7iRSfcUeaceUKvppSsXA97B5B
         sNMnZ7gZSPUK/l/5gHosHRCcdYekxubcMMl70sfnH7UaNRQhys/pGoiXbAwKBXMWKqun
         m5WkiN3fmDuC+SXddw4///DW+00hbXVWH5gq4lpTJbDkVTVYnoHzhGj6mXhMamAPs0sz
         SU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjlJi54BMHH82Ynj+H4wy3lx84iYoXSxLBNP2w4Wh3I=;
        b=tEf9IaHLTdBnFYzGc7wlyh2gy8Pya7U9a9O2rEkHvWVc4Tpb6Qo8/yXE4ULsz1kPCy
         q6oywKHfCsElX41Vbc9DMxwHbPYUO2/IxlX8GZOFAFjFSHTirdI1fb1Cx3cROo/Wesix
         qcKBIPUNZkyd1bPHe+8FtH2l8lUhcFh9KQb0diH9o1ZnZYyNM6A/+G1jvtH2QTCX8fSL
         GtHpB7RK1NHnxTCWbGqtNDCwUacAcga50fTo4SjEji/+VCI77u6Gkj+CJnBpdcKOuKI/
         /X4vOnyMG/83I7DfdAJ/Ev1r+TG5jlnqHFhw463l3pwlH0FlvPg2vEU40eNxvhXWa/Bj
         Fqmw==
X-Gm-Message-State: AOAM531CZpAvYpMa5X71mUe8Jyv0kWJvFoR6ZNhG90OCAVl3wkJv0/TZ
        G5wlyduzhEMEUSNed3877Op/6HiKAsqwjg==
X-Google-Smtp-Source: ABdhPJzYKiGuJVulR5wKBOWlsEmaLnUn34Hp3eLVWXcGd7jWBPfRROWndGxC5Jp9I/oBKax07EV72Q==
X-Received: by 2002:a05:6a00:114e:b0:4c8:55f7:faad with SMTP id b14-20020a056a00114e00b004c855f7faadmr13503944pfm.86.1649323587769;
        Thu, 07 Apr 2022 02:26:27 -0700 (PDT)
Received: from localhost.localdomain ([47.11.31.17])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00194400b004fb358ffe84sm21927106pfk.104.2022.04.07.02.26.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Apr 2022 02:26:27 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, shivam828787@gmail.com,
        kaartic.sivaraam@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC] Contributor candidate introduction
Date:   Thu,  7 Apr 2022 14:55:07 +0530
Message-Id: <20220407092507.1450-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAP8UFD1x-JEX8MAmpabK4RbKgmVm1VQYNJdX3fP8Op5WMfUgVg@mail.gmail.com>
References: <CAP8UFD1x-JEX8MAmpabK4RbKgmVm1VQYNJdX3fP8Op5WMfUgVg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plato Kiorpelidis <kioplato@gmail.com>  wrote:

> I've gone through the mailing list and looked for other candidates that could
> also be interested in this project. Shubham Mishra is also interested.

Hello Plato, nice to meet you :) :)

I am also interested in it and has already submitted a proposal[1]
on it (For some network related issue, I mistakenly sent three mails
of the same proposal; please ignore the other two)

I saw Taylor is willing to split the project into sub parts. I have
no problem with it. I will change the proposal accordingly.

Thanks :)

[1] https://lore.kernel.org/git/20220406200440.27010-1-chakrabortyabhradeep79@gmail.com/T/#u

Thanks :)

