From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Add basic Coccinelle transforms.
Date: Mon, 06 Jun 2016 19:54:12 -0700
Message-ID: <xmqqfuspu2sr.fsf@gitster.mtv.corp.google.com>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
	<xmqqk2i1u3zn.fsf@gitster.mtv.corp.google.com>
	<20160607023144.GA72717@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 04:54:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA79p-0003qE-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 04:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbcFGCyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 22:54:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750974AbcFGCyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 22:54:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89F50235D6;
	Mon,  6 Jun 2016 22:54:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F8UxxAiGOAcd+EpOqAhyai1Sigo=; b=Jy4UgZ
	rd4SmsrI3ZexSR+2hfvhO/xh2h25pvEf+hJhiDxMlFB7n6CPlkQdl6u3l9lSFeNj
	s4+TIo/Q6os2Gg6VLpMTyzPk85EzzVkS3St8K3fkVfx4dUYfq43Xi6M9g4JOF7o9
	Y5maBk8KcxoHr4U+C87NYYFZfMpgmk2czwwB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LRnXt/A2+9u5jNC9wV2UzRrACtNyvcfY
	nGhQnPRydstfOUreK7dJ7fWlwvHH2or59ixuB8d3WNVDU0kal6yhAUha/Gj7nA+6
	85D5h8pD3XBNOqI77l8nRDWgrk/+83bQEuedA4235APub4kp3WlNeNdQajkrDJRc
	KtydA1f1NuI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8297E235D5;
	Mon,  6 Jun 2016 22:54:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DD8E235D4;
	Mon,  6 Jun 2016 22:54:13 -0400 (EDT)
In-Reply-To: <20160607023144.GA72717@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 7 Jun 2016 02:31:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E239154-2C5B-11E6-898B-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296592>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> My goal here is simply to avoid needing to include this set of
> transformations in each commit message, which would tend to bloat it
> considerably.

Yeah, I understand that.  Philosophically this is similar to what we
traditionally keep in contrib/examples/, where it is not really part
of git-the-product but is still shipped to help git developers.

The resulting changes looked reasonably clean and thorough (the
latter is understandable as it is a tool's output ;-), and the input
language quite understandable.  This sounds like a fun process.

Thanks.
