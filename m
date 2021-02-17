Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB69BC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD2564E2E
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhBQThI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhBQThH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:37:07 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48B4C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:36:26 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id y199so16209149oia.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+n58ZG4I8SuKVaZd8WGHEfa7EqKJxaMkAfEpDEF6qho=;
        b=SO5+u9A8HAsz8aheowgwJAG2fHZqEQCjgMXG8umtWsbMozlAINqtDafrDiEKQz+WQn
         sv1jwbYhYA1aF76OHEi5FMcw8hUG+DtD0i/xhHtG2dU7cYg0ro6M+Od0v/jWEQQzFnGu
         5V+r67wbqsbCc/Ls6BGUCDf8nHPPveojTHBqJasgSSoH1z/3WMC5vrnMfiIUcEqepwtG
         UcxpIOUt+d8qd7f1bsTDZjSfxPaqzk3NE8B/G6veeQp5BX/3b5ZSNRXIGdl70/MlOZfE
         I9RL3tQbL34atG81kKO8/ga+27joyG+BspibtiGJqB8hvEAwsCCZ/nbg6t9mNA/5jEWJ
         1TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+n58ZG4I8SuKVaZd8WGHEfa7EqKJxaMkAfEpDEF6qho=;
        b=bpR2YSO8qMgtIS5YzWTxXsstYb0AkiVMfgi3Y/NLlgxpKp7NeVm8vpUyQgm2+CdxxZ
         pHtWCkTUfrZXxutif43aw//IQWCVu/UsrjqCA91ODDqbmIszZcZm77C84+Rp4JHhL8Ag
         4cEc9RF6I0YC1u0FQLeX0H54PkstTeMlY+7Y0lkkk2D+k7tWujpDYwW+pae3WmQpJK+h
         0mGM5dsNsckhNBqg09EGXKe1SVvYwfprH9ukJVXKS7NK5PhL8upN/U0JeOAG4ceDT/w5
         Key2qjYl2hA/I9J2zRUnLgjfd7WEIMMgAqTKv3CvhZAZYaGDmrl2Sdie4KkNm8OvBSrz
         Tr1Q==
X-Gm-Message-State: AOAM533t+0PmJ0N0ygKSlUfXVGzoZy/IZ9I45jCE7Yls0syq+/04NqvJ
        EbFMmiJHBy3pd6ut0b/L1dhL6SRwTBENclRF789zr1hUbk4SbA==
X-Google-Smtp-Source: ABdhPJyndEym7Ms+nxAl95vnBluxBR5VFslOGXMIXSAh8YOdvtHx5LxVzIGidpRwUH1xw8RVUC1AgbbMdwRtHdZQ3m8=
X-Received: by 2002:a05:6808:8c1:: with SMTP id k1mr303769oij.48.1613590586201;
 Wed, 17 Feb 2021 11:36:26 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 18 Feb 2021 01:06:15 +0530
Message-ID: <CAPSFM5eW6iMMyrsj3WV+z5L0oC_SSniKPQ9n8qCh6S9+X73_eg@mail.gmail.com>
Subject: [Outreachy] Project blog - 9
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Here is the next blog regarding updates on the project:
https://charvi-077.github.io/week10-progress/

Till now we have completed the implementation of the new feature of
"amend!" commit, it's patches are under review and started working on
the new feature of "drop!" commit to be used with interactive rebase.

I appreciate any suggestions or feedback.

Thanks and Regards,
Charvi
