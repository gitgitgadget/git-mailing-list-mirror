From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cooking of the ab/i18n series
Date: Fri, 06 Aug 2010 06:30:58 -0700
Message-ID: <7vmxszamwd.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
 <7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
 <AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 15:37:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhN6w-00022C-Ph
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 15:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760735Ab0HFNbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 09:31:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab0HFNbI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 09:31:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6956FCB9D9;
	Fri,  6 Aug 2010 09:31:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cH9NT0tT96n+
	7wHwRgw6wSIHaps=; b=bMTN8EgzEPPF4C203dPEA8jT0gifIBYi9mQGQCvK1FAv
	LhHL6YfJzqde48g6ObBzBtlE13vTgRkoj5lBIxjXAhBUae9aZVBbgSWIKH++5IeN
	178/IY6zqyCIFV5NivwMCLINRhnK1d0Jzf8hPIQVHUtNIoBLOrsd7o0skp0lLhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=v2rrSW
	zJoVv5IWLV8QIPYc772zBDdJk1JycqiB7DI5JtTSpPbQ163LXgyT3GvYFLHkcQC7
	2wDqj0FN4i1FGSP9XMWaE1cM9KcfjK1cmRCwHzcTsQc+0S5l+UAD1Ir5omqX9Rlu
	jNoHXWaKIt4/uaW9c44xbOUlPYYKEF9XB3mak=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41D4FCB9D8;
	Fri,  6 Aug 2010 09:31:03 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CE70CB9D3; Fri,  6 Aug
 2010 09:31:00 -0400 (EDT)
In-Reply-To: <AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 6 Aug
 2010 12\:33\:10 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DBE19DD2-A15E-11DF-B750-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152779>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Aug 5, 2010 at 22:18, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> When people see the benefit of doing so. =C2=A0I currently do not se=
e much need
>> for it myself but I am a minority ;-).
>
> That's news to me. I'd assumed that it was mostly on track, i.e. that
> it would get merged down after cooking for a while in pu.
>
> However, if it's a matter of gathering popular support maybe I should
> change my strategy a bit.

The "popular support" needs to be qualified.  If you ask any random per=
son
"Is it a good thing if software package X supports i18n?", the answer
would always be "yes"; popular support in that sense doesn't mean much.

I am more worried about unintended consequence of this particular
execution.  For example, I would want to be absolutely sure that we won=
't
break plumbing output in 'next' and the proposed mechanism helps others
avoid breaking things by mistake.

> The follow-up work I was referring to was the project we'll need to
> undertake once it's merged to convert "foo" to _("foo") as
> appropriate.

That is one good example.  Perhaps we can get a list of messages that w=
e
can place in Documentation/ area (e.g. "'Not up-to-date' - this message=
 is
given when you have local changes in a file in the working tree; given =
by
command X, Y and Z") out of that effort for free?  Perhaps such a list =
can
help us verify that i18n does not break plumbing output (because the li=
st
does not contain plumbing messages)?
