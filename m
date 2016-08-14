Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66F01FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 20:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbcHNU7E (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 16:59:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750845AbcHNU7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 16:59:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54FA133479;
	Sun, 14 Aug 2016 16:59:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iDSuhuCs271edhIj95mLD84zQPU=; b=C9+OXi
	wGCXgYzm8e82jDjokLUL1B2JCfC09XqBEXiynCr1HoeW8fLY30TfiCc1pjjRRZ+O
	9sSxk8/aI/GK/RSE5GdjzJJfD+7skOTrxqXQ+XFFqRMoF2c393Z31j+qTp/bF9z1
	a+DXO4Jn5cWDwYyXs/6Xml3ghg/zVFEO5XWis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OMk7i5qtX7+R+6LBVQbrCAc6sU+xQ9HX
	HEPofGXopzxE4FOt4rS0n+HkYYve4YbI18sR0bUZDyiyTcPXm7NhDoPl577mx3PN
	4LVIvUyvwa22/a+r7PgeopIxXodHpOBSb+6gI3sraLjomSqYB0Paq8xG6A6nZCQl
	sEt6ad847mA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C51433474;
	Sun, 14 Aug 2016 16:59:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC76C33473;
	Sun, 14 Aug 2016 16:58:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>, Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Draft of Git Rev News edition 18
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
Date:	Sun, 14 Aug 2016 13:58:57 -0700
In-Reply-To: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
	(Christian Couder's message of "Sun, 14 Aug 2016 19:15:00 +0200")
Message-ID: <xmqqeg5rkqy6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC6B3986-6261-11E6-AF51-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> You can also reply to this email.

I am not sure that is to be recommended, as that ends up going to
the list, but anyway, these

 - Michael's "finding better -/+ assignment in diff using indent
   heuristic"

 - Philip Oakley's updates to revision range notation documentation

 - Kevin Willford's rather clever optimization on internal patch-id
   computation that is done to exclude already-applied commit while
   rebasing

are interesting/noteworthy topics that may want to be covered in the
discussion/review section.
