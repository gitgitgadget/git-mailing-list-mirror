Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6926FC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 22:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjC1Wkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 18:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjC1Wkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 18:40:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B412330D5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 15:40:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so55926704edd.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 15:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680043209;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQsfy4uKHQEhuNJ+FKz6A+ZZxdUrWmwPGxRXJPoDQvU=;
        b=KxNHH/gvOd7YXUuKXg7ZNK7+eqJE0UPl9G0tlHpNGtpPmwPcEIi91sZvY6PUwZXDe7
         BAfguiqc/NfMfI8oCkytqKs9/bxqi0IgW7/GJ2ocmLDpxn1YCUn2eUzQMHjYib4bTELW
         jKRJtDhkNYSrLB27M2d1u9sp01pd37FgUxTPbVD6PiKFDuKJaBnmLmyY6sxwrGs/R4K3
         W5oOmR0Vl27Swe6a3HYXtdryz2rYGZrEKmMNjIlK0hOOhC0akaSgpX9LxAeiSoSvxmhf
         ROwbd5uKWQE4uQBUda4/6SeZzzFhebXYFST2nKBl7s/CDw8NOGWU5sZuaPQd40PjyMvF
         JPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680043209;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQsfy4uKHQEhuNJ+FKz6A+ZZxdUrWmwPGxRXJPoDQvU=;
        b=NFzmNUVRcr/Rm41fSvmNgsT3rsx7ksNEJvO9oRII04qL7TVr4maM8WTienTsEyHNjr
         PGlZvXhjxCq3D4TvJlHuM2grRO2aC9uX+3A2ZsQrukTx9cV7ifAclWQZDlxN8cx/xICr
         z+A34WS0PmpJr4Us7FwmDpQHjbkqmI/LwJbn1HOS7BzwQboKEkj61HOaoclwio0NETq9
         XcuhAnbMRAaXRwAAS7lC3sSZmQw1kLKxsKZ+u461eetY90OlXz+a6J+l/nHgly7NHhnk
         IW1euvsvhZaexpmnNFx9oACyIOJGTffeFFOFjF3vpQMRZFL1vNMSKeBLvjG2FTOPEBQU
         bKlA==
X-Gm-Message-State: AAQBX9cY1zeRPkeaAkEoxM6wMuERC8YTymdg0/WdeU0EZVRIeJCs5xnX
        KyKS9kEbDuubqLIkppk4xT1GOnmI18Hfenx7wAk469+Tgxs2QUj387DhZg==
X-Google-Smtp-Source: AKy350YCiObQWB61HKEATxiz6wDDqCzckDCTY8kgniUPeaV8inR9cElontMhZnnaCizwrAx1LijpxbfbDXh0Uf2gte4=
X-Received: by 2002:a50:8e41:0:b0:4fb:e0e8:5140 with SMTP id
 1-20020a508e41000000b004fbe0e85140mr8485273edx.6.1680043208666; Tue, 28 Mar
 2023 15:40:08 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 28 Mar 2023 15:39:56 -0700
Message-ID: <CAJoAoZ=KrnAWV3PpfBkYNs_KHFP5O2dVYOWY3jF=CM9+d89Dpg@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 16:30UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

Google is hosting a standing engineering discussion about libifying
Git, for contributors interested in participating in or hearing about
the progress of this effort. Expect this discussion to be free-form
and casual - no powerpoints here!

We're hoping to hold this meeting every Thursday at 9:30am Pacific
(16:30 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

I'll reply to this mail tomorrow-ish with the topic we'll discuss
during the meeting, and I'll reply again afterwards with the notes.

 - (asynchronous) What's cooking in libification?
   - Patches we sent regarding libification
   - Patches for review related to the libification effort
 - (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
 - (asynchronous) Where are you stuck? What eng discussions do we want
to have? (We'll choose a topic from this list a day ahead of the
meeting.)
 - Session topic: <TBD>

Thanks, and I'm looking forward to it!
 - Emily
