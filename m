Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B35C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjBALvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBALvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:51:54 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D2761D67
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:51:53 -0800 (PST)
Received: (qmail 31550 invoked by uid 109); 1 Feb 2023 11:51:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 11:51:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19710 invoked by uid 111); 1 Feb 2023 11:51:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 06:51:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 06:51:52 -0500
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Rafael Dulfer <rafael@dulfer.be>, git@vger.kernel.org
Subject: Re: Inconsistency between git-log documentation and behavior
 regarding default date format.
Message-ID: <Y9pSWCS1BNkHt+Mw@coredump.intra.peff.net>
References: <793c8116-f7ea-eef2-6979-231c3e94639a@dulfer.be>
 <9c3428f6-a254-13b4-046d-6e20ef602aef@dulfer.be>
 <8d72f484-6a72-87f9-44f1-3a38471201db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d72f484-6a72-87f9-44f1-3a38471201db@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 02:33:49AM +0100, Andrei Rybak wrote:

> Indeed, the description of the option (which comes from
> Documentation/rev-list-options.txt) doesn't describe all differences
> between --date=default and --date=rfc2822.
> 
> A fuller list could be:
> 
>     * There is no comma after the day-of-week
>     * The time zone is omitted when the local time zone is used
>     * Day-of-month and month are switched around
>     * Time-of-day and the year are switched around
> 
> CC'ing Peff, who wrote the list of exceptions in add00ba2de (date: make
> "local" orthogonal to date format, 2015-09-03).

I don't think I had any particular reason to omit those other
differences. I probably just didn't notice them. Patches welcome.

-Peff
