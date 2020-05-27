Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9D9C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B1320873
	for <git@archiver.kernel.org>; Wed, 27 May 2020 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgE0Pwo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 May 2020 11:52:44 -0400
Received: from elephants.elehost.com ([216.66.27.132]:37592 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgE0Pwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 11:52:43 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 04RFqZA7005565
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 May 2020 11:52:35 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Dana Dahlstrom'" <dahlstrom@google.com>, <git@vger.kernel.org>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>        <20200521191626.GC1308489@coredump.intra.peff.net>        <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>        <20200523162914.GA2178752@coredump.intra.peff.net>        <ad267e83-eea0-bb78-d88c-a37a28d04dbe@web.de>        <xmqqimglqpga.fsf@gitster.c.googlers.com>        <20200527065210.GC4005121@coredump.intra.peff.net> <xmqqimghmlgk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimghmlgk.fsf@gitster.c.googlers.com>
Subject: RE: 'HEAD' is not a commit (according to git-checkout)
Date:   Wed, 27 May 2020 11:52:28 -0400
Message-ID: <022e01d6343e$d6c045b0$8440d110$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE7Hg29RQao7I/tGfVz6+2VcekzRgJZcAenAsE/0y4Ch+QuJgKQTr91Aob3W20CH/OlpgIT+JaLqWrSsGA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 27, 2020 11:44 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Sun, May 24, 2020 at 09:15:33AM -0700, Junio C Hamano wrote:
> >
> >> So, should we allow a random upstream & start-point combination?  It
> >> appears to me that as long as they share _some_ common ancestory, it
> >> may make sense.
> >
> > But wouldn't just about any two tips in a repository share some common
> > ancestry?
> 
> Yes, we are on the same page; the above was my round-about way to say
> that it does not look useful to restrict the allowed combination in order to
> give us some safety.

I have seen some strange ones, as part of migrating from other SCM solutions to git, where there were two completely unrelated histories - at least temporarily until stitched together towards the end of the migration. I don't think the assumption about common ancestry holds generally. I might have misunderstood, though.

Randall


