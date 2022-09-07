Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DFCC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIGUtA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 7 Sep 2022 16:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIGUs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 16:48:57 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448D9BD2A0
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 13:48:57 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 287Kmt8D063295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 7 Sep 2022 16:48:56 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net> <YxfSRkEiiP4TyZTM@coredump.intra.peff.net> <xmqq1qsnugsu.fsf@gitster.g> <YxkAxutS+B8//0WF@coredump.intra.peff.net>
In-Reply-To: <YxkAxutS+B8//0WF@coredump.intra.peff.net>
Subject: [BUG] t1800: Fails for error text comparison
Date:   Wed, 7 Sep 2022 16:48:49 -0400
Organization: Nexbridge Inc.
Message-ID: <001201d8c2fb$3f1c51b0$bd54f510$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdjC+y4bYGbHoO6eRmK3MMU8cNYy6A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am finding an issue with t1800.16 failing as a result of a text compare:

-fatal: cannot run bad-hooks/test-hook: ...
+fatal: cannot exec 'bad-hooks/test-hook': Permission denied

I don't think this is actually a failure condition but the message text is platform and shell specific.

Is there any clean way around this?

Thanks,
Randall
--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



