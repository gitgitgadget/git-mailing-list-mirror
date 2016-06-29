Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F34F20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbcF2V22 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:28:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751900AbcF2V2Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2016 17:28:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 01BED28D6B;
	Wed, 29 Jun 2016 17:28:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1KCnTYDGs8A7
	SaFjZ5GYk8+wae8=; b=Rn91I2ZvRq7HO9ZnJopDs1290wsVcVeriB6Y7y9E69kb
	EHKSDsXz4f0qyrMCIeG2L4CIj3t0xTRNyA/z0sn2s+1G8wRtBofs7dzYTgLB8MDB
	9ffJmYQVkWBvgM9Wp7AfMOAAnyZIh3Equ3Fhh0GtHtVKBQMoCeJZzInDkLpLtrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B0gF0c
	VshHmfXq8kdfee4yzY1wPbeUGqsYvWWhCwwgZ6p4GxxBU7FUFQPC2XZmbaDeC1mQ
	fZFp1n9+Gfu1HPDZDs0DqNgM16WTeY/UrcwL+evc4kdU039odA3DE/ovCp/yUus2
	sPzZRTsi/JVRAE9tNyRf01jlkQGflYYohAu1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB1FE28D6A;
	Wed, 29 Jun 2016 17:28:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5815928D69;
	Wed, 29 Jun 2016 17:28:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFD] Place to document magic pathspecs like ":/" and pathspec handling
References: <577425EF.6030900@gmail.com>
	<CAPc5daVqjhWrJjNX6monHdMTRwimbjz==j9B2FS-nXNCqPDCYQ@mail.gmail.com>
	<57743BFB.9040709@gmail.com>
Date:	Wed, 29 Jun 2016 14:28:21 -0700
In-Reply-To: <57743BFB.9040709@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Wed,
	29 Jun 2016 23:22:03 +0200")
Message-ID: <xmqqy45n1y8a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 68843C16-3E40-11E6-952E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> But I think it is not the best place to keep this documentation.

All true.  In case it was not obvious, I didn't mean to say "Here
you find the information, shut up."  It was "here is a pointer if
you didn't find it, so that you can use it as a starting point to
make a better documentation."

An analogous entity in the world model of Git that appears
everywhere and is not limited to a single command is the revision
set calculus.  Where do we describe it and how do we make it
discoverable?  Can the new way to describe pathspec and pathspec
magic mimic the way it is done for the revisions?
