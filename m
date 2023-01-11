Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A4C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 15:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjAKP3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjAKP2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 10:28:40 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4CFE3
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 07:28:38 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v3so10772707pgh.4
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ulxq/cuLHYd8WQsgNadxWRQYH4Pb4L6yQXCst+jOEUk=;
        b=O2jwXhNQ0p3tHWoFmckjzZLcss6rpHoS9zplI7jaMxP6Tr2vJ0P3dLWNW5iwVsffKL
         HcTdEd8IUU7wMyQ1mn5/JqWRdgUdQm+NOpwVaCBcsXMv1GKVle7BVwOFeE+dAIB8IWgc
         xVZTaskMh4L0ByG9H/xFvQ9/5AlVxaE0OTID0qGrHd6Bj/oe+BlDG7eSyN5eRZ0p13zw
         vFQY8q8v7EDU5rBw+yh0kKry877UsP2ehA7lZAqngwYt2Ae7Ki3329C0BZJkfPvORhOh
         L5ySkn09IU7zmTr6MOHmrodfBZ94xDV3iuRKE3SmTDM77tdCPPJ8at/deuEA3Alg63O5
         nFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ulxq/cuLHYd8WQsgNadxWRQYH4Pb4L6yQXCst+jOEUk=;
        b=PLLoDk7BEBsZq80h5PxIl/3NRGEvypLfvIARGFZouto8XVgJJdHB0k9jkrs8EkcRQ1
         G4EAoCnJ7YBupqOwm3jb0h6Y2TRbT96mnkIKm/M0zilwrnUkA9RMhZptmOCxDPof3uOr
         j65TeAuThCtqdqQAygPTQiQ1yMTBXp6FD1KElSGj6Hah3SGJdLql6/O+VIhXxZi2G7Fh
         iJ8FFpId9fDz6HR/CDtX6RTygYtmWKBEaiVGHA/IYrUr+UqbaGqtIPp692v2LI+Ix0ci
         CQkilHQrOMiP/xCD59wgc5plfCy6ynR4IVwZwkJLCPKDjsDoeeep8D1/BR5tgJ2Izo7+
         aU9w==
X-Gm-Message-State: AFqh2kqiUaONwKoS2d6ayu76EDxKf8ez5ViXVhaLV2yaDA6OumyHCkQv
        jGgES/orCJYanDVDn/sJxowHrusUSbg8C0JJFbBZhGGa6iw=
X-Google-Smtp-Source: AMrXdXtiKiKwmDTaIi3iaegan+50Aplt7Q2zINHGZ2UyPzKy2godOJluTZLEUkFnuU4byi3xSzf3kNMpaEfMlfK5BSY=
X-Received: by 2002:a62:6d47:0:b0:581:1417:6ce6 with SMTP id
 i68-20020a626d47000000b0058114176ce6mr4242084pfc.58.1673450917662; Wed, 11
 Jan 2023 07:28:37 -0800 (PST)
MIME-Version: 1.0
From:   Bhavya Agrawal <bhavyaagrawal1210@gmail.com>
Date:   Wed, 11 Jan 2023 20:58:26 +0530
Message-ID: <CABg0hzHzsfP4BsCkwDpAEcYhjUe0w3hiZSx6YW7LBJSBerg86w@mail.gmail.com>
Subject: Unify ref-filter formats with other pretty formats
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am writing this mail regarding your patch proposal of "Unify
ref-filter formats with other pretty formats" on
https://git.github.io/SoC-2022-Ideas/

Has the patch is already resolved or working on? If not so, I am
extensively interested in contributing to this issue.

Sincerely,
Bhavya Agrawal
My Github Account :- https://github.com/Bhavya-official
