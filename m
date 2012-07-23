From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] i18n for git-am, git-rebase and git-merge
Date: Sun, 22 Jul 2012 21:36:51 -0700
Message-ID: <7v4nozozz0.fsf@alter.siamese.dyndns.org>
References: <cover.1342920089.git.worldhello.net@gmail.com>
 <7vmx2rr320.fsf@alter.siamese.dyndns.org>
 <CANYiYbFvk60NxfOTxq-xS8vt5t9xW8HLQrE_GuHGkC+u6vWfsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:37:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StAOx-000558-8B
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 06:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab2GWEgy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jul 2012 00:36:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab2GWEgy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2012 00:36:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3604557B;
	Mon, 23 Jul 2012 00:36:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R1eem6q67ngH
	YzMeHQSPABWz2yI=; b=qVpJMcunRuWjMgTnpQtzvLLy6gg96qEDrbLjdJj8ZVzr
	d0sbM/ZNrZIKvsflazlelIA7w/zyQD0cNfNUJXFjOHM0I6JjydyinL/fQClZnxu7
	VcQ8bP0JbUxu5QCm04nER1pH2CfvG9A9xFYRLjt6bL24STVfFD2NYJ9yPBYS8bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C0UaP0
	yYbiyXP58IJcqxk+xTc3KBbzG19eriLfX9uxSe+aQWAX4PMJyrE/xdr6sNaRP1Fp
	vI+uVqgvPiaVvhrXxMxhEGCeg61uHCMpv9KDYPr0D0L2Sbh0FhI+QKhn7urALY6p
	YtLHDOXyXAARDk0ysBMAY3RDyrsiGz+r4ktcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 910D1557A;
	Mon, 23 Jul 2012 00:36:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8C935579; Mon, 23 Jul 2012
 00:36:52 -0400 (EDT)
In-Reply-To: <CANYiYbFvk60NxfOTxq-xS8vt5t9xW8HLQrE_GuHGkC+u6vWfsw@mail.gmail.com> (Jiang
 Xin's message of "Mon, 23 Jul 2012 11:14:17 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 069C0FF2-D480-11E1-B546-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201895>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2012/7/23 Junio C Hamano <gitster@pobox.com>:
>> I do not understand why many of these have Stefano's S-o-b in them.
>> If you are relaying what Stefano originally wrote, then the author
>> (i.e. "From: ") and the first S-o-b would say Stefano, and your
>> S-o-b will follow it, but that is probably not the case.
>> I'll drop the S-o-b lines for now.
>
> It is because Stefano offers lots of help for correcting syntax error=
s
> and misspellings in the original commit logs. Should I use Reviewed-b=
y
> tag instead of S-o-b?

Yeah, I guessed that you meant reviewed-by.

> And in PATCH 3/7, there is a =C3=86var's S-o-b, it is because the wor=
karound
> comes from =C3=86var's idea.

This one I remember the previous round, so didn't have any problem.

>> By the way, is there any existing test that needs to gain GETTEXT_PO=
ISON
>> or test_i18ncmp with this change?
>
> I find one test case failed, and correct it in PATCH 3/7.

That test used i18ncmp already, so the update to expected string
would be sufficient.  I was worried if there were existing tests
that have been expecting that the output from am/rebase/merge would
not be i18n'ised and using "test_cmp expect actual" to compare their
output with expected result.
