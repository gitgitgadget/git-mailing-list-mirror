Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C1EC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 01:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbiC1BtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 21:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiC1BtG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 21:49:06 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86704FC58
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 18:47:27 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k25so15372692iok.8
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 18:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=245l6+pCwNen9/D+Ny95Gbh5fZsjBnYpXepiNwwlf64=;
        b=RI8kKvXJeo4mE2GGC5HPeuX9yMB+l+fKptwj6FLmb0Ue2lq7+aqfqwElyhx1Jd4DOx
         mv78s1vUIvX2Zf8KPf0AgtDND3kg3/v2+CUOHYCdMh7+RXgvwg3sevLE9gEjwzn2DaD3
         BVJICKbkZwFCpjz/sxYNgess3DUXgdkhph4qPo0doqzNugoZk4nB2kumjYuhNcPMk2qT
         om6a1ikMAllKBDFoAabLiFDU3Cjg8lUBs23857lRY/TWfU8Xqv1FFx8xbwx5/tiF22w5
         giA9cmxxYvFuR5Ij7AtojjkI8HGa64z9OWvyqNHvqtP9gXHoyTp0vZd7ZV4RaCBB5u/R
         hAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=245l6+pCwNen9/D+Ny95Gbh5fZsjBnYpXepiNwwlf64=;
        b=LLoWwMbrePw5Zl/2nk7QAGWS4k58TqaxNXO60HLyoFTbjm721fMIeOwDd8vWrc6Z8u
         85RJ9pYdpI4+LxBWxlMyc7Nn22c37/y0/O0wevj1G+WeAagUYRsusSTa1fM/YMOaVmDl
         bwIrVbS1ZwBt84RZYVbRVYg29IHvmPnOu2a1vq3k45KRpitoJJnV3DgGMhkrsIeot4+C
         8Brk3ao89hDb8nskrguwCh+kwpYmHszEDpZO/b5925CABvVEKLI1YXEINmHOPf2K7vK1
         ZNFyWwAPQhrZIlyZyKB6no+GhZj/Rvz/QZSvSPog9pyWBkW8v7Q7RT/UnkvAiXmVBZyG
         ZWYQ==
X-Gm-Message-State: AOAM530YEpxmrYVjypcYmXhx15WtEZ0GciaOeVjlSJPasPbttqgkJYif
        XTtWlqpVa5UdexCq7zITl2mfVkz8UiBGUyojMk/EuQnv
X-Google-Smtp-Source: ABdhPJwVlFtRAb9p/+oMq6Ql66v0hcMLALUGAv2qMFlaelVWo6V5o4qGVaoZjxUamhf9o5q3FLrBt825vyzYQpWNeNI=
X-Received: by 2002:a6b:400b:0:b0:64c:77aa:40a6 with SMTP id
 k11-20020a6b400b000000b0064c77aa40a6mr1468810ioa.101.1648432046967; Sun, 27
 Mar 2022 18:47:26 -0700 (PDT)
MIME-Version: 1.0
From:   Labnan Khalid Masum <khalid.masum.92@gmail.com>
Date:   Mon, 28 Mar 2022 07:47:16 +0600
Message-ID: <CAABMjtFTy++Rvty+4TVXeEegEMhJ6c0_jW06x=G-pLh8fLPf9Q@mail.gmail.com>
Subject: [GSoC] Applicant Introduction and Microproject Selection
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Everyone,

I am Khalid Masum Labnan, An undergraduate at Islamic University of
Technology, Bangladesh, Currently majoring in Software Engineering. I
would like to get involved in Git development as I want to be part of
this community and would like to use GSoC as the starting point.

I would like to submit a patch on the microproject "Use test_path_is_*
functions in test scripts", by changing test t3501, if it is
available.

Regards,
Labnan
