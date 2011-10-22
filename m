From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/5] pretty: %G[?GS] placeholders
Date: Sat, 22 Oct 2011 10:55:21 -0700
Message-ID: <7vsjmk6hdi.fsf@alter.siamese.dyndns.org>
References: <1318983645-18897-1-git-send-email-gitster@pobox.com>
 <1319071023-31919-1-git-send-email-gitster@pobox.com>
 <7v7h3x7h6j.fsf_-_@alter.siamese.dyndns.org>
 <CA+EOSB=EowzV5B9jjq9D9rshPt8LmO9K_GbwNWo_x3Uv9+kwxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 20:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHfvk-0005ZC-AP
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 20:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab1JVRzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 13:55:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab1JVRzY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 13:55:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3514555;
	Sat, 22 Oct 2011 13:55:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bcFBB8T6l3YBY1dFU3qalKa42uo=; b=WImDcl
	k71JyStJvoh2F4QKlQ4cR4ShKH0m214XmkMIaDANLoL2XXLjh9Sf41bZPZ8NKxxg
	sWn9s5e6jUUlcXM1Jv+PEJ3GZ0f9uHdeM3dLkfpEPlLRBMM9wQc/mx/vN2KgFsgs
	OxCwsMQFRMkw9l1ogVG6wMDNi7sNBSrJY7+p0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M/yGEQFrCFOPyEZhZrRXL0krB+D6xbol
	rMl8Z6TH6UaVawnOR1f2xOBdlDZ6ABFYpMwq/mg9oIT3yFA1o8Bba7vtp2UL0Yzw
	qSDhhuCx7KwZH1njWYxE3PpOO55gBeMO1U6rEfr6pkioVQbYI1pJy5UlrLjNQ2Zq
	/DYXbIaTzUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F3B4554;
	Sat, 22 Oct 2011 13:55:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E8444552; Sat, 22 Oct 2011
 13:55:22 -0400 (EDT)
In-Reply-To: <CA+EOSB=EowzV5B9jjq9D9rshPt8LmO9K_GbwNWo_x3Uv9+kwxg@mail.gmail.com> (Elia
 Pinto's message of "Sat, 22 Oct 2011 12:47:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03569A8C-FCD7-11E0-B544-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184108>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Can you suggest what do you think can be useful placeholders ? Thanks.

That is a weird question.

> 2011/10/22, Junio C Hamano <gitster@pobox.com>:
>> Add new placeholders related to the GPG signature on signed commits.
>>
>>  - %GG to show the raw verification message from GPG;
>>  - %G? to show either "G" for Good, "B" for Bad;
>>  - %GS to show the name of the signer.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  * The 6th is the one that works with a bogus commit with NUL in it I sent
>>    out previously.
>>
>>    This concludes the series; I'll leave the design and implementation of
>>    other useful placeholders to the list for now.

I can think of random other placeholders off the top of my head purely by
speculation without having real need [*1*], but they won't be much useful.

People on the list who *want* to use this feature in their projects may
have specific needs and they would be closer to what is needed in the real
world use cases than what comes out of thin air by imagination.

That is the reason why I left the enhancement to the list.

If you have to ask that question because you do not have any specific need
yourself, and especially if you have to ask it to *me*, then you should
wait for others to come up with their real needs, just like what I am
doing right now ;-).


[Footnote]

*1*

 - %GC that is replaced with COLOR_GREEN when Good signature is found,
   COLOR_RED when BAD signature is found, and COLOR_RESET when there is no
   signature;

 - %GD for the date the signature was made on (with date format variants);

 - %Gk for the type of the key and the Key-ID.
 
