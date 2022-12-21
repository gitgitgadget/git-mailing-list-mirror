Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADBC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 06:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiLUGeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 01:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiLUGeU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 01:34:20 -0500
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 22:34:18 PST
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [IPv6:2001:41d0:1004:224b::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD11DA50
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 22:34:17 -0800 (PST)
References: <20221216093552.3171319-1-karthik.188@gmail.com>
 <20221216093552.3171319-3-karthik.188@gmail.com>
 <xmqqr0wykj59.fsf@gitster.g>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
        t=1671603967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bc5JvGGy5Sq88xpwObY7zZK1i7ZASRwi2DkgAmLUuOM=;
        b=pXU4KV8AkqW+S4oEIHs1GgpT5i6HaEHUB7Nkzp74ZBPyPse9e+oeugNbzw6epDbEL8OR0N
        KyK07/Liz5LpGZ4qiwxVSVo71APiAa2HlpLIRospIVpTRfmfd9tgm5kUQ06f9/qMc1D4XP
        /hILPz25mTlMiiAikhjd5T2+K7+ayY8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Toon Claes <toon@iotcl.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] attr: add flag `-r|--revisions` to work with
 revisions
Date:   Wed, 21 Dec 2022 07:10:41 +0100
In-reply-to: <xmqqr0wykj59.fsf@gitster.g>
Message-ID: <877cylqnlv.fsf@to1.studio>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> Co-authored-by: toon@iotcl.com
>
> Co-authoring is fine, but as one of the copyright holder, the other
> author needs to sign it off, too.

I'm happy to sign off, on both patches:

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
-Co-authored-by: toon@iotcl.com
+Co-authored-by: Toon Claes <toon@iotcl.com>
+Signed-off-by: Toon Claes <toon@iotcl.com>

--
Toon
