Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F9C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 23:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349252AbhLCACK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 19:02:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:42536 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235895AbhLCACJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 19:02:09 -0500
Received: (qmail 21423 invoked by uid 109); 2 Dec 2021 23:58:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Dec 2021 23:58:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26039 invoked by uid 111); 2 Dec 2021 23:58:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Dec 2021 18:58:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Dec 2021 18:58:45 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2] CodingGuidelines: document which output goes to
 stdout vs. stderr
Message-ID: <YaldtR9udlozfx9Z@coredump.intra.peff.net>
References: <20211201053214.2902-1-sunshine@sunshineco.com>
 <20211202223110.22062-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202223110.22062-1-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 02, 2021 at 05:31:10PM -0500, Eric Sunshine wrote:

> It has long been practice on this project for a command to emit its
> primary output to stdout so that it can be captured to a file or sent
> down a pipe, and to emit "chatty" messages (such as those reporting
> progress) to stderr so that they don't interfere with the primary
> output. However, this practice is not necessarily universal; another
> common practice is to send only error messages to stderr, and all other
> messages to stdout. Therefore, help newcomers out by documenting how
> stdout and stderr are used on this project.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> 
> Changes since v1[*]:
> 
> * tone down the commit message (peff)

:) This looks great to me. Thanks for doing it.

-Peff
