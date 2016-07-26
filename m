Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E794D203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 21:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbcGZVT5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:19:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161029AbcGZVT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:19:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD7332FEEC;
	Tue, 26 Jul 2016 17:19:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ryhq52ZYTW3HWE5nuHST8XLd/+A=; b=kNpfxg
	ctBPmoj+8cMxQy3nLuIO9LOlAOhBjXrFJLUvrqle64U9pnp4K0Rc2yvtIOfLt63m
	PTtaWPXX/XLEFJZ1AQe5P3krdqyR1IjoXjwc2/b5gzhZG5yjNWHco+jhx955mytd
	mVcPozTYV921cbD0OZobC6oXUrnuYbeu9/cds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r+x71Whfbu62hyG4VylCjiPJIhNIXWS9
	K7ZX2FoprgK3KrWzfcUoiLcRYr7dS/v/PaMKtOrj/B1F+y6en1tv9MJyuWMQedBA
	e+MqobVRpYsG1ZoO3rC4VxwMGULHBN1uLTyVw1KaO7AVbfKVcYXyLaQduv8VVf9z
	4MBJ1t14bcw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B29E62FEEB;
	Tue, 26 Jul 2016 17:19:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FC852FEEA;
	Tue, 26 Jul 2016 17:19:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] push: add shorthand for --force-with-lease branch creation
References: <cover.1469483499.git.john@keeping.me.uk>
	<4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
	<xmqqpoq12w93.fsf@gitster.mtv.corp.google.com>
	<20160726080309.pr46bbtzdvnr7fd3@john.keeping.me.uk>
	<xmqqwpk8yxvb.fsf@gitster.mtv.corp.google.com>
	<20160726204253.ciumvungwfwaw6el@john.keeping.me.uk>
Date:	Tue, 26 Jul 2016 14:19:52 -0700
In-Reply-To: <20160726204253.ciumvungwfwaw6el@john.keeping.me.uk> (John
	Keeping's message of "Tue, 26 Jul 2016 21:42:53 +0100")
Message-ID: <xmqqvazsxfk7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B22F4388-5376-11E6-B90C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

> Thanks.  I'm about to send v3 anyway to pull a test forward to address
> Jakub's comment.  I also used oidclr() for the last two changes below.

Will replace with v3.

I think v3 is ready to advance to 'next'.  Let's see if we get
further comments from others for a few days.

Thanks.
