From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Thu, 08 Mar 2012 11:18:53 -0800
Message-ID: <7v1up2ew9u.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <4F57D18B.5090506@lsrfire.ath.cx> <7vzkbskr71.fsf@alter.siamese.dyndns.org>
 <4F58F06A.1070108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ird-0005kY-7M
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758235Ab2CHTS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 14:18:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757553Ab2CHTSz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 14:18:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D87870E6;
	Thu,  8 Mar 2012 14:18:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uq1TIMeO1gG3
	dN+Com/Kdwipmxo=; b=o1K6j9cRwQrLMuCS8Esn9/rRxxe7mXcneAXIQJzB4YeD
	vD0hQ9MCZCuXsSqOHuuGZcL2tW1kNlhTRX7aJ+zOTtGnwLBLDwib34OQjM3lQPfW
	ppIf35X4G3ulyenOE2fBENvgyugs8/wLeN/wBVAtc8f4p2UOyhvnKqT5sZ/dV8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SnwJlE
	L7cBvEtDRp6vZIE426AZTpqZTsJewB9is8oTMiKcP4lP0rIFaRHI6Iul4I/M+1T1
	JXq2rbg7U+xwxYsNv1y9FIywO5PsYRny2bfU5HFCMr/pxcMnwmDGoeC1f6/pLduW
	okALe/jgVsERLMm5TQjAA1wloDkFRVaS5cEmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34E2B70E5;
	Thu,  8 Mar 2012 14:18:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B840F70E4; Thu,  8 Mar 2012
 14:18:54 -0500 (EST)
In-Reply-To: <4F58F06A.1070108@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu, 08 Mar 2012 18:46:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BDEA3A2-6953-11E1-B37F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192634>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 07.03.2012 22:59, schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>>
>>> Am 05.03.2012 22:34, schrieb Junio C Hamano:
>>>
>>>> +#define util_as_int(elem) ((intptr_t)((elem)->util))
>>>
>>> Something that actually returns an int would fit the name better. ;=
)
>>
>> The particular type would not matter to the callers of the helper
>> macro, would it?
>
> Three of the five callers introduced in that commit cast the result t=
o
> int and the remaining two don't care, so it actually does seem to
> matter for most of them, strictly speaking.  When I see a nit, I can'=
t
> resist the urge to pick it, apparently.

Unfortunately, replacing intptr_t with int or casting the above
again as int will result in

builtin/fmt-merge-msg.c: In function 'record_person':
builtin/fmt-merge-msg.c:213: error: cast to pointer from integer of dif=
ferent size

So...
