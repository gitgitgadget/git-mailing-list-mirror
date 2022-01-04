Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D144C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiADVyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiADVyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:54:14 -0500
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC7BC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 13:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sHjFHO6LHlL1NqVfNULkiytmzhcSAUqbNbw8hHxnynw=; b=KjB+8D33lrkX/GtL/AVrOlEQ6h
        tuWobyhA7wi5W/RM5mUKjMGKRAcCu1i2GpiYl6ifkRyTDGv5NlZ4BqUj6prQKabuCqNt0b4u5+V0h
        XIbWlC1cCu7+g8O39gdsgDaSJwh1cwZs7EEBMsu4Suz1R06G53ljrNkb1DaPbfkhGLzA=;
Received: from [2001:8b0:14bb:e93a:fd4f:6f72:643:f027] (helo=ado-tr.dyn.home.arpa)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1n4rkx-0006m0-Si; Tue, 04 Jan 2022 21:54:11 +0000
Date:   Tue, 4 Jan 2022 21:54:06 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v3 RESEND 0/2] git-p4: remove "debug" and "rollback"
 verbs
Message-ID: <20220104215406.27298d62@ado-tr.dyn.home.arpa>
In-Reply-To: <20220104123431.1710-1-jholdsworth@nvidia.com>
References: <20220104123431.1710-1-jholdsworth@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  4 Jan 2022 12:34:29 +0000
Joel Holdsworth <jholdsworth@nvidia.com> wrote:

> git-p4 contains a selection of verbs for various functions of the
> script. The "debug" and "rollback" verbs appear to have been added
> early in the development life of git-p4. They were once used as
> debugging tools, but are no longer being used either by developers or
> users, and are largely undocumented. Removing these verbs simplifies
> the script by removing dead code, and increases usability by reducing
> complexity.

I agree, these commands look rather usesless and I've never used them.

The patches to remove them look correct to me.

Thanks
