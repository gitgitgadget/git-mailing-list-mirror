From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git beginner - Need help understanding
Date: Tue, 27 Dec 2011 11:50:14 -0800
Message-ID: <7vr4zp7q15.fsf@alter.siamese.dyndns.org>
References: <1324955537875-7129186.post@n2.nabble.com>
 <CA++fsGHPKhzfd7-KohOZ4WpYatx_-EW0bjq46zwswbu8TomHCg@mail.gmail.com>
 <1324969372444-7129429.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chirin <takonatto@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 27 20:50:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfd2V-0005gK-Tg
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 20:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753Ab1L0TuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 14:50:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab1L0TuR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 14:50:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A153C6C88;
	Tue, 27 Dec 2011 14:50:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0YxmjVHo30aauZzsCpFOyj5I7kY=; b=IRbgyA
	f98KgQZiiArCdwCwC9PcnnAqgLmoQY3m/G27YFa4YHkGAN2A+Z/B/rZUL0BvB2CJ
	qCFv0wxh9YGalrJGU23TV5C6xj9H5frOAkqarJrlm+Q5xl493EXMS9f6gqGnCGM4
	I9mVNg3TS/8QELPg1IRUCLir+2X5di/oUIJio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eCHegAObyuR03fCTMoYrnC58T28XUir0
	Lpkk9Oxal0o+93GQ/KD5qpbpmicRHiL83JAOEn3Z2N9UNndFW5BbNvDG6tN5BNMW
	OUBfoVguLOO6KzYsvjBOulSEvQ3jJzr8f2HFkbNOmoIfPjxQxvS9joJKtmAMKEuP
	8kur5+HkIFU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9724C6C87;
	Tue, 27 Dec 2011 14:50:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28A8F6C86; Tue, 27 Dec 2011
 14:50:16 -0500 (EST)
In-Reply-To: <1324969372444-7129429.post@n2.nabble.com> (chirin's message of
 "Mon, 26 Dec 2011 23:02:52 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF8981FA-30C3-11E1-A7D6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187725>

chirin <takonatto@gmail.com> writes:

> From what I understand, your scenario is exactly what I expect. Which is why
> when I asked around my colleagues, no one was able to explain why I'm having
> this issue.
>
> As per your scenario:
>
>     # A changes hello.txt
>
>     # Going into B (who has not done anything to hello.txt)
>     git pull --> merge conflict on hello.txt
>
>     git commit
>     git pull --> OK

This is quite different from what Dov showed as "the right way to
report". Dob's recipe begins from absolutely empty state and creates three
repositories involved with exact sequence and anybody can reproduce how it
is supposed to work (or break). It was written in such a way that you can
try to follow the sequence to see if you see a behaviour that is different
from Dob expects (in which case your machine, filesystem or the Git binary
you installed might be the culprit). Have you tried it?

Compared to that, your version above does not say anything about what the
state of A, B and the repository A and B interact with were in before the
problem started, so even if Dob wanted to help you by trying to reproduce
your situation, there is not enough information to do so.

>> In this sequence, which fulfills the scenario that you described,
>> there are no conflicts. So I suggest that you try to change the
>> command sequence to illustrate what you don't understand and ask
>> again.

Exactly.
