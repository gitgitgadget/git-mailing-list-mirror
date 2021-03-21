Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB2CC433E1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224CD61956
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCUCvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 22:51:20 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41576 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUCus (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 22:50:48 -0400
Received: by mail-lj1-f180.google.com with SMTP id f26so16742431ljp.8
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 19:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7RYqRcB0mfVt/w/+2xJZ2n6p3tMbE9QCsHZqJA1boHo=;
        b=BzcU9XQk9ejKL9xALD5CK3CWhrbyjbmLKwT1zoUWkV7iFfDA1VCPxXhwYMCFqmoIaD
         nBcf3ePFY/FfZB0TIySpT8LQqNKnxOcCBXydcYX1fs82506sia+zo1/63awcI1q+0iPa
         oaI8vmzO/kcD+W9PWkedsojCdOCJtj7Sc26PqqK27/TDM/aAm7lmAu+uZWg0o/FYPQmQ
         b/3uPKCkPNXgphOhXYGXUsuMfOJlsjNrqoPIQfIy8Ceh9hbZN1X65GufUJjg1s5dizZP
         1WKQZ0dfqwCMKa25IgTum0dohbU9Vr5UZ0W0nNKuEOn0Ht7/jiIqiaqtlULS6oM2KYc0
         13/w==
X-Gm-Message-State: AOAM532FNwblCZbN1eiHYGu9NRu7bedaoDenRd7oMpyDF07M5Jhmgqg/
        KgQuBrCQny8w/2V5aCJblig+NQlhcqIfeahPAo3+xy5mUQcmhQ==
X-Google-Smtp-Source: ABdhPJwZWIjffd5ffaXkFOyxPoIBCRUjtOcakpK5vGzNPB5RLcx8vo3TNLQSZQI6oU+Cc6EabTfzyOzGIKDFVGrDItA=
X-Received: by 2002:a2e:9a98:: with SMTP id p24mr5490016lji.265.1616295047164;
 Sat, 20 Mar 2021 19:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJnXXojdM5dyergCqhq2FR3Sf8fxQHzfenWgFfZR8KAZFE9TAA@mail.gmail.com>
In-Reply-To: <CAJnXXojdM5dyergCqhq2FR3Sf8fxQHzfenWgFfZR8KAZFE9TAA@mail.gmail.com>
From:   John Yates <john@yates-sheets.org>
Date:   Sat, 20 Mar 2021 22:50:36 -0400
Message-ID: <CAJnXXohF+sBs2Kjf8HeC9KKWiJ_g+Jg+C6hTRpX2LQvENeunEg@mail.gmail.com>
Subject: Git Tools Reset Demystified
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified

I found mapping between the first image and those in the
remainder of the article disorienting.  I suggest adjusting
the first image so that it, just like all the rest of the images,
shows, left to right, head, index and working directory.

/john
--
John Yates
505 Tremont St, #803
Boston, MA 02116
