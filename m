Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC5C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiAMN2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAMN2n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:28:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36643C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:28:42 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x7so19441115lfu.8
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Y3roTKKpgIz1lePAdPiXE5Y6tl83pG9Bu1Fn2SIG8xc=;
        b=iZpQ4thxUNsj2HJdv3pOCc9eQP6lfeWYN845YyASJjcPMQWNTKnOoROE0J+oSTJmV7
         icTHh51n/jPFjtgRncAEiaE+S5g63D5YXbpgFgTrlA0UQn9z30Rsg2098PkfGTL4W8vX
         J+bQg/pq3cu0jIpU59WKI3JLt8wYDTevtLFvtukEOnpVsvpDkw5TX0g8RsTBLPYOnvC9
         r1tynPptZSQ/orrvtHic0+2MAonWt1syvizlcECZI+ZQ4x9VRN189Rg7p8XOaZPG+kPX
         dKbBjIyv0BLCjM+gmvEAU0y2kQaiNth3EIvnrr7EBymCQhn8zgusAMPYy4GeO4g81A1N
         wKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Y3roTKKpgIz1lePAdPiXE5Y6tl83pG9Bu1Fn2SIG8xc=;
        b=DY6gdsodHyw9fwDTM9p7cS2/WvSSAsiFNEBfE9fz1mkljzj/RxfPoDDtb/Al8P8lyw
         uIvZn7aThlci3hHCJE9W2U86hk3AXiFPxSzv83fVlsfvELplKxj3E3BrhHlKK8pU7Elr
         21aUjNUPHd9BOCo4DPfbhRHc1ovBkwVc4MZv2eQUOcXrFTiQS/u4w8NYpX20/o3DXsDM
         G+hBQ/MgpJ3rIM4RD4TcHF/de2Abh5O9vClj0FMvT/xWUzWwuyyV+qE40BZYcd2e2w8j
         NAE5+CQX+qJfQ6cmZnJocYuTDobwOE4UEMBolVjLorxU4IJi80qV6T4QpdZiuj5r0qsM
         CYGw==
X-Gm-Message-State: AOAM533PgfXa6fj5/brHzpiVWQoDb6Z2HiMfgP0MqlJHDcwYVZwnipR+
        kUFJzOqLaALjXdpyycYgK52cExlNe4RqYb+3GFljt2KKstU=
X-Google-Smtp-Source: ABdhPJwUn+f1h5m5M/+mVOSgEAl+usTV1ID7MvsrW+syNZCFHBQLNI7c8J+9KyJO+ikcl1nYJBpuRrxRteXKXBNo0F4=
X-Received: by 2002:a05:6512:a82:: with SMTP id m2mr3291939lfu.306.1642080520433;
 Thu, 13 Jan 2022 05:28:40 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 13 Jan 2022 08:28:29 -0500
Message-ID: <CAH8yC8mvtXk7B_+43xZJY6Fs6pXkq3XhZ=CH_SRjOUL728ZQ_g@mail.gmail.com>
Subject: Git 2.34.1 on Fedora 1 and Ubuntu 4
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I was able to update to Git 2.34.1 on Fedora 1 and Ubuntu 4.

There were some minor hiccups, but Git is still building and working
as expected.

Jeff
