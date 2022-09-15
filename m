Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E528CECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 20:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIOUTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 16:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIOUTT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 16:19:19 -0400
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9B57E30
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 13:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1663273149; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UorNItrc8ztLCCa2C2s+UDXlAtKBUQvad1ffueSgifWPb0rs3bnjkH6EmEijIW8RB4h1VYBXNG2zx+R/Eb85IMWiQUkvpnqIbpbWfOfbglI0GKDYSYjFAd2ntRiHUwyjsqgBCl2TeVVnmaZ5PLB1Qyaiyskn0XQVvL0WwG3n8I4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1663273149; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=x5BLUstskriWsJybheqI+LHPNkQvtXb1AzI/c8B8Z10=; 
        b=JgT+XpVEjPkf0KC/dwntvsAA7fEfZ24nFIkjSSU+8S5DJS58xYnAH/sbQjKAxw0K+tZdVCu20chPfpQFKhUSwcKsmADW/nnA0tYhSmhbQjzfobZBCqOR91g+/BfosC4jvN7BXOfcdyAu7FgnqsXEJWyF6xqBAlIJidFVcnPZc0g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1663273148952796.5915929362433; Thu, 15 Sep 2022 13:19:08 -0700 (PDT)
Date:   Thu, 15 Sep 2022 13:19:08 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "hanwen" <hanwen@google.com>, "git" <git@vger.kernel.org>
Message-ID: <18342ce2209.d56a95ef1029282.8747052454037800255@elijahpepe.com>
In-Reply-To: <xmqq1qsco6sx.fsf@gitster.g>
References: <1833f3928cb.acf3c97d869879.7909589521159235166@elijahpepe.com> <xmqq1qsco6sx.fsf@gitster.g>
Subject: Re: [PATCH v2] reftable: use a pointer for pq_entry param
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
 > Hmph.  I do not know what went wrong.  Somebody between your "git
 > format-patch" and the mailing list archive ate tabs and spitted out
 > spaces, it seems.  I'll try to fix it up.
Looks like my mail server tried to convert the spaces to tabs. If you could fix it, that would be great, otherwise I'll submit another patch in four hours.
