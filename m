From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Mon, 27 Aug 2012 18:27:44 -0700
Message-ID: <7vehmrpzzj.fsf@alter.siamese.dyndns.org>
References: <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com> <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com> <7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com> <d20c47e9618f998b84934c0310f3de51d791e83f.1346045253.git.worldhello.net@gmail.com> <a2e20a1e1ae4be42b763904177cf634a6e291f15.1346045253.git.worldhello.net@gmail.com> <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com> <f56c058cfd76d02ed42b0c5b7161bde6bd51ddd0.1346045253.git.worldhello.net@gmail.com> <7v4nnoti3l.fsf@alter.siamese.dyndns.org> <CANYiYbGudJ56j=o5SDJur2dv2=icCe2FYad88dV_5tBzLAbZnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 03:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Aaw-0005oQ-B8
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 03:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952Ab2H1B1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 21:27:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894Ab2H1B1r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 21:27:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C82593F2;
	Mon, 27 Aug 2012 21:27:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4+cxv87geMy0iBuBm7+YDGfXSbQ=; b=Q58qLd
	bvKgW9kbbQLKC7Hg8do6UvG4sA4c2ISsKbuUjKl0umhpbAAYG9Kr3t8MMaEwEzAQ
	NBdedEzjdGAUjXSoIy2VNszBmMIERrqLYC+pO6lKGGZwAvL0Y4r98tWWo9280kb+
	cRu3HHFVCMXaUFGZLi02P5Nyd3dGup5S26FgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V6KwbglazEDietRV1gbkFZjqJNBFBcqU
	a8KhrN8bRjsY4yhpfbx5IH0/q8XO4m6ruOExc0g2L/0+xeOI2GmBEO8gRhile8Uf
	6oaQ5u93XSmnA77EHKBTYa20AatppOjgvkBYjdH0DC7qBVDCjnbu7MS91Xad5ZpN
	LSLqgZQl/NU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C6193F1;
	Mon, 27 Aug 2012 21:27:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 856C393EF; Mon, 27 Aug 2012
 21:27:46 -0400 (EDT)
In-Reply-To: <CANYiYbGudJ56j=o5SDJur2dv2=icCe2FYad88dV_5tBzLAbZnA@mail.gmail.com> (Jiang
 Xin's message of "Tue, 28 Aug 2012 05:25:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 927EA278-F0AF-11E1-9111-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204395>

Jiang Xin <worldhello.net@gmail.com> writes:

>> This couldn't have possibly passed with the trailing &&, or am I
>> missing something?  There is already "add another remote" before
>> this test that adds "second" remote.  Is this test about "add
>> yet another remote", or is it checking the result of adding "second"
>> that was done in the previous step?
>
> The trailing "&&“ is a copy & paste error. I only run my fixup in
> GIT_GETTEXT_POISON mode in a harry, not noticed the bypassed
> testcase has this serious bug.
>
> I split the original "add another remote" into two blocks. One is a
> normal testcase, and another has a C_LOCALE_OUTPUT prereq
> flag. This is because other testcases depend on the operations in
> "add another remote" testcase ('git remote add -f second ../two'),
> and these testcases would fail if add C_LOCALE_OUTPUT
> prereq to the whole "add another remote" testcase.

OK, so in short, I think the fix-up I made while queuing (and the
typofix in the commit log message for the other one) this round to
'pu' should match what you wanted to do.  If you want to make
further changes, I wouldn't mind re-queuing an update, but otherwise
there is no need to resend this series (and it will be less work for
me ;-).

Thanks.
