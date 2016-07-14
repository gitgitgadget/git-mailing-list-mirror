Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4084C20196
	for <e@80x24.org>; Thu, 14 Jul 2016 16:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbcGNQd2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 12:33:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751293AbcGNQd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 12:33:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6C3E2A835;
	Thu, 14 Jul 2016 12:33:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M6TbQ386FMIVKKeMxk8zM08r708=; b=UOMESy
	L0wFVsnFaiJegvTCRI/YVbYGllk//gH4vytb8mhYwLJe8Cay752p2AZAPds5lfd6
	m39NKd9sEpLbBYlWHtkSJ2yepJYsN0peCyQewTg/bCnbwK4VyWTQ9WeTZqMZ2uLA
	9sfjXyaRRMP9vc6YBMY251ShRClGc8BQMgzOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gAAZhMtBqznZOMYnJ2K9kiu+nmHQ/QHR
	uyDJqoQUzibcABEeb/uaHztL1TBxfDT807ATkqk/rylNW38BeDS7y95gMJ9FH/Xi
	+lgLoRBd1qQ2PEqcgeRW+vFA4mof22GFMRF94yTpOZ5ayPSdvGRHDCuWkBpMjC0V
	/PwAAhKdlRo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD3DB2A833;
	Thu, 14 Jul 2016 12:33:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54B542A832;
	Thu, 14 Jul 2016 12:33:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/3] fsck: refactor how to describe objects
References: <cover.1468510191.git.johannes.schindelin@gmx.de>
	<75cd5de6b5a027a32d6ed6b922aa601226d464e5.1468510191.git.johannes.schindelin@gmx.de>
Date:	Thu, 14 Jul 2016 09:33:23 -0700
In-Reply-To: <75cd5de6b5a027a32d6ed6b922aa601226d464e5.1468510191.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 14 Jul 2016 17:30:19 +0200
	(CEST)")
Message-ID: <xmqqinw8rxgs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFDFD2F4-49E0-11E6-B8D2-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In many places, we refer to objects via their SHA-1s. Let's abstract
> that into a function.
>
> For the moment, it does nothing else than what we did previously: print
> out the 40-digit hex string. But that will change over the course of the
> next patches.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Makes sense.
