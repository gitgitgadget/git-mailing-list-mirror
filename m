Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE3EC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1476108C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbhESKUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 06:20:55 -0400
Received: from coleridge.oriole.systems ([89.238.76.34]:42662 "EHLO
        coleridge.oriole.systems" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbhESKUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 06:20:55 -0400
Date:   Wed, 19 May 2021 12:19:33 +0200
From:   Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rev-parse: fix segfault with missing
 --path-format argument
Message-ID: <20210519101933.stqe4bnilu22rmgl@nabokov.fritz.box>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20210516120449.661636-1-wolf@oriole.systems>
 <20210517080243.10191-1-wolf@oriole.systems>
 <20210517080243.10191-2-wolf@oriole.systems>
 <YKImcgntKHryLLfv@coredump.intra.peff.net>
 <20210519095235.cydjlj2qoko6xm4v@nabokov.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519095235.cydjlj2qoko6xm4v@nabokov.fritz.box>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-19 11:52, Wolfgang Müller wrote:

> Short of fully migrating to the parse-options API, I do not see a
> perfect solution for this, especially since there are options that take
> optional arguments which are not delimited by equals. These seem to be
> sprinkled throughout and all error out if no argument is given.

Upon rereading this I noticed an error, I meant to say "especially since
there are options that *require* arguments which are not delimited by
equals.", like --default, --prefix, and --git-path for example.

-- 
Wolfgang
