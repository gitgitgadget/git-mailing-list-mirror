Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D05202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbdKTUHs (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:07:48 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36685 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbdKTUHq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:07:46 -0500
Received: by mail-qk0-f174.google.com with SMTP id o6so9030427qkh.3
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 12:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3kexnBLh2PbPULsVirhAIT8nxIP1Qg+en4/z5H5hWxM=;
        b=cNh8MYTgI/yeaYMnzulebq85MP+5nkZVbKzjbHanxp6hAunpxQHqwRzR0jxHewF23u
         CYU/QrFBvRWgmzBQtPBpLQ1BUwF1kT9YJlXZAiZlcF6EbspsaLt7JN40fnAZnPtBh2RX
         BAtXARJgcwz0rOoV/X5Kt42l0vLeWAPY6POQxDdYyl+t8ZHo2uIoIAxjvt28xXy6o8NV
         O219jwnT0wEOOFgIarpqAkg6DxMC5CkI12EUrnoMou2hk3MZe/GZ8ENhZ6CyxpF0xE9Y
         mkzMID0SXZ03Ad3AP5O1nz7PzY7Jg58liHHAGoFDDOakr2y99WuCMq3jUiEyZl9043i9
         x+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3kexnBLh2PbPULsVirhAIT8nxIP1Qg+en4/z5H5hWxM=;
        b=Ew8HGtqnZyVlpZGO2gTMFQa1cvTW2odS6FeSndhNA9tCuo7IF7IwJudBGncSOaCeLW
         kvXGpJyqwEzjfiIh0vyvEE6u0+l8uHmk9czy34jHFaWQFjzmStDPkq+MNaYmmMUIaZ2/
         UXp66N3CBItiUdIHloGwewPmHKBptzrUpfaiM6fR+AZsuoZQDqs/jPKGj8ld89cvsmPt
         h31ZV/JaxMPcxXgBmbukZuUA33wI1QXrKgj8l3/8zlgRb37AfzayEhID5bGa3XWlclAa
         PIgVohlU0Hks20K4fNA/Ps4HsZo2tvthrNDs9GmcgrhKAB8YDKG1Q/EeqcVsF8dWbUxH
         Ed1A==
X-Gm-Message-State: AJaThX5z90acNPY+7PQ3MaeSek6c+qwDqOiY3giWerDZ972E9zBTOHzu
        Fbvi+9+GFGwJ+M7DJQIKtk4UO2HCgYHK0g5N7v7Oig==
X-Google-Smtp-Source: AGs4zMZFx2684xvqhIzZQP2HgkTrLN564rjlKYQkfeigHV+tpZAABBOcS9pXiKpliBCTwhKDSbYheLfRz3iBBPsgH0M=
X-Received: by 10.55.106.132 with SMTP id f126mr21940974qkc.295.1511208465448;
 Mon, 20 Nov 2017 12:07:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 20 Nov 2017 12:07:44 -0800 (PST)
In-Reply-To: <CANb5NdLE3edJW4nRDqrPFuC4680J_K-Nt8VyW5tgjRBgf_ZU1w@mail.gmail.com>
References: <CANb5NdLE3edJW4nRDqrPFuC4680J_K-Nt8VyW5tgjRBgf_ZU1w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Nov 2017 12:07:44 -0800
Message-ID: <CAGZ79kZN-DroN=6FywCF29fEdUJO95raNtAFXWWNPsnGr1L8oQ@mail.gmail.com>
Subject: Re:
To:     Viet Nguyen <ntviet18@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

did you mean majordomo@kernel.org instead?

On Mon, Nov 20, 2017 at 7:10 AM, Viet Nguyen <ntviet18@gmail.com> wrote:
> unsubscribe git
