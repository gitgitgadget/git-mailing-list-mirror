Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8A01F859
	for <e@80x24.org>; Tue,  9 Aug 2016 15:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbcHIPnv (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 11:43:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752113AbcHIPnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 11:43:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7D0130DD2;
	Tue,  9 Aug 2016 11:43:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UCHbAv/g/b8J0Ij/pg2E8rwOULM=; b=ZwngWe
	+z9+OZ7R95/9hsvDqjPVYCD6jPBQ8Jyfh3axkR6oqgx7GKlO5TWsRel8cOT9YF+d
	MAlRQTCwoAd6EEe8klwR+ocr8IPRVXJooggFin6uv/XzTYQOaAPzo1477SkiOjbU
	Xtp9LNVZ46gQDdVDgnZ9J3/9Uhbz1MF1Dnt9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u+ZduhgmuRuN2dKiNwqwErFDy9YR4c3Z
	j2nH2lUyFuLW3C+IeS97hQbxfsvv/Z2AluvkogHT3e5IAuHaaonNikp3DlGVclvF
	hVREjd9w7hkueiKAFfmbfNz2utpr5O41sCph8khm3WZ7KOn6+RcxmBxnhygu/DFJ
	2lbzAwOUm7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABC5230DD1;
	Tue,  9 Aug 2016 11:43:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3747030DD0;
	Tue,  9 Aug 2016 11:43:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbf-VA3rg7U2JFgvoB84E=ZC4eUPYGEsCLFqY7QBSM3Mw@mail.gmail.com>
Date:	Tue, 09 Aug 2016 08:43:46 -0700
In-Reply-To: <CAGZ79kbf-VA3rg7U2JFgvoB84E=ZC4eUPYGEsCLFqY7QBSM3Mw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 8 Aug 2016 16:02:19 -0700")
Message-ID: <xmqqoa52c5hp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 101D1D0E-5E48-11E6-AF6D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Aug 8, 2016 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * sb/submodule-clone-rr (2016-08-06) 6 commits
>>  - clone: reference flag is used for submodules as well
>>  - submodule update: add super-reference flag
>>  - submodule--helper update-clone: allow multiple references
>>  - submodule--helper module-clone: allow multiple references
>>  - t7408: merge short tests, factor out testing method
>>  - t7408: modernize style
>>
>>  Waiting for review discussion to settle.
>>  cf. <20160806012318.17968-1-sbeller@google.com>
>
> I will reroll today with a totally different approach.

OK.
