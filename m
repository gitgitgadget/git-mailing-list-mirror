Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF85AC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiKVXaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiKVXaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:30:13 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36D1F9C4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:30:10 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4NH0q21yQ9z1s7tx;
        Wed, 23 Nov 2022 00:30:06 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4NH0q20x4Lz1qqlR;
        Wed, 23 Nov 2022 00:30:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id OnaJiByXNkbX; Wed, 23 Nov 2022 00:30:05 +0100 (CET)
X-Auth-Info: nY8vcjZ1GhLKFmD82/sle8m4C+4Ekoy4P413lRlm2SdsVSjt0uuQsfebnuZ1tilm
Received: from igel.home (aftr-82-135-86-141.dynamic.mnet-online.de [82.135.86.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 23 Nov 2022 00:30:05 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 3D8732C3108; Wed, 23 Nov 2022 00:30:05 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Andreas Hasenack <andreas@canonical.com>
Cc:     git@vger.kernel.org
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
X-Yow:  Hmmm..  a CRIPPLED ACCOUNTANT with a FALAFEL sandwich is HIT
 by a TROLLEY-CAR..
Date:   Wed, 23 Nov 2022 00:30:05 +0100
In-Reply-To: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
        (Andreas Hasenack's message of "Tue, 22 Nov 2022 14:37:38 -0300")
Message-ID: <87v8n6o9du.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 22 2022, Andreas Hasenack wrote:

> That regexp could perhaps be:
>
> /^processor\s*\d*\s*:/
>
> or
>
> /^processor[\s\d]*:/
>
> or something else.

Something else.

$ getconf _NPROCESSORS_ONLN

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
