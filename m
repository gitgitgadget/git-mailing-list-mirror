From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add global and system-wide gitattributes
Date: Sun, 29 Aug 2010 22:34:40 -0700
Message-ID: <7vy6bohde7.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=2tRjGicxJxnJ3xccCGxcP3bLUy8u0O7q85D=R@mail.gmail.com>
 <1281977813-6528-1-git-send-email-gsvick@gmail.com>
 <87d3t7ow39.fsf@gmail.com> <vpqbp8mskv1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org,
	Henrik Grubbstrm <grubba@grubba.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 30 07:35:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opx1K-0005Wp-Hq
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 07:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab0H3Fe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 01:34:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0H3Fez convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 01:34:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C25AD1DF0;
	Mon, 30 Aug 2010 01:34:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+z5JxZykVARp
	CkOlwC4uQBYM6os=; b=Xrnq5/v7ty6qWpQEJ2pxjTaAYjIGT148oIezg+6TDY6y
	ZjoLcrT/zYw8PSz/1fdBabZuwkLOyMXqiVj1jvNiYBaQHb62NBsq6/rEXZ5pavLF
	EcYeLKrQ+DdaC4QojgEI4aO0eQZQVBzWIVbeCPiDaQTh58DGnJ6RNc6BIbaLjrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nE0yJO
	l2AI9LKlonbKQVB4aqaYTkyVmAeAdfZwqwY/lEFZZ3yfZoycIsA3ic31FVxH1Lx8
	+cp6cc5B23LP5LZDwi+NGCSkDuJT/2GL6+odaOzlSlm+mF3ni7d818hyPUPBUOlU
	M2nkVGUF8r2Acn1ALk3bDuavNO+l+0kgZ67Vs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03236D1DEC;
	Mon, 30 Aug 2010 01:34:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB499D1DEA; Mon, 30 Aug
 2010 01:34:42 -0400 (EDT)
In-Reply-To: <vpqbp8mskv1.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat\, 28 Aug 2010 19\:33\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E35C768-B3F8-11DF-97D1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154764>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:
>
>> Petr Onderka <gsvick@gmail.com> writes:
>>
>>> Allow gitattributes to be set globally and system wide. This way, s=
ettings
>>> for particular file types can be set in one place and apply for all=
 user's
>>> repositories.
>>
>> [...]
>>
>> I really can't wait till this gets into Git and I'm certainly not th=
e
>> only one (thank you so much for working on it, Petr!).
>
> Same here ;-).
>
>> Any reason the patch still hasn't been applied?
>
> Usually, patches are applied if either
>
> 1) Junio has personal interest in it, or
>
> 2) Other people review the code and show interest for it.

(1) is a bit more subtle than that.  Even when I do not foresee using a
proposed feature myself, if I can imagine somebody else would benefit, =
and
more importantly if I can see a healthy rationale behind the change so
that I can convince myself to be an advocate of that change to the end
users, such a change will fall into category (1).  That is why I often =
ask
people to justify their changes better than they originally do.

Isn't the patch in question on 'pu' to be tried by interested parties
already?
