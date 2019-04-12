Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38EA820248
	for <e@80x24.org>; Fri, 12 Apr 2019 22:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDLW6Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 18:58:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36814 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDLW6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 18:58:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id k130so6681697qke.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RswcBp0E7CB6t8momqWFvTZbZbmZ0Ivc0PxBuTP0fo0=;
        b=ri0xtVSnCQpG3TTIIcdFeTicX99I/9bOID4k3H6dNexDuBCoQOvxFxDZnbcO6deRDI
         wEAszWXbeisMgjhxqVzcYsARWpNG4s/ENpXprO+oV2lybZ3IssrPI2EqNOyxtymiSWcU
         zZIwcaohFtGwNVnIS8WXeH2Orygh3RWQC392woaOPQ11ZlZjTgcyjRlK1/0VB4HwHZYo
         yP+LYPseGDCS6+TuLlLMy/ipzWcQ07vlZL8J5EaK4aSp3CAPRXDbmrkScD3TxnNsvtVm
         RjF1JrpiWQWKU0nXVl3LkS1EmXgs+ax76K3jTvT+gNRbw+KpX1mLMqBh+y/+l86gE6GK
         phPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RswcBp0E7CB6t8momqWFvTZbZbmZ0Ivc0PxBuTP0fo0=;
        b=GjV4T67ODTtdplbv9ogdHSak3C7ZKolTkfJv3YNLyrBtBt/MbUF3xccJaFZzM9jFEF
         M1YqUoPGa86wdquM4bUBhbwZqLvf1PCSCvvVEpQZyWdd0cnOvU0CxZok8VmFwLbOzVaY
         dWpCqQG079Ne1LqHSSAtphg+LD7rnbvPSZ7UZhzi3znQ0SOAtO1eccatBk1HIpUU57pk
         oRZxCVPCUoemueEzelnWw7isfkND58C1fRKhfrddsOWqf21ExorzbQr0958xl1kMPbU7
         AxFSXH3g3qII3sDo9/9j9UB96O7cyOQpvnH96rqEsPtLmFFtzoGYr29QWzW3o6P0KMpn
         ki8g==
X-Gm-Message-State: APjAAAUuAYo1pJpiigwuwMfeACaxFIuQHn3fXJ9fonCLLNVp/1cnchCW
        Opa1xFvWvY8eYPuwiwnmBf6w4IMFyaxnFxNntPQHGA==
X-Google-Smtp-Source: APXvYqwPRPyisEKvrYYs84C33ydkOS82vE6wj3JMA9LOpULEj+xe4PzJP4rCisFET15Ugly+MNeG33JicG1cZ/BSmBQ=
X-Received: by 2002:ae9:e313:: with SMTP id v19mr43959730qkf.153.1555109895221;
 Fri, 12 Apr 2019 15:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.177.git.gitgitgadget@gmail.com> <xmqqmukwymq7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmukwymq7.fsf@gitster-ct.c.googlers.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 12 Apr 2019 15:58:04 -0700
Message-ID: <CAJoAoZnGAS5DOJoU_y+1t20kyxsDodFpQmwRd2_XZD9S2=pRLQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] documentation: add lab for first contribution
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 7:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > RFC. I am still working on adding a section on handling refs and objects.
>
> Thanks.  Is 'lab' understood widely enough?  I _think_ you are
> abbreviating what is known as 'codelab' by your colleagues at work,
> but would it make it more in line with what we already have in this
> project, perhaps, to call it a "tutorial"?
>
I think you're right; I'll try to modify throughout. As part of that
change I will also move the sample to a branch with a more descriptive
name and change the URL.

Thanks a lot for the detailed review, Junio. I expect to send a new
patch later today, including an exercise in examining a specific
commit.

-- 
Emily Shaffer
