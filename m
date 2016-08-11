Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560D720193
	for <e@80x24.org>; Thu, 11 Aug 2016 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbcHKRyp (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 13:54:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751490AbcHKRyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 13:54:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B999832676;
	Thu, 11 Aug 2016 13:54:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FNZAqzkEq+MMAYi/+SfS/A1MNcg=; b=wFCqrn
	AZQd/PQ9Fn5Ev3tAFZvhXYpjlIL+ouJxoNuJD1PcTBlOPyt0cLSBWAqAtxoMrEhR
	1sgWTmmCjG5EzOL97LC6lsaiBQC07Ruk4ZqvPhF1V9Ryt8uv1rNRy/egTYQmBE3J
	EUx/ftJ4mL41VsNsFBJbrny5HF5nbV4BrQKvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WjaMgonkdENJ5AdxnX3DjbTOX0nGe6sM
	MTcxtKIyK1Xpi3ZHVs4ZChxmBiY78SHoYuwwM8JyAqQOmdYnZabP8Ltk9lqVmqWn
	je+0ols8DmjsgOpziIo6SC+33zPqYfbDRKcg79RGAVRrJNNoW+8Q6DvvtU8NyQKh
	/5+G448uRk4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B252132675;
	Thu, 11 Aug 2016 13:54:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28C6032674;
	Thu, 11 Aug 2016 13:54:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jonas Fonseca <jonas.fonseca@gmail.com>
Cc:	Git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] tig-2.2
References: <CAFuPQ1+i6BFRH=6HUWzDgM7J+hL_3hUNv5-4mjjGm=h-YWVuzg@mail.gmail.com>
Date:	Thu, 11 Aug 2016 10:54:39 -0700
In-Reply-To: <CAFuPQ1+i6BFRH=6HUWzDgM7J+hL_3hUNv5-4mjjGm=h-YWVuzg@mail.gmail.com>
	(Jonas Fonseca's message of "Wed, 10 Aug 2016 23:23:56 -0400")
Message-ID: <xmqq8tw32nts.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE408034-5FEC-11E6-8D72-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonas Fonseca <jonas.fonseca@gmail.com> writes:

> I've just released the 35th release of Tig. It brings several search
> improvements such as highlighting and wrap around, and machinery for future
> support of typeahead search. This release also gives more choice over how the
> user configuration file is loaded either at built-time or at runtime through
> support of the XDG basedir spec. Among fixes several segfaults and invalid
> reads have been addressed and the tests are now run with Valgrind and
> AddressSanitizer by Travis on each push. There are several breaking changes so
> ensure you read the section on incompatibilities in the release notes before
> upgrading.

Nice.  Thanks for your continued effort on this little Gem.
