Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE01C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 05:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657E461056
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 05:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhJNFO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 01:14:57 -0400
Received: from defaultvalue.org ([45.33.119.55]:55980 "EHLO defaultvalue.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNFO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 01:14:57 -0400
Received: from trouble.defaultvalue.org (localhost [127.0.0.1])
        (Authenticated sender: rlb@defaultvalue.org)
        by defaultvalue.org (Postfix) with ESMTPSA id A9F752043B;
        Thu, 14 Oct 2021 00:12:52 -0500 (CDT)
Received: by trouble.defaultvalue.org (Postfix, from userid 1000)
        id 4A81F14E081; Thu, 14 Oct 2021 00:12:52 -0500 (CDT)
From:   Rob Browning <rlb@defaultvalue.org>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: explain and illustrate multi-line
 headers
In-Reply-To: <xmqqtuhlisqe.fsf_-_@gitster.g>
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
 <YWRpPw4eTwTmgVvC@coredump.intra.peff.net> <xmqq4k9ncopr.fsf@gitster.g>
 <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net> <xmqqzgre5glb.fsf@gitster.g>
 <xmqqtuhlisqe.fsf_-_@gitster.g>
Date:   Thu, 14 Oct 2021 00:12:52 -0500
Message-ID: <87zgrcgpez.fsf@trouble.defaultvalue.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A signature attached to a signed commit, and the contents of the
> commit that merged a signed tag, are both recorded as a value of an
> object header field as a multi-line value, and are subject to the
> formatting convention for multi-line values in the headers, with a
> leading SP signaling that the rest of the line is a continuation of
> the previous line.  Most notably, an empty line in such a multi-line
> value would result in a line with a sole SP on it.

One question I had was whether git's requirement was strictly a space,
or if it was following the rfc-822 convention where (if I remember
correctly) a tab is equivalent, i.e. the LWSP production in the grammar.

https://datatracker.ietf.org/doc/html/rfc822#section-3.2

Thanks
-- 
Rob Browning
rlb @defaultvalue.org and @debian.org
GPG as of 2011-07-10 E6A9 DA3C C9FD 1FF8 C676 D2C4 C0F0 39E9 ED1B 597A
GPG as of 2002-11-03 14DD 432F AE39 534D B592 F9A0 25C8 D377 8C7E 73A4
