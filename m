Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E265AC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 03:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E8B230FE
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 03:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbhAGD6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 22:58:52 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:40672 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbhAGD6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 22:58:52 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kxMR9-00FeAI-3z; Wed, 06 Jan 2021 20:58:11 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kxMR8-003Eus-4Z; Wed, 06 Jan 2021 20:58:10 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id E6E4450111C;
        Wed,  6 Jan 2021 20:58:09 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gBJ5rMTaUMLf; Wed,  6 Jan 2021 20:58:09 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 7FCFC501092;
        Wed,  6 Jan 2021 20:58:08 -0700 (MST)
Date:   Wed, 6 Jan 2021 20:58:06 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <20210107035806.GA530261@ellen>
References: <20201228045427.1166911-1-seth@eseth.com>
 <20201228192919.1195211-1-seth@eseth.com>
 <20201228192919.1195211-6-seth@eseth.com>
 <xmqqpn2ivcc1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn2ivcc1.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1kxMR8-003Eus-4Z;;;mid=<20210107035806.GA530261@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [PATCH v9 5/5] mergetool: add automerge_enabled tool-specific
 override function
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 05, 2021 at 09:55:26PM -0800, Junio C Hamano wrote:
> If the user explicitly says "I want the new behaviour enabled for
> this particular merge tool", we are better off letting the user use
> it and take responsibility for the possible breakage.

Good suggestion. Agreed on all counts. I'll roll that preference
hierarchy into the v10 patch set.

