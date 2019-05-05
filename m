Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B18E1F45F
	for <e@80x24.org>; Sun,  5 May 2019 20:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfEEUbJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 16:31:09 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39218 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfEEUbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 16:31:09 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44xyF66gWHz1rWTR;
        Sun,  5 May 2019 22:31:06 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44xyF66Rrwz1rN3N;
        Sun,  5 May 2019 22:31:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id UElrwuQF3d5W; Sun,  5 May 2019 22:31:06 +0200 (CEST)
X-Auth-Info: BFI1POBJzOMLqiT/BAvRFF42TntRRrFV8Wq91oYelvx8OnwbuG1NnqBtCR7vN3Vb
Received: from igel.home (ppp-46-244-180-226.dynamic.mnet-online.de [46.244.180.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  5 May 2019 22:31:06 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 1AA142C11EE; Sun,  5 May 2019 22:31:05 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Surprising semantics of "git add file"
References: <5CCF414A020000A10003108C@gwsmtp.uni-regensburg.de>
X-Yow:  Two with FLUFFO, hold th' BEETS..side of SOYETTES!
Date:   Sun, 05 May 2019 22:31:05 +0200
In-Reply-To: <5CCF414A020000A10003108C@gwsmtp.uni-regensburg.de> (Ulrich
        Windl's message of "Sun, 05 May 2019 22:02:18 +0200")
Message-ID: <87o94gbq46.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 05 2019, "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> wrote:

> After that a "git diff --cached file" just shows the changes added interactively, but when I "git add file" to commit those changes), even the unstaged changes from file are committed.

Did you really mean "git add" here?  It doesn't commit, it adds to the index.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
