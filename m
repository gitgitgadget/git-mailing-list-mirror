Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A88D2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 21:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbcGFVWX (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 17:22:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755731AbcGFVWX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 17:22:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7C4D2BB89;
	Wed,  6 Jul 2016 17:22:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6AxXUNs1aG39GL28OdeAEJ1b1f8=; b=Yi87/M
	LYNQrbYw1heAzASfRUBc3YFMF+XJIg3z4rG5k4L/egrMcQw2fxgEGwGOXKO9LDwG
	kPb5xLnoFgXvZdWy1FRHYN0cmk07633VJHlPtVaOUltqJTF09l1eBZE4Hqfn3CRJ
	+vbab9BY07k2oZcQyEoJQkCSJE3GzGMJDErKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u//JqCj9HAKYQDxDNqhXQg+2EB51Naz8
	RjA3BDSFuHCx4uZWuXWy2pRYgwjhzu3UPBpQLPoJnLdWxRA3LHIreK2pNaF5/lcS
	sb88V+onkwlGIj6xtQshDpYpIW4aZx1ksF7meE2RGR6CThJn43h63ARlG5zTGVGq
	lXtQimsekzg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AEABC2BB88;
	Wed,  6 Jul 2016 17:22:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6E7D2BB86;
	Wed,  6 Jul 2016 17:22:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/17] am: counteract gender bias
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<cover.1467717729.git.johannes.schindelin@gmx.de>
	<ea23faf258b6e62e770879362869f49eea4db869.1467717730.git.johannes.schindelin@gmx.de>
Date:	Wed, 06 Jul 2016 14:22:18 -0700
In-Reply-To: <ea23faf258b6e62e770879362869f49eea4db869.1467717730.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 5 Jul 2016 13:23:57 +0200
	(CEST)")
Message-ID: <xmqq1t36sbqt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B97E1C02-43BF-11E6-84CB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
> almost 11 years already,...
> ...Let's start changing that by using the variable name "her_tree" for an
> equal number of years out of fairness, and change to the gender neutral
> "their_tree" after that.

I doubt this kind fo distraction is desirable in the middle of a
seriously heavy series like this one.  As a standalone clean-up to
turn these directly to "their" that everybody would agree on and can
be merged down quickly to 'master' that does not have to keep the
body of the main topic waiting for the dust to settle might be a
better approach.

Unless you are trying to discourage the reviewers, that is ;-).
