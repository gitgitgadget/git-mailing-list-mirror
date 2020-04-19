Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F67BC38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 13:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57835214AF
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 13:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDSNDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:03:04 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:34415 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDSNDE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 09:03:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 494qkV1BHBz1rtyg;
        Sun, 19 Apr 2020 15:02:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 494qkT5n7Pz1qqkB;
        Sun, 19 Apr 2020 15:02:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id EwkfI2ifR8zN; Sun, 19 Apr 2020 15:02:55 +0200 (CEST)
X-Auth-Info: n/gaU2qvQLPVqPBIwK2s5Lq+Ld/M3s61rQIdjOAB/UDT/qDctU4hqe7e+piVAdUi
Received: from igel.home (ppp-46-244-174-137.dynamic.mnet-online.de [46.244.174.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 19 Apr 2020 15:02:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id CB1BB2C0C39; Sun, 19 Apr 2020 15:02:28 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Glax <glax@dragon.best>
Cc:     git@vger.kernel.org
Subject: Re: gitk crashes if the diff contains certain unicode characters
References: <edace460-d252-2742-7576-e7601b6e959c@dragon.best>
X-Yow:  Kids, don't gross me off..  ``Adventures with MENTAL HYGIENE''
 can be carried too FAR!
Date:   Sun, 19 Apr 2020 15:02:28 +0200
In-Reply-To: <edace460-d252-2742-7576-e7601b6e959c@dragon.best>
        (glax@dragon.best's message of "Sun, 19 Apr 2020 14:15:06 +0200")
Message-ID: <878sirmxwb.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 19 2020, Glax wrote:

> Now `foo` should contain the character U+2754 encoded as utf-8.
>
> If on gitk you click on "Local uncommitted changes", it'll crash with
> the following message:

Worksforme.  Could be a bug in your tk library.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
