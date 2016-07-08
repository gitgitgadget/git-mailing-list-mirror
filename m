Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE64F2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 21:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbcGHVjL (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 17:39:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751658AbcGHVjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 17:39:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAD2C2A126;
	Fri,  8 Jul 2016 17:39:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=628q63kTeKPaOjZtDEwna1f+pZE=; b=ZAoeNl
	zKtputohwB3Q1qBpZ16aEuJ+MQTQbzF5heVoNWsh7VV90l0FbIAzR3ilNuxIBIcW
	ZTnmRCL4TcD3zOesqSAdNK89B0QTMk5ExxCBp3UXdb42jiIJ1ieTx+ceBFVjMHPe
	0JNkoKNdq5R9QZ2Dyi6PbPygb6GCkVHH8UiFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E1hSyNF3hBcwQGoZV5zbfPMy3G6GXZq2
	I/9dtGfUfahjoKlfa5cVtMZqDKCTurSHYip82ZsHAKwMjWAcjT+ZZxx9uTsVVuxK
	he5+1Iyf2hCHSn1ulGTVRQNyNnJvzLkXvhhy9tt/fs8XeuUrOzXvS5U3kto7V9Nx
	YSBpvt1vlGs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB43D2A125;
	Fri,  8 Jul 2016 17:39:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6356F2A124;
	Fri,  8 Jul 2016 17:39:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] am: counteract gender bias
References: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
	<ceb80e45d1f02b71cc5ad2d7ded04360c530a9a8.1467962234.git.johannes.schindelin@gmx.de>
Date:	Fri, 08 Jul 2016 14:39:04 -0700
In-Reply-To: <ceb80e45d1f02b71cc5ad2d7ded04360c530a9a8.1467962234.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 8 Jul 2016 09:17:34 +0200
	(CEST)")
Message-ID: <xmqqfurjlshz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6585594E-4554-11E6-9226-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
> almost 11 years already, we used a male form to describe "the other
> tree".

This actually is older than that commit by 9 commits.  I may have
said it already, but it originates at 47f0b6d5 (Fall back to
three-way merge when applying a patch., 2005-10-06).

> While most likely unintended, this gave the erroneous impression as if
> the Git developers thought of users as male, and were unaware of the
> important role in software development played by female actors such as
> Ada Lovelace, Grace Hopper and Margaret Hamilton. In fact, the first
> professional software developers were all female.
>
> Let's change those unfortunate references to the gender neutral "their
> tree".

I'd add this at the end.

	Doing so would also make the fallback_merge_recursive(),
	which is an oddball, more in line with the other parts of
	the system where we contrast what we have vs what we obtain
	from others with "ours" vs "theirs".  This inconsistency was
	also unintended.

I do not think changing these references to "her" and keep them like
so for 11 years is a proper way to show "respect" anyway, by the
way, so this round is a definite improvement over that version.

Thanks.

