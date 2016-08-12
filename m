Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED45C1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 21:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbcHLV1m (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 17:27:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752359AbcHLV1m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 17:27:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B53C83354D;
	Fri, 12 Aug 2016 17:27:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tRBwhdLOrcWFAkmHHtuxHk9AsDY=; b=oJWZ/s
	uVLimd4fnNr3PC7t7yMcgNEhvwXh+RAIVevzhivDSvPRorxAaB2B5ihZF378v/+G
	mVZ3JkmrFRp1pgAE1LYStpfX+qPdPvQXPpBjG3QOHlBQ4Vd7J3PxnhI6Rp3+PgOr
	a9thKsevKuabQoc4RX7WZfmPPHSUVXoHToiss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pe1utnyYHwzmKGRJuWdF9V9ZyK/ISR2Y
	+je/NUdo4qgjZLJ6+4c1TI0xaC6POBvGvmYYBMF5jCYzLS6+K4uO3aBnl7QRADFb
	pbNoqtVZWHpd5THranHquJzDedtak9rFZ58ppw0gR941BgJCwn1mR0RkOFbwx5gK
	rywUW3fDFNg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC3EA3354C;
	Fri, 12 Aug 2016 17:27:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23FBC3354B;
	Fri, 12 Aug 2016 17:27:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"GitList" <git@vger.kernel.org>,
	"Marc Branchaud" <marcnarc@xiplink.com>
Subject: Re: [PATCH v5 00/12] Update git revisions
References: <20160720211007.5520-1-philipoakley@iee.org>
	<20160812070749.2920-1-philipoakley@iee.org>
	<58d0df88-4902-4519-df21-3ba3d86a19c9@xiplink.com>
	<30B1A2CFFF9A4544A8F03800FA5968BD@PhilipOakley>
Date:	Fri, 12 Aug 2016 14:27:38 -0700
In-Reply-To: <30B1A2CFFF9A4544A8F03800FA5968BD@PhilipOakley> (Philip Oakley's
	message of "Fri, 12 Aug 2016 20:20:16 +0100")
Message-ID: <xmqqoa4xvfsl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98EF5150-60D3-11E6-8105-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> I'll work on the tweaks, though it'll probably be tomorrow as we have
> visitors.

Thank you for working on this; Marc, thank you for many good review
comments.
