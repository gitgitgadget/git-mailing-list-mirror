Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 926162021F
	for <e@80x24.org>; Tue,  2 Aug 2016 22:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbcHBWZj (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 18:25:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754032AbcHBWZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 18:25:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 73C2832367;
	Tue,  2 Aug 2016 18:25:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lzbDlWSkXwqBqHZNOYx7OA85PKs=; b=QdtXQ7
	TV1kK056AMVYQk1zEjZYFb1zNowtU4R0UTBq9pFEn+uKEmE+lkWd0zuEh/4BQu1G
	+qHO0cH9GHHtzeyp98c3Wk8Ho4wUfVrQpMAOAQ7oGZuV1phyCj0g5OZLnHtzEi8t
	N4wr0v0EVl/ZJ1IJ3sAdmjQZ7SsIJzNGH+3nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nbQ7FXHJY5uBKW40qPnvyRyFDz4WFn8u
	lKvtj4k2gzSee9rRdV+rhfnFYOf5kIGIuxicQB/jSgPq6fO0IMA0UqX/vNzLYP2/
	o3ziq9cx0jrwWh2kUZLhwott6ZAKW5PTP/VgoimVUcL0xCC2LWcibM2wDhfp9N7R
	SvB0IaDxTo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CF4732366;
	Tue,  2 Aug 2016 18:25:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E349C32364;
	Tue,  2 Aug 2016 18:25:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] submodule documentation: add options to the subcommand
References: <20160802182152.20637-1-sbeller@google.com>
	<xmqqtwf2c0aw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYChcixXtOc2HigHCY7S5bteO1QZau+4cqQYbxtHW3wDA@mail.gmail.com>
Date:	Tue, 02 Aug 2016 15:25:33 -0700
In-Reply-To: <CAGZ79kYChcixXtOc2HigHCY7S5bteO1QZau+4cqQYbxtHW3wDA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 2 Aug 2016 15:02:00 -0700")
Message-ID: <xmqqh9b2byg2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08887108-5900-11E6-8FA1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Aug 2, 2016 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> When reading up on a subcommand of `gi submodule`, it is convenient
>>
>> s/gi /git /;
>
> will fix.
>
> And in the neighboring thread you just pointed out you used to just correct
> spelling fixes like this. I think it really depends on the workflow of the
> contributor. As I do the interdiff of the next version of the series against
> your tree I'll be likely to notice such typos in the content, but not in
> commit messages.

"git tbdiff" is your friend ;-)
