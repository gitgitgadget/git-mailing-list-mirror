Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FB71F859
	for <e@80x24.org>; Mon, 15 Aug 2016 15:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbcHOPmx convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Mon, 15 Aug 2016 11:42:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752966AbcHOPmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 11:42:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3113C3450C;
	Mon, 15 Aug 2016 11:42:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HAVgTdI+KPIv
	gQ34WT7uigU350I=; b=nDMMW3hRAkWrEzN7uuu2uBWYKMoTlZEFnRRc0cNBALKB
	tztbsFw6GsI6ntvio4PYnIkLH0ZkkPAYVF/Vf+HX3bkSk7Y0a6Op8KJk25VlOt62
	7plkrxm9VvYFp6KYOrD/0B1hP40Q9KILyEAhKtoyfGu5c0JX8FNe9pZB0N3kDzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ShucuA
	CKpEgzwVVbKpN270oKXhBn2jWUDe+2+lwl3DpETotpKfSO7J/9Ojcyo8eKJuthQQ
	EJOXdTBztoWo8llIXLj51eyZeiY5LxJDh5U03yj8HA/o/I5eh3zvE8u4Tf9wCcTD
	LVfxSv0D46QJVzMSNl5GMoOGrVo6KCQHK6yL4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27F543450B;
	Mon, 15 Aug 2016 11:42:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A08D3450A;
	Mon, 15 Aug 2016 11:42:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.10.0-rc0
References: <xmqqfuq7j7cw.fsf@gitster.mtv.corp.google.com>
	<bb0e4f6b-a85a-550e-a971-2a9fabb2f87f@web.de>
Date:	Mon, 15 Aug 2016 08:42:48 -0700
In-Reply-To: <bb0e4f6b-a85a-550e-a971-2a9fabb2f87f@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 15 Aug 2016 15:59:03
 +0200")
Message-ID: <xmqqoa4uhwcn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC430568-62FE-11E6-90BB-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> On 15.08.16 00:47, Junio C Hamano wrote:
>> Torsten Bögershausen (1):
>>       convert: unify the "auto" handling of CRLF
>
> Should we mention this change in the release notes?
>
> The handling of "*.text = auto" was changed, and now
>
>     $ echo "* text=auto eol=crlf" >.gitattributes
>     has the same effect as
>     $ git config core.autocrlf true

Oh, definitely.  Thanks.
