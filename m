Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B032AC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDC261183
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhKDQyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhKDQyY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 12:54:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9CC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 09:51:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j5so10546458lja.9
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ufyx0xBUPSENwy5/Of4gwNfxvunXF9Y+x6Zl3CSdQr0=;
        b=furSeDe8zYMbnuyTXwCal05b8qizk+Eyv6DeQ5Rc+ID4XaSmz7ndEIeHNDAMyH0Md9
         VSyB82FS7ldcFzyg1IeBciaXcjmMpT3JA65ZA3cNjrv9AbkEvROFnAxohCdEtZQhaJZr
         ZVhSYx9dZv3Yl37CJEEIzMAwlGTAQIknhikeA+Zu5zWEp20cyJi5L2+w/6UpqeTRA3xR
         kV9WW64co9vXlI2RS4pd+4B6hB3uzHSKYO7ENdqjpH2Ni9ykTyDikIBj9qMYfLWCVT2A
         IIbnTrro4U3jBMm+JURR4Y2anPnw9bAeu6cgZ2i/VTMHyfUbOg0RCrdJchbWnhim9YFi
         gw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ufyx0xBUPSENwy5/Of4gwNfxvunXF9Y+x6Zl3CSdQr0=;
        b=bY3e993vWXrV55AMmq5GCHKrx+8lsiecYroPmeWtc3TPXRziTN5lSFiOO8RZoMarzD
         AmaT4KxgosY932imuSP1lY9KNR0A4yvb+/IkPT0qup2Bbd5k98r0rv8Y7imkCuO2eHSE
         k6mGgZOS0SPTKCxK2WBIqsk+rheUL7sOSBbp+8nqG90I+pLHyOkmn3nuItXaib+rKmr0
         eFNpsL9E6sEX0v4GTGeVghYjXsHj7RDmsDTXiXpetS7JrdyWJHFk7hZtUhIXDRwYOeeC
         D5p8mSp2FdG1squMiz4EiJkldnkbpFrVYw4SxP4jIaKqRdv1ItySPJk7cP/aolnjW3jS
         KRbg==
X-Gm-Message-State: AOAM530LFLjO/3q3coqRwrQdrFA6/CI7BZYfdWLxrUDJpFDmEFol1uuU
        k4pn9JOqOCnMWMW+BtZ4dWxUzCCdtF034dxbcppWF+6cDgI=
X-Google-Smtp-Source: ABdhPJzvMFGHiNs9SAkJJYcRb3bH3f/Jy+57Sdwr57l/ZanP9ISX3u+jMV70sYDRd8q2+zEA5SYVM0fIctDuorjVMwI=
X-Received: by 2002:a2e:a4b5:: with SMTP id g21mr16092485ljm.530.1636044704159;
 Thu, 04 Nov 2021 09:51:44 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 4 Nov 2021 10:51:33 -0600
Message-ID: <CAMMLpeTdSf7w+0RR-OmYE69YtbQEGTPY_BvtFAg5Vjtg+SP_oQ@mail.gmail.com>
Subject: Spanish translation updates for Git 2.34
To:     =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

There are several pull requests waiting for you at
<https://github.com/ChrisADR/git-po/pulls>. Will you get to them
before the merge window for Git 2.34 closes?

-Alex
