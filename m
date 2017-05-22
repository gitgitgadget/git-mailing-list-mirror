Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8948D2023D
	for <e@80x24.org>; Mon, 22 May 2017 18:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935107AbdEVSeE (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 14:34:04 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35598 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934590AbdEVSeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 14:34:03 -0400
Received: by mail-pf0-f180.google.com with SMTP id n23so90070655pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LtI/Hrw0zzpJklgR/IIwb3yd7RX7h/fVUf2jlGT0HtY=;
        b=UgBsFhF0f0y11XEZJvRQgtj6ObEEv6qhWcMKc9LFsaYZ0cMSpPfvweDaLp/JijuviW
         7p87WNaB6h63IZHIVNX6eK6Z+KBayefF/KJdrBV9RxMtwE03tJmzsPd59JXJpxHdrST9
         ncTk/L5h4bR+5EBdKPB6vgtbCNVFkBGhA3R6Wt9B9f3DeIqDc7GCbY28xFYxZI/YDT2Q
         uLeGHp3JA1x1UOD4l6y08vuNNd97yc6VYtw/zvqHdlYI1WE9cfZiRqUF9kzGRCnav//L
         ZwHIVscSNq7InALeaygXWAiqU4umVLuskov9XqKq1GycB/eP4vQAW0SMcVBkr2dVcC3D
         jzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LtI/Hrw0zzpJklgR/IIwb3yd7RX7h/fVUf2jlGT0HtY=;
        b=MrjSDgvQN373Vw2CedS44ZE1t92F1xmk+65SFLP4JWLbvuNnAhVLqfxJ5ESTWhvcs9
         M6KOz3Xl11Obkmk8py+mO4/YXcvRNCZIlUDLm4avlphVAGEx8z7UciRyOF/yOTVrn2tD
         FQO5RJPSJhDYl0Xl+JnNcrJApZrqFQ0W6vFkWh/ucrClVV/YPaPTUnroMwF05rJI9ITG
         vqGlE7XhBXW67l0Vrkb4yHlSjTbR3JyRWY5cIHjZMpLGAql8oBH6hnT4zAb1qW6ifaBU
         XzeumQqOrkPjTdakXIByLLxV/Owa7U/C0EvxJAbvzqci+dU7EIqkCJ4cwcUU2CiADEcv
         RCPQ==
X-Gm-Message-State: AODbwcDH1Y9QwRvLfLJPB7kYfpNFy1MMgEWeowtW2d1vU+5LTjHsSAYw
        Ex4Cv/3v6zaz/6TmEV+f5UCrju/sLh22
X-Received: by 10.99.60.81 with SMTP id i17mr27301452pgn.183.1495478042834;
 Mon, 22 May 2017 11:34:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 22 May 2017 11:34:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 May 2017 11:34:02 -0700
Message-ID: <CAGZ79kYirjV0eQgB_ng-64HSPN_7njUMjnoNBkmWnx-rinsemQ@mail.gmail.com>
Subject: Another git repo at kernel.org?
To:     webmaster@kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The Git community considers using submodules for some parts of the
code (a third party lib, SHA1DC, computing SHA1s that warn about
potential attachs, see shattered.io) [1].

We are also concerned about single point of failure there, so a repo
at kernel.org
mirroring the potential submodule[2] would be great.

I cc'd the git mailing list as we may want to have further discussion who
shall have access to the new repo.

Thanks,
Stefan

[1] https://public-inbox.org/git/20170520115429.12289-1-avarab@gmail.com/
[2] https://github.com/cr-marcstevens/sha1collisiondetection
