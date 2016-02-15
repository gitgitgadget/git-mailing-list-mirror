From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2016, #04; Fri, 12)
Date: Mon, 15 Feb 2016 13:26:45 -0800
Message-ID: <xmqq8u2lr7fu.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuwxtrni.fsf@gitster.mtv.corp.google.com>
	<56C07182.1040804@web.de>
	<xmqqy4amr2z4.fsf@gitster.mtv.corp.google.com> <56C20E8C.30708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:26:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQfV-0005ZG-6e
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbcBOV0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 16:26:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751221AbcBOV0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 16:26:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D0AA45C83;
	Mon, 15 Feb 2016 16:26:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RYsLfvPfxIi1
	ZTlWWoSltyzIiCk=; b=DPOj5dGMqxqld53BRfqv+brRI6zCy2f7jJ9qJY7BwDfh
	gBCnHyGNvbNdEuh2KLyX1jdJtg43fH4CJntbEkpXC0ToD93Jgp8i+DNBhrZzDAgA
	LO6bAohlwC2kuG0CUwykzaSUd2WYxoMfR2OsezUzCJJR10CqlQoAlfquI/hI8uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K497yy
	mxEBGt1NZ+sw1KswNZloBTU8ixS0hJJDnoABQW012Scq9t+LzC+uhSkrAjTMkSp2
	LJ2gSSE1xb4ukrAZq92bYjIzYPysPZdJIFJqdJLAgs26t7Xf4s+u/RmzOs/RnxHD
	vyUKLFKMuh7t8aB+F8aErgf1KhxrHYhTjcrMI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 740EE45C82;
	Mon, 15 Feb 2016 16:26:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E8D5D45C81;
	Mon, 15 Feb 2016 16:26:46 -0500 (EST)
In-Reply-To: <56C20E8C.30708@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Mon, 15 Feb 2016 18:44:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D149D24A-D42A-11E5-B796-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286242>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 15/02/16 05:50, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>>> * tb/conversion (2016-02-10) 6 commits
>>>>    (merged to 'next' on 2016-02-12 at 6faf27b)
>>> Could we keep it in next for a while ?
>>>
>>> I found issues that needs to be fixed before going to master,
>>> updates follow soonish.
>> Hmph, I somehow thought that everything was a no-op clean-up.  Any
>> regressions I failed to spot?
> The "text" attribute was reported incorrectly in ls-files --eol.

Interesting. I vaguely recall that I said something about the change
in the semantics for the reporting during the review...

> A preleminary fix is here:
> <https://github.com/tboegi/git/commit/3a5f50005c0cfa16d2aaa6c602b6105=
b611a8ed5>
> A proper fix will come next week.

Thanks.
