Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAB7C678D5
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 03:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCID2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 22:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCID2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 22:28:20 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE915980B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 19:28:19 -0800 (PST)
Received: (qmail 4656 invoked by uid 109); 9 Mar 2023 03:28:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 03:28:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27184 invoked by uid 111); 9 Mar 2023 03:28:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Mar 2023 22:28:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Mar 2023 22:28:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] gpg-interface: lazily initialize and read the
 configuration
Message-ID: <ZAlSUYlDn7/9d2LQ@coredump.intra.peff.net>
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
 <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
 <xmqqmt5orqgv.fsf@gitster.g>
 <xmqqh6vwrpce.fsf@gitster.g>
 <xmqqlel7rj9z.fsf_-_@gitster.g>
 <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net>
 <xmqqwn4qokug.fsf@gitster.g>
 <xmqqpmaimvtd.fsf_-_@gitster.g>
 <Y/vf7n2+LN/3Nddi@coredump.intra.peff.net>
 <230308.86fsafzllu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230308.86fsafzllu.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 09:34:15AM +0100, Ævar Arnfjörð Bjarmason wrote:

> As added review: This is the same patch diff as I sent on February 9th:
> https://lore.kernel.org/git/patch-1.2-d93c160dcbc-20230209T142225Z-avarab@gmail.com/;
> my local range-diff to my previously submitted topic & next being:
> [...]
> So this LGTM.

Thanks, and sorry for stealing your patch. I forgot that yours existed
in that thread (and obviously I'm happy if either is applied).

-Peff
