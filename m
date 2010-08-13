From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's tests have depended on Perl since at least 2006
Date: Fri, 13 Aug 2010 16:30:25 -0700
Message-ID: <7vvd7ehyzy.fsf@alter.siamese.dyndns.org>
References: <AANLkTim9aNtFdwM5m-FB_LWX96es2DR_9mU3rGcV4dME@mail.gmail.com>
 <7v4oeyjfnw.fsf@alter.siamese.dyndns.org>
 <AANLkTi=FvAZZsxctJ-sXuQxsMgn15BhKooXjO13CVy6U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 01:30:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok3hw-0000fu-9p
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 01:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab0HMXaf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 19:30:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab0HMXae convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 19:30:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15F24CD650;
	Fri, 13 Aug 2010 19:30:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oIN1hIhRTY7O
	jNZHRKLhLBSW/tw=; b=m4iQdrKYGpso4vmgqwlCgawjk2zAqkk29VD4S5VivYUZ
	7RSFWINmbvTfFQPpN64kQp1xcS+iWLL0sbQUyH3M7uQD9UF9vXSm23CWgZMg67l9
	dwQsVgMseUuolExTRNVzV7P3SxwZc/ccqIt5CNW2vGKOXyn5KuFBjktB3osWq/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XX0573
	+AJBJ5ujsmDK83FyLyI7u93eHPrIPawv/yQkX8hDl6kDyyHuJEItzzXGjcKMA3Cs
	GRonaxZqFPhQWG/khLNZJ3Ol7BUjlAfiBogdvqRhledykz2iPSbD9vRPNRTGciU2
	28ozPpPpMnIanvgUR/cd24JERRCGbTVLvxe1g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94517CD64F;
	Fri, 13 Aug 2010 19:30:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 937C7CD64E; Fri, 13 Aug
 2010 19:30:27 -0400 (EDT)
In-Reply-To: <AANLkTi=FvAZZsxctJ-sXuQxsMgn15BhKooXjO13CVy6U@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 13 Aug
 2010 22\:56\:50 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C2FA3480-A732-11DF-8D7A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153525>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Aug 13, 2010 at 22:45, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> This is just an interesting datapoint, but Git's test suite current=
ly
>>> crashes and burns if you don't have a perl in your $PATH, no matter=
 if
>>> you've compiled with NO_PERL=3DYesPlease or not. This has been the =
case
>>> since at least 2006, or v1.3.0-rc1~13^2~34.
>>
>> I'd suggest you not to go overboard on this. =C2=A0NO_PERL=3DYesPlea=
se is
>> primarily about the deployment environment. =C2=A0The person who is =
building
>> and packaging git may have perl on her development box.
>
> I promise not to go overboard :)
>
> The aim of this and some recent patch serieses has been to improve ou=
r
> smoker support. I'd like people to be able to run a smoker without a
> perl without sending false positives in their smoke reports, that's
> all.

I had an impression that your smoker report supports builds on tap harn=
ess
that in turn builds on perl.
