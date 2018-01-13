Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6423E1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbeAMGzO (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:55:14 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:38897 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeAMGzN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:55:13 -0500
Received: by mail-ot0-f175.google.com with SMTP id h2so6891442oti.5
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yfXBuFQ2fFq3WeRsnHis4BXNWATevRRtTP7Ymr/GtUw=;
        b=O74yAgo0WChru2sPfd/qX3TQ/bewpanNVzGw8nolL4QmAG+xOB155nlr10YwBGf6FK
         /mdnFCZL30YABHP75lex26LbqI5nkT7ZX1pkX+Hn9IWL/s+HnQCw70Kqkmen2miNsxHx
         EuW7lj+q9kCNyi8lK0EL4k1vzEfKESYyzZ9Dp3Y0/YDUDtmfydGv+nY+QcS9zuH8oMb5
         2zFfTILjkRk3h05Y6n7dwcYaWKi9HuZIrNW8h63/fEAy/S9v4cmDMsT5jfp+IMLXOUSE
         ClsgUnz3WNAxJ3bjtVZ4lwvIM/pIhmJ1jz99VJmgFi4ngdRLeMqKQxs3FYbr1X8L44Kq
         FEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yfXBuFQ2fFq3WeRsnHis4BXNWATevRRtTP7Ymr/GtUw=;
        b=hsHft2ovvLl/RL9kkkRRdZwIpOTQTLL/GO4fjlGUYXJWSsxwpRBAgRqIof9HFcESvs
         kOZNDMuGFKFPj77tD8rVu//KCudcdhkZgXVMf2+wmZaPLL72LoVKCaeU7plR1jKVhjfH
         DleMnvsP404BozhgQJdS2szHuj82z6cCfZWpJkVyThmbiYdxLPnGYJSApkfwtivS/GCo
         Av3uASkRasj1GpYuWXQ136hFU9INNGtTajFSqLg4LhwqGmK/FWFQLeiU/sQ6fGE6E4gS
         0sjhCRGtIogVpmkOjd+0mxs6gsJhZH2TvQ1nDZTKmtya0saNs1lbbavaYudY06V0lKq5
         GoBQ==
X-Gm-Message-State: AKwxytfNjBP+v52d08RlLaCpdP4W+m9SgIIugK3oMlwvc0iPII2kfbiM
        lRBhE5XmMwx5MfQ064d1yEec/R8ncKw5dm/7v8Y=
X-Google-Smtp-Source: ACJfBouvxKswrNeGQWrD7NeuC157C5NBCHn5nXLeAA9V+dczJOC91TYPP0ixQ1/Q4PCWhqCfHNKGCVPyWcLrrtPRmUE=
X-Received: by 10.157.32.108 with SMTP id n99mr18131131ota.301.1515826512861;
 Fri, 12 Jan 2018 22:55:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Fri, 12 Jan 2018 22:54:42 -0800 (PST)
In-Reply-To: <CAGZ79kYUyugA_BhMgr_k1aWfxg9+cNbOcVO+LOZkZ1YAAu7_mQ@mail.gmail.com>
References: <20180111094712.2551-1-pclouds@gmail.com> <20180112095607.18293-1-pclouds@gmail.com>
 <CAGZ79kYUyugA_BhMgr_k1aWfxg9+cNbOcVO+LOZkZ1YAAu7_mQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 13 Jan 2018 13:54:42 +0700
Message-ID: <CACsJy8BagXM=A6+yd9GbBxp-_Ht5Og1_LqkUQGhd+dqkMvKP9Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] run-command.c: print env vars when GIT_TRACE is set
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 12:19 AM, Stefan Beller <sbeller@google.com> wrote:
>> Oh.. before anybody asks, I'm not adding git prefix to the "cd" part.
>> You're supposed to know that git moves back to worktree top dir when
>> you read $GIT_TRACE (or are welcome to improve the print out).
>
> Heh. Would appending  "; cd -" solve the issue? (Though I would argue
> we don't need or want to add that actually, as you'd want to copy and run
> the command and surely want to run more tests in that directory afterwards.
> I mean you're debugging, right?)

The problem is if you are tracing in a subdir foo/bar and the trace
output says "cd xyz". You can' just copy and execute that command and
have to do "cd ../../xyz". I don't see how "cd -" would solve that.
Printing "cd $(git rev-parse --show-cdup)/xyz" could solve it without
passing the prefix down to this trace function. I guess. But then that
command depends on $GIT_DIR. If your $GIT_DIR is being changed (i.e.
submodules), it gets ugly again.
-- 
Duy
