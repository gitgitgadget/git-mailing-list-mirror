Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C0920281
	for <e@80x24.org>; Fri,  3 Nov 2017 01:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964862AbdKCB03 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 21:26:29 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:50071 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934561AbdKCB02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 21:26:28 -0400
Received: by mail-vk0-f52.google.com with SMTP id t184so874535vka.6
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OR9iq9hLFq4ndDjRpiHMplkXBd9O1RY8MHeN+OWYaYg=;
        b=auD/Mao+Crb2VyFWGHTStuqJQPE/qUuMfRV5ftf3oRBY9rQpLNhtm8MV4/Y/m0J/pB
         y4xMYgr+JNxwUPuVLvdLPTkQVrTIScRKtJHqQKrMokTApjOQZpZdYFuud8cZamd377z/
         7sgwo/o1UfsPI2O3OAHLF8DfR5YlHnvc4bZ1v/Q8jBBd5Nvdcvmst0jPpVxxvTh1Odb4
         pVznIPh1YchKbAX0+1zOoOm24XCmVXLju5kL2bbSRhTMtrf75pgWsT9fCXNwIfEG3qxp
         AJooG55KEJO8CX/NtaWjYZB63cRhw/J7dvzt+wDjsD6istpH3DWuMbvtINqKjls4icxE
         cqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OR9iq9hLFq4ndDjRpiHMplkXBd9O1RY8MHeN+OWYaYg=;
        b=U1M3GFhsFchPZeutMX/Ntt1UYYpoYW2TQeqj+d1FB3mq6A5vcL43rc1SrtglPLHpBd
         EmeQDONr3ixWxP4dX9wNzD8ey10Qhe5aVI9s4tSxU86ouEdW8oI4UwGGjmebClQQFnt+
         pQ4aKwzt6I1MPmmPzLvyOKrOgRx5i7rozc/xpZ74GAGhyzi8x4ksrYqQ5tOP3gmNLNqc
         HFvVZwqa4/pRum+mwyoB3Pgy1qMaHGD6RWe5mYzVVH8str+cnT1exz5ep0TT4vA7cazB
         ZemjdVkh8Ha+0YbQrljDMSbstLXUsHRY14+bYBMAi5diV9paBt1syzjfe4hcNB04a0NT
         V6pA==
X-Gm-Message-State: AMCzsaWJRcSyifKwIwaig11qDBqYWdck7uT7K3ZadvX7e7ZxOgfVCKe5
        GkxT7VfIxnSvB39UKHyW96wvqcFLuZ5KO7mBb2s=
X-Google-Smtp-Source: ABhQp+QlGEJ4Tq3tL/IaSmDafFh6AKH0k7BqrQCYuOJYE9KTIygm8+KoId0VU+JJvRHWDWUw8K0kyetPopJ77AdHciw=
X-Received: by 10.31.58.2 with SMTP id h2mr4223417vka.194.1509672387511; Thu,
 02 Nov 2017 18:26:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.73.198 with HTTP; Thu, 2 Nov 2017 18:26:27 -0700 (PDT)
In-Reply-To: <20171102181048.16417-1-sbeller@google.com>
References: <20171102000722.1503-1-szeder.dev@gmail.com> <20171102181048.16417-1-sbeller@google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 3 Nov 2017 02:26:27 +0100
Message-ID: <CAM0VKjn7=eCZpz-naWv5SjrpjXFs+wVCOXLN852cfvSoZTuJrg@mail.gmail.com>
Subject: Re: [PATCHv2] config: document blame configuration
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 7:10 PM, Stefan Beller <sbeller@google.com> wrote:

> +blame.blankBoundary::
> +       Show blank SHA-1 for boundary commits in linkgit:git-blame[1].

This is still SHA-1 instead of object id (or perhaps "commit object
name" would be even better).
Not sure whether oversight or intentional.
