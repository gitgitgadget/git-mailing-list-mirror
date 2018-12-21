Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90B61F405
	for <e@80x24.org>; Fri, 21 Dec 2018 14:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403895AbeLUO4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 09:56:41 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:36962 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbeLUO4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 09:56:41 -0500
Received: by mail-oi1-f181.google.com with SMTP id y23so4981851oia.4
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 06:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=takehiko-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=uQR+H6N+KcxbeTGhG/Fe/bKgdvi8mrQIDubdSyhArZg=;
        b=pX+bV678w22mQx9G8YGVCQXCkUxh9wmfURgdB8uvsH/LLCiIkKc61lsp9MAdxAl05G
         0noR7KuUpcMl/xmDsu71YtZ7HOVHB/HDDq97dYi8DL09tEN8hgbviVK8+15iZO2aOhIi
         oX4RxaA5ZwnKTfAh4FDhJsnkeB/padVplGPPQ5TwbsLlcypnOMiqDIvqm2ZVKm6jlvkU
         KIbh+jUNJ+AOJD2FlW+njgyGKuCM9ZcbsCKoPgPGAulq7Ij1goJ2mwRchXryRlHrEN+N
         KzLgL/gBf6muHb2QVDXQb3FzulqRliK14Zo5I3BeLgci59R3sqWx6kUAuJ1XJni+gXA6
         9bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uQR+H6N+KcxbeTGhG/Fe/bKgdvi8mrQIDubdSyhArZg=;
        b=iONTkapF37AF3fUEYZsMPnvLgMOIYeXyH+JKz6fAvHL76T5VUeB+bg071WrdlDhk6Y
         la1bUEvgovQ878YmN2fXgnRhfx38FTYsm6z6gvX1I77YL4LlaHfkeVOPYahFiUzakKmN
         lcmit3SsQcmQUJtWzQ5F04aRq9x5pQfQD+q2Hj9GXPwjWw8SJ6M0unhHHbXP9I/GT4a1
         NpRItpVaDdPcPHTJ7U7P2caOu/0xe2Fblze+boeJnh19ZnHzw0zyb9HA8ckciOoXntdf
         JniClW3hlgmQLQhi9Ey4zZQg36mJdJZSD6gUXS1vqFMIUz1o+Jw2Q/n/ecu8doPYCeoB
         BKHg==
X-Gm-Message-State: AJcUukfO3ypV2byc8qGqVqmuylAYSyIz9nENvsVu2k80ohoTOECvVn3T
        lgJ4HOgOXpJ90sRBbsKvKIOo2mmXshTEdzMnivbzIrDOaBY=
X-Google-Smtp-Source: AFSGD/XxOXA6z8lIx3cPsLgdArMSGmcHP+9EkYATZiFwusM87f5NqXBV3VeOXEXu8rpEP3VUMfhG2prrWPJl7ynEPRc=
X-Received: by 2002:aca:1309:: with SMTP id e9mr1650109oii.60.1545404200712;
 Fri, 21 Dec 2018 06:56:40 -0800 (PST)
MIME-Version: 1.0
From:   Brian Johnson <brian.johnson@takehiko.net>
Date:   Fri, 21 Dec 2018 08:56:30 -0600
Message-ID: <CAArbzTBWk2WhEeuqCzUuXC1FAnF1i3ZyM_RsJRDP0Pm0+mHa3A@mail.gmail.com>
Subject: Show-branch without commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it possible (or could a flag be added) to have show-branch only
show the branch hierarchy at the top and not print out the commit
list?

--Brian
