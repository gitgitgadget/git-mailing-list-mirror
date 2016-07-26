Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317A3203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 17:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233AbcGZRFo (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 13:05:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757012AbcGZRFn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2016 13:05:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB0762E971;
	Tue, 26 Jul 2016 13:05:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nLUkIvt9N8Lp
	GcYRy42F2ul/p3Q=; b=vGJwOvX8+712zHo9rzYSIgM7RyREAt8/fbMijZozQTXT
	ZtMN04LD0Y6HtvMZnJUAkDjfOI6N5IkEMdESjRvqiO0NQYi5exozzFFS02vJL7B1
	hfkoWGZbyC3RvZW9ObL8El5vNlDCYGYPiC4WJNQizf6f06VgjuWFRfZb05YJA44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=A1MAkz
	tJuPn5OwwXW15sv2qdGBzK9SlrZnNFjfA0E/Q/5EAGVzDtuGAHWsu7kX4A9UVi2X
	AI87zxJM2Dqg1GL/HGINMdjT6Vc5oqSkMlJUHRXmRrSUfEXR0ZtmD320YHPHjbWE
	QFSzC25DBxbbOyqe/Abr0pyrTwePXqckidex0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E39C02E96F;
	Tue, 26 Jul 2016 13:05:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 666612E96E;
	Tue, 26 Jul 2016 13:05:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	Git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] i18n: notes: mark comment for translation
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
	<xmqqr3ah621l.fsf@gitster.mtv.corp.google.com>
	<1469535363.1845.8.camel@sapo.pt>
Date:	Tue, 26 Jul 2016 10:05:39 -0700
In-Reply-To: <1469535363.1845.8.camel@sapo.pt> (Vasco Almeida's message of
	"Tue, 26 Jul 2016 12:16:03 +0000")
Message-ID: <xmqqvazs1g9o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2ED2526E-5353-11E6-813C-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> A Seg, 25-07-2016 às 10:49 -0700, Junio C Hamano escreveu:
>> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>> 
>> > 
>> >  static const char note_template[] =
>> > -	"\nWrite/edit the notes for the following object:\n";
>> > +	N_("Write/edit the notes for the following object:");
>> 
>> I do not quite understand why you want the blank lines surrounding
>> the message outside add_commented_lines() call.  I think the intent
>> is to produce
>> 
>>     #
>>     # Write/edit the notes for the following object:
>>     #
>
> Yes, this was my intention. The original does:
>
>     #
>     # Write/edit the notes for the following object:
>     ____

Ah, of course, I misspoke.  The original "\n<message>\n" requests
that an empty line that is commented, followed by a line with the
message that is also commented, is given at that point.  The last
commented blank was my mistake.

In any case, I do not understand why you want to exclude the LFs
from the message.  If a translation for a particular language is
very long and would not fit on a single line, the translator is
allowed to make the message much longer, i.e. the translated version
of the <message> part may contain one or more LFs (which is what the
add-commented-lines function was invented for).  I'd think having
LFs in the to-be-translated-original will serve as a good hint to
signal translators that is the case.

Thansk.

