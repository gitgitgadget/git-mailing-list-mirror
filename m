Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89602C2D0DC
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5227B206E6
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 13:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0tlG7SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgAANCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 08:02:15 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:37484 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAANCP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 08:02:15 -0500
Received: by mail-qv1-f49.google.com with SMTP id f16so14136752qvi.4
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 05:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fah6hDTSOBlnhDFqINd6e7x1O9q+ZDuu0qiaGkHwexM=;
        b=q0tlG7SOrcp51ShIgizKFRJcEzHVeoGUIMM1PqPQFwuh7iHGLMhvkVFS6E776ymmnr
         ImMMycBvwVjLMM50ugrVyCmZN8WPMv4VqjXx0qVl9HouiwJ/HW34mm9/ujLy/S5BruEP
         whF+urvZrKc4pJIJwyDCZNE15IEXXPbw4LkiaoTJQKmFxk1vohk2WaEfEWQAC3TZ+Mcs
         VqCBPb5O42ZTmSx7tSdtv8KhNDQQJAjHnoeSKCJiFET61CIe7aCC1cm5/VT5qn2pPtVv
         xYLVgEiMejgWtg9TO8oTNPqnxd0ldW1/Od87Yc6A1S30zWjS3VYlqR/3roMejvBpZ14o
         uPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fah6hDTSOBlnhDFqINd6e7x1O9q+ZDuu0qiaGkHwexM=;
        b=I+AhMv0VD4TYSnsU0Oy6xpNJ7pit0AsbJID1H2GopvJpr8Yd+y8KnOIydMNGtCf8eD
         OqWLTvBEOcAFN+LYX93p/g1PdX+sKEP+KpFN2Ngh651iaiVkMloHeuTj4g9YL89GVkvt
         tAUQBHEnEhPJqJhiPkJuJ9JhFxTFW4uCaRW+9N+K5FsH9XOa45baPCbW7nzEucG5WgRx
         xtfOe9q8kuoJUJ28fnp1dU/fYDokfJcA+f2uEWd/cb3vFDRFyjqb+nqCzo5IV+rgzdkr
         nIOUwxO508/nxysSDmBuGv8Ot+ckYF5Bi3+8/EYsHysRRbRSX3v+q7j6/KdKShptpqoh
         XeeQ==
X-Gm-Message-State: APjAAAUcMQaOU0x+Zvy5R6S9sfA6EQlOtgeY6DjOqNBgoaGO0Il2VCtf
        zypKSsuZTvpBMlCSnSCS1zdw+EBLN5mXwLb5HpdYTpKg
X-Google-Smtp-Source: APXvYqyTheZ1qeAiG5UImpp6x504tsIbbzt+JR5tmNRbrVmBguOZHJV9BmsVEh8IpAlMFYyIuV1v61H8kyO0kdJu0v8=
X-Received: by 2002:a05:6214:4f2:: with SMTP id cl18mr60024880qvb.89.1577883734211;
 Wed, 01 Jan 2020 05:02:14 -0800 (PST)
MIME-Version: 1.0
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 1 Jan 2020 18:32:05 +0530
Message-ID: <CA+CkUQ-72jKTMUQuGvYg+o5bp3DoKxX5bFCUrWyGLf_tzVydsw@mail.gmail.com>
Subject: [GSOC] Introduction
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I'm Hariom Verma, a third-year Computer Science Engineering Student.
I'm using Git for almost 2 years and want to contribute to the same. I had
gone through the solid part of 'SubmittingPatches' and 'Historical Summer of
Code Materials'.
I previously solved 2 issues[1][2] with the help of dscho and looking
forward to work on more before working on minor project to have a good
understanding of Git's Code. But thought I'd take a quick break to
introduce myself.

Thanks
Hariom Verma

[1]: https://github.com/gitgitgadget/git/issues/357
[2]: https://github.com/gitgitgadget/git/issues/399
