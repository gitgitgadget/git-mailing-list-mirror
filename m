Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C74C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DBF22EBF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgHUS3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:29:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:50259 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgHUS2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:28:19 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BY94c59rdz1qrfh;
        Fri, 21 Aug 2020 20:28:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BY94c4rc0z1r175;
        Fri, 21 Aug 2020 20:28:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FFKS0_LO-AGW; Fri, 21 Aug 2020 20:28:16 +0200 (CEST)
X-Auth-Info: k+8d4sz4U90CC65zkz+UkcrpkelxJkuRJY2+onnYw7WJSgUc+1YSABMHM5xvoztY
Received: from igel.home (ppp-46-244-185-194.dynamic.mnet-online.de [46.244.185.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 21 Aug 2020 20:28:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 7D01E2C0AC8; Fri, 21 Aug 2020 20:28:15 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Alvaro Aleman <aaleman@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: --author arg on commit only works if there is an email
 configured already
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
X-Yow:  RELAX!! ... This is gonna be a HEALING EXPERIENCE!!  Besides,
 I work for DING DONGS!
Date:   Fri, 21 Aug 2020 20:28:15 +0200
In-Reply-To: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
        (Alvaro Aleman's message of "Fri, 21 Aug 2020 12:15:49 -0400")
Message-ID: <87ft8fvoow.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 21 2020, Alvaro Aleman wrote:

> It seems the `--author` arg on the `git commit` command only works if
> an author email is configured already somewhere:

The `--author' argument only sets the author, but git still need to fill
in the committer.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
