Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A9C433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC37650FA
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhCPFkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 01:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhCPFkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 01:40:05 -0400
X-Greylist: delayed 1493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Mar 2021 22:40:05 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DB8C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:40:05 -0700 (PDT)
Received: from [2400:4160:1877:2b00:9884:91a6:82c8:afa1] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1lM22r-000897-25; Tue, 16 Mar 2021 05:15:06 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1lM22l-000ACi-Uw; Tue, 16 Mar 2021 14:14:59 +0900
Date:   Tue, 16 Mar 2021 14:14:59 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [ANNOUNCE] Git v2.31.0
Message-ID: <20210316051459.oqsl7bhwh6he5cql@glandium.org>
References: <xmqqwnu8z03c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnu8z03c.fsf@gitster.g>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 12:30:15PM -0700, Junio C Hamano wrote:
>  * Two new ways to feed configuration variable-value pairs via
>    environment variables have been introduced, and the way
>    GIT_CONFIG_PARAMETERS encodes variable/value pairs has been tweaked
>    to make it more robust.

For the record, this is backwards incompatible with git-programs in
$PATH that were expecting the old format (e.g. git-cinnabar releases
using an older version of libgit.a).

Mike
