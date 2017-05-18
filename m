Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35BB8201CF
	for <e@80x24.org>; Thu, 18 May 2017 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753786AbdERNsb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 09:48:31 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38408 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbdERNs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 09:48:29 -0400
Received: by mail-it0-f51.google.com with SMTP id e65so28225409ita.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rvsSd14FuzAhhAW2s4k7sPNySTWp1G4Ca96vQfwRzx0=;
        b=AcxxbALuOjiWaLFYVCXIiB8kfPKyKfMcaV+QHJRvT86gUXIA/kdVm0bEYKLlHDlBUH
         CE72VIcPP1NUyjX3HaBOyOEJLsHiRXqAActIYzrWIkszQwYjPQatbmnRKT2nvr7BbMmT
         CMyrNYIYQNHBfHz+pWkd8h6VzpXbvB7guZmgg3ZbOgYL7xEs+7eEIyHzDrkLBqNPoCDH
         ygciwkZC8oBoJ/0dRaRJJXqHvxu7zTceHq5vpq9+5YGbtvFzbGeUABi9AQjFJVVJ/cIi
         KyBYWGt6QLaWLMi0dJQ3LKLw+Il7v4YzWAL/8DIGS7VHg9PDanV3XUap5Lb/oA2NzsWZ
         VWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rvsSd14FuzAhhAW2s4k7sPNySTWp1G4Ca96vQfwRzx0=;
        b=Q2a+gel30OhT2NNp7C/iJ5e+ESBxEtneAa27OFkP+QdUW+yNMhtsW89JljnHsMquX/
         tU5KbDaDhgBrq5F5/97D5ROPya3tFGIXYBfz599zdYtWdNmslEzIed9kjomb6kndek2m
         togr4gaC/YdyVKoorVQ9QbzaiBcE6mILzgJOQhXqKlsnRLoqvr2RBi9glNa7ikhhAgIt
         XCXSI69u45+//9EcDJDoCQ/cF6GElmas9Tr65wNcrslH0syLGOX7Au60YjbbN7TA8Ghp
         CA356PsplmyfE3e5wZdSXcpnaA/xr0sL+4WdJtW+8qkFUThO3TqJyNDSVfu5OUvCxj0U
         xhsw==
X-Gm-Message-State: AODbwcBBXRWbNC+A1NzMo1NEAjub+uIABR25XCKoy2ZLlu4OW0c7OFGn
        hon59hQgpShzVyUfdZfHBA6xSYMQfw==
X-Received: by 10.36.166.4 with SMTP id q4mr4633359ite.66.1495115308572; Thu,
 18 May 2017 06:48:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 18 May 2017 06:48:07 -0700 (PDT)
In-Reply-To: <20170518134154.12771-1-phillip.wood@talktalk.net>
References: <20170518134154.12771-1-phillip.wood@talktalk.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 18 May 2017 15:48:07 +0200
Message-ID: <CACBZZX4hbe+bDbxQKy92ruD8=4V7pqnOi9WyBqhunG-F8=wXRw@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: Add missing newline to end of message
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 3:41 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The message that's printed when auto-stashed changes are successfully
> restored was missing '\n' at the end.

Both this and your reflog message really seem like the sort of tricky
edge cases we should have tests for.
