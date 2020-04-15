Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA25C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6029020768
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408075AbgDOIee (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:34:34 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51441 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404962AbgDOIeb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 04:34:31 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 492FyV0dVkz1rmhQ;
        Wed, 15 Apr 2020 10:34:26 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 492FyV0PtXz1qtwb;
        Wed, 15 Apr 2020 10:34:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2Y3BnMJsUpJx; Wed, 15 Apr 2020 10:34:25 +0200 (CEST)
X-Auth-Info: 7RLGR4kr1kN1e2ch5n51pFe3Z1PO3n0x9EvaUmekhMsBG3dpZ6cI5fHVSNM0oKJ9
Received: from igel.home (ppp-46-244-163-102.dynamic.mnet-online.de [46.244.163.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 15 Apr 2020 10:34:25 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E23B72C0C5D; Wed, 15 Apr 2020 10:34:24 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
        <878sixdv7a.fsf@igel.home>
        <c35ac17a-fe28-684f-94de-2d2b63b7f4ee@suse.cz>
        <874ktldunk.fsf@igel.home>
        <89363e9d-8739-3061-3d81-806099005e3f@suse.cz>
X-Yow:  I just put lots of the EGG SALAD in the SILK SOCKS --
Date:   Wed, 15 Apr 2020 10:34:24 +0200
In-Reply-To: <89363e9d-8739-3061-3d81-806099005e3f@suse.cz> (Jiri Slaby's
        message of "Wed, 15 Apr 2020 10:27:07 +0200")
Message-ID: <87zhbdcflb.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 15 2020, Jiri Slaby wrote:

> This is the first time I used 2.26.1, though.

Same for me.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
