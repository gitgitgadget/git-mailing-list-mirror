Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EAB8203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 19:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbcG0Tdg (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 15:33:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753189AbcG0Tdf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 15:33:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E122FCEA;
	Wed, 27 Jul 2016 15:33:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4q3d7bu9sndz
	/xjY53mVfX2gM7c=; b=WxbDz4XiiBRm07g14n1A0cTXyClS2DRZIAc4CNdNrGkT
	piaJzLIvu0xWVfKbd/YUrIRXDUJWN+8TGZu548UX1Rm4Lns3VC8CMY5VSB+8Q4vd
	J5v/tbFao/LTGvTM0as7N54H6H7qFkcM37ygQQIJSo60qZMyt73z5ehqAFop3Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dQJq4C
	1w7g+jDvfn6TWEP9PEwBrO8XG4e1tcgh6HHqwJfbi6fEjBPdM3ZbMkvfF+C+lwNy
	lEl92zD7oIpphwnT5s3iy/hP1TwSaevab+WmBN05tWY2fyKgepIPaKdKl1vYMo4L
	KEoX2cZi9hJRSkxrAMSCoqgUt2y1me3qHb9lI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CE8E2FCE9;
	Wed, 27 Jul 2016 15:33:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D1082FCE7;
	Wed, 27 Jul 2016 15:33:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] i18n: notes: mark comment for translation
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
	<1469535400-9242-1-git-send-email-vascomalmeida@sapo.pt>
	<xmqqzip41gn5.fsf@gitster.mtv.corp.google.com>
	<1469616819.1858.25.camel@sapo.pt>
Date:	Wed, 27 Jul 2016 12:33:31 -0700
In-Reply-To: <1469616819.1858.25.camel@sapo.pt> (Vasco Almeida's message of
	"Wed, 27 Jul 2016 10:53:39 +0000")
Message-ID: <xmqq7fc6x4dw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 017DFBEA-5431-11E6-87EE-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> A Ter, 26-07-2016 às 09:57 -0700, Junio C Hamano escreveu:
>> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>> 
>> > 
>> > +		strbuf_add_commented_lines(&buf, "\n",
>> > strlen("\n"));
>> > +		strbuf_add_commented_lines(&buf, _(note_template),
>> > strlen(_(note_template)));
>> > +		strbuf_add_commented_lines(&buf, "\n",
>> > strlen("\n"));
>> 
>> Hmm, do we really need to make three separate calls?
>
> This patch does (1)
>
> #
> # Write/edit the notes for the following object:
> #
>
> The original source does (2)
>
> #
> # Write/edit the notes for the following object:
>
> How do we want, (1) or (2) ?

As I said earlier I was misreading the original one.

The input to strbuf_add_commented_lines() actually is a string that
uses LF as a record terminator and asks the function to output each
record on its own line prefixed with either "#" or "# ", so I should
have considered the last LF as part of the second line.

In other words, the output should be as if you just did

-	"\nWrite/edit the notes for the following object:\n";
+	N_("\nWrite/edit the notes for the following object:\n");

in your patch, i.e. (2).

Thanks.
