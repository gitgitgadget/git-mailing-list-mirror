From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Documentation/git-show.txt: include common diff options, like git-log.txt
Date: Mon, 15 Jul 2013 08:06:37 -0700
Message-ID: <7v1u6zeubm.fsf@alter.siamese.dyndns.org>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
	<1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
	<1373893639-13413-4-git-send-email-Matthieu.Moy@imag.fr>
	<7va9lneuw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stefanbeller@googlemail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:06:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UykMP-0005rd-VV
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090Ab3GOPGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:06:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757764Ab3GOPGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:06:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E565630E6E;
	Mon, 15 Jul 2013 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iLXaKNKrzWAmlid4FsdKkm7PPds=; b=NpGJDk
	x7gSxFvt9iDLZcxUxtv170LA7LkVO2TnsjjxmgN4hb3KereaYsw67T7hAKoVXEeF
	41ZPnlwyPHaNJ+1AL8GKwx/a903vqxwftk593cAyv4WesGM7CMFHhXrrpDE4ZeOc
	4Y1ieI32uwDML+9etrkacoW12CwftsEIzy1sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YCnEr13ac3lJ64Moqr9bp0M890oJDJy0
	IuaojdTcqpM//DB/oR1jGHt3+z4FLYpFI50U7+cA8dchhbpmPsqnMK5h4/+69KFu
	ok98lmJuWp6HtxJdsFTK5Pd82bUbNYifIXLduIJTkLAZ3WrOyO4TfoAVOPtke+YT
	vhLIdGP+7t4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2AF30E6D;
	Mon, 15 Jul 2013 15:06:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ACA930E64;
	Mon, 15 Jul 2013 15:06:38 +0000 (UTC)
In-Reply-To: <7va9lneuw5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 15 Jul 2013 07:54:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2658E3AC-ED60-11E2-BF38-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230475>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  Documentation/git-show.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
>> index ae4edcc..4e617e6 100644
>> --- a/Documentation/git-show.txt
>> +++ b/Documentation/git-show.txt
>> @@ -45,6 +45,15 @@ include::pretty-options.txt[]
>>  include::pretty-formats.txt[]
>>  
>>  
>> +COMMON DIFF OPTIONS
>> +-------------------
>> +
>> +:git-log: 1
>> +include::diff-options.txt[]
>> +
>> +include::diff-generate-patch.txt[]
>> +
>> +
>>  EXAMPLES
>>  --------
>
> This is a good start; the output should match what you would get for
> git-log(1) with the above.
>
> But we would need to say, unlike "log" whose default is not to show
> any patch, "show" that works on a commit defaults to "--cc"
> somewhere.
>
> Other than that the whole series looks sensible to me.  Thanks.

Actually, we say "log message and textual diff" with "merge commit
... diff-tree --cc", so please scratch the above comment (I think we
should however stop saying "in a special format" there---when the
combined diff was invented, the format may have been novelty, but it
no longer is).
