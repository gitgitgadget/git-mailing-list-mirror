From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: fix syntax error in "Use advise() for hints" test
Date: Fri, 20 Aug 2010 10:51:37 -0700
Message-ID: <7v8w41cguu.fsf@alter.siamese.dyndns.org>
References: <20100811083100.GA16495@burratino>
 <1282142204-14720-1-git-send-email-avarab@gmail.com>
 <20100819043036.GD25649@burratino>
 <AANLkTikDq4eJfm2RnbGDuJMHCR8_4cn6NfJpoYWHbWWN@mail.gmail.com>
 <87aaohwq0r.fsf@hariville.hurrynot.org>
 <AANLkTi=WoMFYU6rDggyB+-s6F_LasUnc-N+gk9v+=C_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Raja R Harinath <harinath@hurrynot.org>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 19:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmVkt-0006EF-Eh
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 19:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab0HTRvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 13:51:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab0HTRvr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 13:51:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E8BCE20B;
	Fri, 20 Aug 2010 13:51:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eg0liJJKjfMf
	LF4otisb/jvFwfg=; b=UHP8GKpTwehbPb0vIR1Ln2PG2/1iRMnbolFCKbz6ZDWh
	aO487dAZxkUpzMm2VbLh8InYXGNZNgH5E4SL5vChvMkoWyU28O/GnxPXrfJVCb4P
	kGvcKeB1ZFT7zAi0EJpl3QgWO09g7TbRp4uzZhWS4GXt69pPoUYsxEUAitUdupg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LQaRMK
	vVl71HQNjgglwcCILQBRHySCvA9yj7nwO64M7mz9IOZKfiaPVm5bNpozMOjlipTm
	kIu8blw2bwPCiycABlhqHEmfezKnpgTyOqBmFQG4cRwNO4pDsR6TUb0n68WQdExT
	Kg0H8wXG7Ss2uKZqBwzFGw/rIxV0qjPIlPsh8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FBC3CE203;
	Fri, 20 Aug 2010 13:51:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40778CE201; Fri, 20 Aug
 2010 13:51:39 -0400 (EDT)
In-Reply-To: <AANLkTi=WoMFYU6rDggyB+-s6F_LasUnc-N+gk9v+=C_r@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 20 Aug
 2010 14\:22\:02 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97B57EAA-AC83-11DF-85BB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154062>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Aug 20, 2010 at 10:13, Raja R Harinath <harinath@hurrynot.org=
> wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Aug 19, 2010 at 04:30, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> [snip]
>>>> Although the style you chose is arguably the least ugly, nested sh=
ell
>>>> interpolation can be hard to follow. =C2=A0How about this?
>>>
>>> I think '\'' is harder to follow than \" and \$, but each to his ow=
n
>>> :)
>>
>> There's also the slightly longer but somewhat prettier '"'"'.
>
> I must say, you guys have an odd sense of aesthetics :)

I'd have to agree.  If I were writing this I would probably use '\''
myself but that is not because it looks good (it does not) but in my
experience it tends to be the least error prone.

But your original is just fine.
