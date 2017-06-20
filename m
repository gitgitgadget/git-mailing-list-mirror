Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E9F20282
	for <e@80x24.org>; Tue, 20 Jun 2017 21:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbdFTVm1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 17:42:27 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33123 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbdFTVm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 17:42:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id 83so75322368pfr.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v55BrFHfhboy13X+R90ya9p5T7BKy0CRwRwLl33c7bs=;
        b=uBjBAKODKCFo+y3zg5qVf5hHbXfUsS2d9aLOnaNhn0PYe6JlSeOTwvQI6yPeXFyuwb
         SNvniwWND1+TSSQyo1Rcq8o5uFLmikF6QB/m7679cniiQen5SLxli8YqsEQwlg6G803B
         1O1F+/7/GnidX71idRB13GoPe1Dg71Uvyy4vVgJrUXM2opRz5RUfMvmof+BhStXXkkU1
         9uYWcplPXt+XD+EaTqk0GdpekOg3TMPuZDz+ooSHfkvRNJTrVDlUrdgBALGK0zpWVITU
         0G80/nvOTGv0Zv3Djms6alExgvDDVZL7bHtC7DRJyRyQG7ZkAo+Ri54CY+Ij3hFWCa7C
         akLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v55BrFHfhboy13X+R90ya9p5T7BKy0CRwRwLl33c7bs=;
        b=Muj2paLiMrZjmK0w5uiZ5NmdBcUKsvlC7WSxoHbj8xx4KfhYOCg2cLnk3nKlsgCYhE
         ngqgn7AxmufAIVI9oU85rpYdeCZtThvd3RgcKOB/P2XJ6df3c5Vaexj53/vyzKIMS/MG
         F5n0dMaV/XUUlf68nXL/YBrH8CmqDZNFsOHE+Ru2i0EBSiWWm94VewRJnJIPsbqhdhsJ
         33BlAX4r94cWDUnikjVe7PDG7oAxlPxHIu3qFPQXpIpSAYmEykcgyxppsDUpY1bSYN7Z
         TNJbSB7fyxdGHINuOr+2ijSYaEeL8Fj4rCW2n+k0x5/iWmMZPyVoUFR5b/UefZgFXu3t
         9/Eg==
X-Gm-Message-State: AKS2vOxWql+4LW27ymbU11FdKx3Lm6A5KsqURvKTauSGl3TI3lyx8fjV
        AD4bhnVewAzEH98IMWqHmtQkqBFEsBVs
X-Received: by 10.99.186.81 with SMTP id l17mr14391449pgu.87.1497994945907;
 Tue, 20 Jun 2017 14:42:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Tue, 20 Jun 2017 14:42:25 -0700 (PDT)
In-Reply-To: <20170619181017.GA194323@google.com>
References: <20170607185354.10050-1-sbeller@google.com> <xmqqo9tr660x.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdUARvhO=UwexFGkWQzsYSnyyiXJMX69W9ofhz13zjHQ@mail.gmail.com> <20170619181017.GA194323@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 14:42:25 -0700
Message-ID: <CAGZ79kaKBhhRZgjUChrw+MMFB0b_mQ037+-MTeAsQKMR9oCE4g@mail.gmail.com>
Subject: Re: [RFC/PATCH] submodules: overhaul documentation
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 11:10 AM, Brandon Williams <bmwill@google.com> wrote:

> I would probably change the first sentence to:
>
>   A submodule is another Git repository tracked at an arbitrary place
>   inside the working tree.

The tracking doesn't happen at an arbitrary place, but in
the gitlink/.gitmodules file. The location of the submodule is
at an arbitrary place within the working tree.

In a resend, I'll reword it completely (again) to focus more on the structure.
