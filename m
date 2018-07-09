Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80C51F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933717AbeGIRbg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:31:36 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:56302 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933619AbeGIRbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:31:35 -0400
Received: by mail-it0-f73.google.com with SMTP id k13-v6so14541983ite.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ml889uQFSe6WScvONUycLaboYNjdoj3qbzz/+ffCuJg=;
        b=THWSze+pfsORcLTlCh9OE3PYf3moC43R5VF/c7j6kx5gi/rmToX3KIzpIW1Fuzam0l
         enYC16CboYR4rz3x0aQKmvxqxCOLLsvNlnkdR1vesz8V4gvkOTW+yvU7MufKGgF2ORPH
         Hp19TU453f9x93fhymxBBxZFB1L16jumNCGhqeYEjvMWymGB0FeqaaUauFY1Jw25Zbq/
         G8j5WVDcz+eONy+VBKWGvIw80Gg6c/q5u+Y5+M6tUHjUCZ42GibpLvqfro5z4r/Z1b0s
         gNON7VCwc7xsqK66veQ9m/EXE9bxGgqS5vXNkEKy/OJAEvGGDZDeE6PsjK2vo2Ociz83
         HXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ml889uQFSe6WScvONUycLaboYNjdoj3qbzz/+ffCuJg=;
        b=GLjprhCNYanMBesERFhVoSiloOoEDH23LaVl0OiPfZ5FSCtGUuK8glZMc+4igMf1r9
         +0oeyOBAf+B9fe2BIVNbOCqe7rMEbwSGkKVe/W2uzwq4tEi2lG8J90XxX3ir29wLGLYm
         AmErTQiUN2WpSsaRlQEt4vY/ETEbMxtAW1kpfpgXEQNSm/vNydxUr/xFzpQvXvdKOgyQ
         S1wNeyFtSkcdJIL/9sDU+E7l5ZOemFzGrIjZCaI8Yw6+7/CM8k8In9VdkoMmGHhCOjZ6
         akyGJv+TWvhr39dajLZNzPqALaSNLo8BJNFV1a4JjByEXvti0wmihb20AhMLskt7uXiW
         GknA==
X-Gm-Message-State: APt69E32TNFYuiNDFhLKLBtNYdVclL2br/+G67VKMI0Jeaca+0bCtTgu
        iRaarW79JxkgEfL0v0b5RlxbrdIjpYsPspdDyYP7
X-Google-Smtp-Source: AAOMgpfJZcgM7GY6M9+9igNHl0WyXOMZYRX+FFHYg6wPuYFgv37A2coj+McRgmxcbggMM/52IIKZT76TuRqDHP0xp6Kr
MIME-Version: 1.0
X-Received: by 2002:a24:228c:: with SMTP id o134-v6mr9287815ito.30.1531157494609;
 Mon, 09 Jul 2018 10:31:34 -0700 (PDT)
Date:   Mon,  9 Jul 2018 10:31:31 -0700
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180709173131.58704-1-jonathantanmy@google.com>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/fetch-pack-negotiator (2018-06-15) 7 commits
>  - fetch-pack: introduce negotiator API
>  - fetch-pack: move common check and marking together
>  - fetch-pack: make negotiation-related vars local
>  - fetch-pack: use ref adv. to prune "have" sent
>  - fetch-pack: directly end negotiation if ACK ready
>  - fetch-pack: clear marks before re-marking
>  - fetch-pack: split up everything_local()
>  (this branch is used by jt/fetch-nego-tip.)
> 
>  Code restructuring and a small fix to transport protocol v2 during
>  fetching.
> 
>  Is this ready for 'next'?

Sorry for the late reply - I think that this is ready for "next". I have
addressed all the comments that you, Jonathan Nieder and Brandon
Williams have given, and Brandon has given his OK [1].

[1] https://public-inbox.org/git/20180625182434.GE19910@google.com/
