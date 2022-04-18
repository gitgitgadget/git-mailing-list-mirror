Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F3DC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 18:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiDRSJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiDRSJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 14:09:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E6366BB
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:06:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso7787581pjj.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oeztuu9OWZ1/b9CYkfHAcVvddBI9Lj950E5Br9VIrkk=;
        b=MwgHGhg+6ZDJPEc804IztNkBZFO6UYVW0LyRSNWS6msJQG8sTFZECYrleoKKL6Gwiw
         B8opEqHX2TYrKSMXerfB1yw8s7dvPbY/TWVe9A8ItL4DiwJI0bvLKXKJEWHeS5Jqu95r
         seIVmLfbNZPhVCAIWpH1H2K4gKhZ9mKF4r7iSmwuDHqVnhNl/2hT64NWHhZ4kvQ+y82I
         qbd7IcZ83wOc02+qgc1RlGQ+bpvoNuJbDe4P6kyjkX9gSi1qmPSJhF06vD9gN04DIT/N
         jNLvqAYONLQ2OFTXD81JBEn7t4EQBRjFGDuCNVn0uB4OxKXevYf6ZaYQcV342IAPVnZ1
         Rytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oeztuu9OWZ1/b9CYkfHAcVvddBI9Lj950E5Br9VIrkk=;
        b=vQTAb25c3oHPkho0qGjI0lpFopcSqT7Jm69hJMaUKRWGmB3fZmocBAfnUCxXguO2QZ
         LlbtDzpyh5oB5c+xRRL2/oZexjylfCf9GCUPH4vbYXKEuGNZj4jtM1itnNnzUY85yRob
         OiS4VLuqrD6Yt0vodsqV0ivQldPVske3T1sw0+YvmZNoW0EJrca7l4hezLAOqPg+2Vs4
         CoTrp8BIJVE/tYFubVxkF1CsOsdzw9fExCcoHoYcP5yxNpSfoIYoCyMww4egX6Q//6C4
         wTNCj5l5U0SVkZ85yKBLDr9PpmxN/AVGcnnuvi9cZ/2FJjN2RCP8gExXGIi38Ymghz7I
         6XGQ==
X-Gm-Message-State: AOAM530NdLPogEzKMSVe0nyWWOaa2omhOYwnlfdF9nxMTXDB89RdNAfZ
        7sL3W2Rt65qxa6O04cfsNgT4haCtuok=
X-Google-Smtp-Source: ABdhPJyU0Nt5aQ3s8Mw63RhP69SJP3RtCsvUx1zNJyu64cLM0INYf/JdDET9Wef945Lp9q29zY9vJw==
X-Received: by 2002:a17:90a:4e04:b0:1cb:a26f:70c2 with SMTP id n4-20020a17090a4e0400b001cba26f70c2mr14529363pjh.130.1650305197905;
        Mon, 18 Apr 2022 11:06:37 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.150])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b004f7134a70cdsm13003909pfi.61.2022.04.18.11.06.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Apr 2022 11:06:37 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [GSoC] Contributor candidate introduction
Date:   Mon, 18 Apr 2022 23:36:16 +0530
Message-Id: <20220418180616.14954-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
References: <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:

> Just a heads up that the proposal deadline (19Apr2022 18:00 UTC) is
> approaching shortly. I noticed that Abhradeep has submitted his proposal
> so far. Others, do make sure you submit your proposals in the GSoC
> website before the deadline. Only then can we consider your proposals
> for GSoC [ref].

That is the initial version of my proposal. I will submit the final
version soon.

Thanks :)
