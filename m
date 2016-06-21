Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3991B1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 21:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbcFUV33 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 17:29:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751369AbcFUV32 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 17:29:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8987025853;
	Tue, 21 Jun 2016 17:22:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/WHhInRQzWmknQkNKHvE+VwMTiw=; b=a8hCPh
	tko8otPgzqma4+y828NMT4f37N5dfvX7lEAqJfziLe4OaPhE9A+cb1iwcottRqUG
	/ASvtRSYxHhtK1XcA9dKL1RAF3XpAu7vQaJt7wjXOpWhJ64IsyDX0bW2QGGh+g2S
	FWj3BhPdy2OeQLnG5zwjEBsmVNQ3SQ6Zd0u9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O1HPXUXDyLWmG3IjraVCx0yh1DdPN1uU
	0GlX1UqyQucKY2Vip/Cui3O0G/P8EXrox7lkZNB0AcVRIF5IuaNGj7Itq3DMCmAA
	NG7smvws4nBAYOUJ4lYKY2MgrpIHhzZ9+xGjL0gDxev+eY92Tow37klYN1rBG+bz
	5qdyqX4tBc0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81AD525852;
	Tue, 21 Jun 2016 17:22:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0669125851;
	Tue, 21 Jun 2016 17:22:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc:	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] object_id part 4
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
Date:	Tue, 21 Jun 2016 14:22:50 -0700
In-Reply-To: <20160618221407.1046188-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 18 Jun 2016 22:13:59 +0000")
Message-ID: <xmqqy45ynsnp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50517190-37F6-11E6-B24E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series is part 4 in a series of conversions to replace instances of
> unsigned char [20] with struct object_id.  Most of this series touches
> the merge-recursive code.

I've queued them in 'pu', but please read contrib/examples/README
;-) Tentatively, I used contrib/coccinelle instead, but something
even shorter (e.g. contrib/cocci) might be sufficient.

> Note that in the patches created with the semantic patches, the only manual
> change was the definition of the struct member.  Opinions on whether this is a
> viable technique for further work to ease both the creation and review of
> patches are of course welcomed.

Thanks.
