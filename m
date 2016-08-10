Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712B01FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbcHJSOy (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:14:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933515AbcHJSOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:14:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADA5835664;
	Wed, 10 Aug 2016 12:55:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G9yBuJ8hDlQk8mq5xmUoQ9XL1eQ=; b=hUkXaJ
	yWtv1NLgqZDkhgaMHVNl/9B3cGYViTY5slsv+8ZT7cyUbTtdhLP4V2ZlWwIH5u9p
	dxolyy/kGHudBAUnni8Mal5QcR9xFitJwo5I90hsoAQD6mmTor6V7WDkBE05//cy
	g4GayyqprPyvmBsLss5YNUckoqXkODK8vixSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pcWZM4rZ1Z5P/gEmxPEXw0dRZAMknHOy
	agRjlvCDRy7A7MQVYhSrZhl0Z+ot6VeYJdCPP3uHVmXSDCyhcL/B/UX7J0iFMA0R
	YuzLz6wtGU2LYH75ITqm5LG1ChweWd0hzNLcOKgGrAk7R7FNY8Li6TUtRDz0AP9r
	TsaWZywlDDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5B8335663;
	Wed, 10 Aug 2016 12:55:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 268B035662;
	Wed, 10 Aug 2016 12:55:56 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>,
	git@vger.kernel.org
Subject: Re: [PATCH] Spelling fixes
References: <1470732818-408-1-git-send-email-ville.skytta@iki.fi>
	<xmqqpophajqa.fsf@gitster.mtv.corp.google.com>
	<f4f313a0-749d-4db2-3afc-9e93ea2ba130@kdbg.org>
Date:	Wed, 10 Aug 2016 09:55:54 -0700
In-Reply-To: <f4f313a0-749d-4db2-3afc-9e93ea2ba130@kdbg.org> (Johannes Sixt's
	message of "Wed, 10 Aug 2016 15:26:54 +0200")
Message-ID: <xmqq7fbo7ecl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E2D0982-5F1B-11E6-A1F9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 09.08.2016 um 20:19 schrieb Junio C Hamano:
>>     <BAD>                     <CORRECTED>
>> 
>>     accidently                accidentally
>>     commited                  committed
>>     dependancy                dependency
>>     emtpy                     empty
>>     existance                 existence
>>     explicitely               explicitly
>>     git-upload-achive         git-upload-archive
>>     hierachy                  hierarchy
>>     intial                    initial
>>     mulitple                  multiple
>>     non-existant              non-existent
>>     precendence.              precedence.
>>     priviledged               privileged
>>     programatically           programmatically
>>     psuedo-binary             pseudo-binary
>>     soemwhere                 somewhere
>>     successfull               successful
>>     unkown                    unknown
>>     usefull                   useful
>>     writting                  writing
>
> This reminds me of one occurrence of "indegee" in commit-slab.h that
> should be "indegree". The word is not in this list above, so I don't
> know whether you would like to have it fixed in the same patch or not...
>
> (BTW, is that word "in-degree" or "ingredient"?)

IIRC it is the former, to count "how many incoming arcs does this
node have?"

Will queue to squash in.  Thanks.

> -- Hannes
>
> diff --git a/commit-slab.h b/commit-slab.h
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -8,7 +8,7 @@
>   *
>   * After including this header file, using:
>   *
> - * define_commit_slab(indegee, int);
> + * define_commit_slab(indegree, int);
>   *
>   * will let you call the following functions:
>   *
