Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C9EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 04:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjFQE1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 00:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQE1e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 00:27:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C01FF7
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 21:27:33 -0700 (PDT)
Received: (qmail 7326 invoked by uid 109); 17 Jun 2023 04:27:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jun 2023 04:27:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6381 invoked by uid 111); 17 Jun 2023 04:27:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jun 2023 00:27:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jun 2023 00:27:31 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Arver <linusa@google.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Christian Couder <chriscool@tuxfamily.org>,
        "eric.frederich@siemens.com" <eric.frederich@siemens.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Possible bug regarding trailers
Message-ID: <20230617042731.GB562686@coredump.intra.peff.net>
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com>
 <20230616042407.GA54009@coredump.intra.peff.net>
 <owlyzg4z59ei.fsf@fine.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <owlyzg4z59ei.fsf@fine.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 03:28:53PM -0700, Linus Arver wrote:

> > I cannot think of a reason we wouldn't want to do that (though obviously
> > it would need a test to become a patch).
> 
> I would like to work on this patch. I should be able to push something
> up in a couple weeks.

Sorry, I had already written up the test and commit message while
waiting for Christian's response. :) I just sent it to the list (though
of course if you think there's more to be done, please speak up).

-Peff
