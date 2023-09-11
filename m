Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48597CA0ECE
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbjIKVbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244161AbjIKTU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 15:20:57 -0400
Received: from mail8.parnet.fi (mail8.parnet.fi [77.234.108.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F9F1B8
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 12:20:47 -0700 (PDT)
Received: from mail9.parnet.fi (mail9.parnet.fi [77.234.108.21])
        by mail8.parnet.fi  with ESMTP id 38BJKZDZ028573-38BJKZDa028573;
        Mon, 11 Sep 2023 22:20:35 +0300
Received: from foo.martin.st (host-97-144.parnet.fi [77.234.97.144])
        by mail9.parnet.fi (Postfix) with ESMTPS id 5040EA1450;
        Mon, 11 Sep 2023 22:20:33 +0300 (EEST)
Date:   Mon, 11 Sep 2023 22:20:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
To:     =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff --no-index: fix -R with stdin
In-Reply-To: <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>
Message-ID: <c9d3184f-24ac-af75-f31e-aa63c788bfb3@martin.st>
References: <d42579a0-f438-9b4c-97e4-58724dbe4a4@martin.st> <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-32328055-1694460035=:1570"
X-FE-Policy-ID: 3:14:2:SYSTEM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-32328055-1694460035=:1570
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 10 Sep 2023, René Scharfe wrote:

> When -R is given, queue_diff() swaps the mode and name variables of the
> two files to produce a reverse diff.  1e3f26542a (diff --no-index:
> support reading from named pipes, 2023-07-05) added variables that
> indicate whether files are special, i.e named pipes or - for stdin.
> These new variables were not swapped, though, which broke the handling
> of stdin with with -R.  Swap them like the other metadata variables.
>
> Reported-by: Martin Storsjö <martin@martin.st>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Great bug report, thank you!

Thanks for the extremely swift response and fix!

// Martin

--8323329-32328055-1694460035=:1570--
