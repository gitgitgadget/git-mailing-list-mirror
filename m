Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14369C64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 11:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F81020825
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 11:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=informativeblogpro.com header.i=@informativeblogpro.com header.b="IWlCqIJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgK3Lx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 06:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3Lx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 06:53:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12411C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 03:53:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a3so24726374wmb.5
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 03:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=informativeblogpro.com; s=google;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=F/zZDRJG7W9mPsfRoRX4jCjzRhBUzIl4d9hdnj+qGn0=;
        b=IWlCqIJwCwc6CE2Eus33iqvCr0E8LV6oN6d3JJnZAtbykFr2vTp2r0ezzZFG2LPXnZ
         1lheiDEjtQUpnadCOg1F+B7d86AIjiKNE53Hr/JiFTEFGnxb/ozFV/wytNHwKZePDAB3
         9Cvk6MO0ytyNmnmMhqHomkRJaXmcGi09GEC50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=F/zZDRJG7W9mPsfRoRX4jCjzRhBUzIl4d9hdnj+qGn0=;
        b=NDAnoBHtB1n50uiWNNhi24JtFPcwKjdfSONpwWLZq1gD1ITabIQnNblJeBYiuF28Oz
         NSZmLNYN4rrCao4O1Wrmc7yEErvvPSk7OjsdOBo/vSAwpkF5FSv2fKCT1tXRgl3f7ldB
         ieVwEGNmKNIenoWtrsulity0woRg3pwbF9wPSmspCZiQoGsM6ARPo0LbcBbXcYMRxb+q
         +q8/MLqDO1F9EM9U2mkJfisTKcDRhZK5If+0xTqz++KQxjqY6QTM2vl0sWZjk1ALerHB
         Zle9kDOnsuSJnb+1847nXDjBKIrHOnmFh6DRqKrUbPmFeumF5PTcYv2Ix01c61f+3Bma
         KrSw==
X-Gm-Message-State: AOAM530ykJsKQHvD84UlI7o3ViDNsdwbl1Vyb2+9D/w1bvTmw7r9Xu+K
        lnGqMOPB+feK2hWefjdVaC1GyVJhTZRscQ==
X-Google-Smtp-Source: ABdhPJxgBD1Ey16uvHvLZRU02UIdtMlUCYZqb8TFZmsQDNpTHDnUIFly+OjroIGLoAEqR8mlvEjD4A==
X-Received: by 2002:a1c:56c4:: with SMTP id k187mr23135485wmb.92.1606737190414;
        Mon, 30 Nov 2020 03:53:10 -0800 (PST)
Received: from 202.163.123.149 ([202.163.123.149])
        by smtp.gmail.com with ESMTPSA id o83sm1654950wme.21.2020.11.30.03.53.09
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Nov 2020 03:53:09 -0800 (PST)
MIME-Version: 1.0
From:   "Maria" <maria@informativeblogpro.com>
Reply-To: maria@informativeblogpro.com
To:     git@vger.kernel.org
Subject: Sponsored Post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Mon, 30 Nov 2020 16:53:08 +0500
Message-ID: <12444388876216143322181@DESKTOP-6D13GTJ>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I hope this email finds you well.

I am sending this email to ask if you are interested in sponsored posts.

We are searching for relevant sites and blogs for our clients.

You will get 100% top notch content with 1 do follow link relevant to your =
site niche.

Please let me know how much do you charge per post=3F

We will pay you through Paypal or Payoneer gateway as soon our article is p=
ublished.

Looking forward to building long-term business opportunities with you.

Best Regards


Maria
