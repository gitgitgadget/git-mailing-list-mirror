Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F05C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 15:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjDXPM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjDXPMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 11:12:17 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69B2722
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:11:41 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7756904cbabso3170303241.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google; t=1682349100; x=1684941100;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8knKcyCtXRmYa+1hS292spl2mFIHRkmOzEXRox8OGqc=;
        b=hGi4PE76/JDKmGjvrBusWYe22ibXUTZDRoKydWyC+peOlxO+W/G9srnucvCYn2eOX4
         Yh4XrljAA1Shx9EWI44aaRmZ3CBWQ8UgmnEXL65XeBrl8LLFuJxxsYD7GXw2sWiR5FCP
         vrgR99ZVGDoxbgwfnGUQ7LpYZww4ICLjG4ayI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349100; x=1684941100;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8knKcyCtXRmYa+1hS292spl2mFIHRkmOzEXRox8OGqc=;
        b=HLuU5h9qtb+lr1GpY+Kt9DvyLyrW2IRH+yc0hPMkKy8Yn7ghGg2/p9NKTWnlgiRBWv
         PAP5eOQzrI4lDbukq57+PX8+85ZFR+YsK3Wm6T4ZE2+rktKZCWv7GR1GiP0I1f5qjmGt
         zCQWEScdfAhOtmwY94+HOTRynZLuAn2nRbZtPuzO5gK3Os0/UWHK/TA0nS0DULi22Him
         jn6OV7GiU8F61Yj4Y4zq7meK4K1Hc5Oagb09JWwT32Kb0hAWCiG9qEKOpS9jFYpief0W
         FkgQdRlJ//KXgNdN7JS7AEF8TW3MdN3B8KG5mGThGa6RdM4yZnrq5SeW9zejumGdLODz
         kvsA==
X-Gm-Message-State: AAQBX9eQZP+Nh6HOCQrwfFZVTa02OtlXy87L8745aMYjgGN2zj+6WfvN
        5iBEnPgTYlEHc/o8RiOCVarRGfoZaPpe25algSENNAH4CzolDpyDOFc=
X-Google-Smtp-Source: AKy350Z46VXK7wJafs2ZUZVkP3nUffDeAmi4aCUxwRoYs2uDfKyG+sVfaCpJuzfu+lXz3TpG8wpzwLc/hqJstEeERv0=
X-Received: by 2002:a1f:3d86:0:b0:440:39a5:6c6b with SMTP id
 k128-20020a1f3d86000000b0044039a56c6bmr4138212vka.8.1682349099971; Mon, 24
 Apr 2023 08:11:39 -0700 (PDT)
MIME-Version: 1.0
From:   Xavier Roche <xavier.roche@algolia.com>
Date:   Mon, 24 Apr 2023 17:11:29 +0200
Message-ID: <CAE9vp3+_PB0_rA81eWVCF=iXnWjrUVY=1G3=1JPUbcaw2u95Rg@mail.gmail.com>
Subject: Reference the master/main branch with @{m}
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With git, you can reference the upstream branch with the @{upstream}
or @{u} shorthand
(https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches)

With master/main branch varying among repositories, it would be handy
to have a "main/master" reference, such as @{main} or @{m}

Would that make sense?

-- 
Xavier Roche -
xavier.roche@algolia.com
