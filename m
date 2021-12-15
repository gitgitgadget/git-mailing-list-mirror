Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9419C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 12:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhLOM5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 07:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhLOM5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 07:57:54 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E6EC061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 04:57:54 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id d17so1481689ils.8
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sumologic.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RkUxRGUHTDp00Au93OQUdSWj4lmfcfsZDwHEee2Pq3k=;
        b=i5delFxPsuqxFpPXH5D2kf7KjOub6XrtcUSPk2Zq2q8r5zMmBROb53Qbt1RG9Ijffr
         JAIH8yVeowsxgx0Tw/svMUPo/qJXw9OaIolXjirKKYiRlHt3Gn5bXo44nR26wVVdFXOj
         z1jcnNSOCBDiW6fOz62GYQK309kYfTMLGCniE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RkUxRGUHTDp00Au93OQUdSWj4lmfcfsZDwHEee2Pq3k=;
        b=JxXAomenlOSo+uVcdKb90nH7UNhtJyZsrHRorqkT8vM5ZWn+CD0GgI2h6p6NnzCid2
         DWBo9PvFu8YuydwwNS5b7cog6eZ863z5SZcfaKB1fSZh91N0PUTiKTF9CK/qFAUzbUes
         KiGF2j3uXDGV+X//K58FxsOVDxNuBunG1YV3n1zNzKr1QRTj/irJ6vBq6bPQL8QU/jJf
         WheHXtDpIAkxuQc6jpUZjj9f5fa2bZuRIz1/TaqzU43fBq26cU1OYCdDHaIMqxyBt91c
         l0J7yipykhjfXdfqsmODAAuqnpVcklNA5vEe+Q397O4vkIDqBAhdwajKo6aUZOZeIfAm
         WkGw==
X-Gm-Message-State: AOAM5326RTvRXiY6oGx4U17uU9uI3071r18GfLiQKcavLlX0FVZCgmPr
        b20KzURNBJOhADjFa3/9YgbLEWls+aaMK4+z8JamRf1LUrsf4Q==
X-Google-Smtp-Source: ABdhPJzSbTEpqBoUJdwpgyv0Oyn/Wtbg/Zfgi/xdCjBD6xoqiLKan//AZa7VSeZbeIgJ3eW1guRDz1eEBVoCBVLrGo0=
X-Received: by 2002:a92:c563:: with SMTP id b3mr6010773ilj.94.1639573073853;
 Wed, 15 Dec 2021 04:57:53 -0800 (PST)
MIME-Version: 1.0
From:   Ana Jovanovska <ajovanovska@sumologic.com>
Date:   Wed, 15 Dec 2021 13:57:42 +0100
Message-ID: <CA++hZeHEVN6JZMdtXMjG2bDqerJjrFjhjYOry_rnWDgjTbQ8aA@mail.gmail.com>
Subject: Git SCM API remote
To:     git@vger.kernel.org
Cc:     Enrico Benzoni <ebenzoni@sumologic.com>,
        Michele Zambelli <mzambelli@sumologic.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am developing the integration with Git SCM and I will need your help
on this matter.
This is API remote doc https://www.git-scm.com/docs/api-remote . Can I
have more information on how to use it, do I need some additional
library?

Thank you in advance.

Kind regards,

-- 
Ana Jovanovska

Software Engineer, Engineering

M (389) 75 300-828
