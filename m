Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335B61F454
	for <e@80x24.org>; Thu,  7 Nov 2019 17:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfKGRBz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 12:01:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46620 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGRBz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 12:01:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id n14so2557274oie.13
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 09:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zu9lqF987g/qTrxWip7qiintOWkBc5OOAWD/La3DqWQ=;
        b=QzoD+Wf9c8V5k5u5o5r8W/6rgN47Q6Mn9v4dLjo7TiXAwDj5jhaadrEKBf5AdPEaVr
         oVvKMtPwwq9E+g5pyMyp5v3vwGSWOlUN97swAc+31tuWsbcsDALQxK+Twh1bghKGS4cy
         2imhGd4ebPhl6wuMvOZdsPA+amTEoKy5dzodU3uxO2NPLIer1PzL5iUAnR/AXNRXO1ME
         d/UhFjJohW7bmPsXMfUOfGQX9IH8NP0v27F6QVKckxKNJyZqk8Kb/vrTnZFamCqDT0eb
         pafB+gXPzpoGEbLOuC9Fc8wKk/CvpWc2dF7IQv2l9EVkRLXlaQB0GWVdFHIJqHgSOJ9L
         aVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zu9lqF987g/qTrxWip7qiintOWkBc5OOAWD/La3DqWQ=;
        b=MmEHHK+8gjEsn5ixMDwkil197nTLAM0ovs2QKC9KM+xeXdDVn/CgIFVRlLxpX5u58j
         DLDz8/FI5d1jNsmeploGK5covGEPk1rqU49nqf7YCc2ki5RpUdeHszYl9A0gd/FMd7a3
         bbAIvjK1n4f6jOk17VBM6+eNX99p4v/G7WHTx5O/47U2hb22L//jR2u/XqReeqNWezSm
         XnyyLA00kqkPVW1L2vLT+6+g4rKpxHMn4ixkNLiNTuUsE9lq+H3OE24KI8cg60LZUKyB
         sTnaUzsbt4ERwfC3KDsi7/oZ3AFD8hkMiJtu6gwgcwZSfOFQvpX63Hp9OZKUEoOtVAEm
         yl7A==
X-Gm-Message-State: APjAAAUJDS1eNRULDNQkw/6TnOZwk62mUfgGl0eJzTgJuIzrbhKkS7g7
        PO93YnZwcAN/uqEyeMnXeaaAp53CBGgBwR4VuCE=
X-Google-Smtp-Source: APXvYqyW3xwdmIMX6kTsy0KULppNm0fmQC77/7xZ3Wsoi5OaoEIecESSezqQgz6zX2sH3lYrRrrffCoMZm167mpkq3g=
X-Received: by 2002:aca:4f4f:: with SMTP id d76mr4478052oib.167.1573146113918;
 Thu, 07 Nov 2019 09:01:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
 <pull.418.v2.git.1572973650.gitgitgadget@gmail.com> <466aead9af6516ff94a5d217e58ab894e63088b7.1572973651.git.gitgitgadget@gmail.com>
 <xmqqh83gs1ui.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh83gs1ui.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Nov 2019 09:01:42 -0800
Message-ID: <CABPp-BECJezMeg1pZyQijkBDooA_834weeg_2hsZ1Vonm-tAEQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] Prefer 'up-to-date' spelling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 6, 2019 at 9:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index 33ea7810d8..8ba2dc3267 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -29,7 +29,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES]
> >       "Entry '%s' would be overwritten by merge. Cannot merge.",
> >
> >       /* ERROR_NOT_UPTODATE_FILE */
> > -     "Entry '%s' not uptodate. Cannot merge.",
> > +     "Entry '%s' not up-to-date. Cannot merge.",
>
> As the name of this table says, this is a table of the plumbing
> errors that are given without translation, in order to allow scripts
> to read and act on them.  Wouldn't touching it break the promise to
> the scripts?

Oh, right.  Between this and the gitk issues, how about we just drop
this patch and include the rest of the series.  Would you rather just
drop it on your end, or do you want me to send a re-roll that doesn't
include it?
