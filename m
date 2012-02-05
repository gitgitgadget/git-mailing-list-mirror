From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t: mailmap: add 'git blame -e' tests
Date: Sun, 05 Feb 2012 12:38:03 -0800
Message-ID: <7vvcnlggno.fsf@alter.siamese.dyndns.org>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
 <1328385024-6955-3-git-send-email-felipe.contreras@gmail.com>
 <20120204201027.GE22928@burratino>
 <CAMP44s3tmiPGgAUakUgoen2aJcsKw4CygtF5f=4x2dxNTrGbGA@mail.gmail.com>
 <20120204211351.GB3278@burratino>
 <CAMP44s2djXurzMSXLOAkx84Sm8P2YV67M1yS2AuidkfGbTdmEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Marius Storm-Olsen <marius@trolltech.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 21:38:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru8qj-0003ZF-7l
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab2BEUiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 15:38:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab2BEUiH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 15:38:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD70F5224;
	Sun,  5 Feb 2012 15:38:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2BNSY1gSPb/n
	/jNFlP1CQEERc2U=; b=NUf496ILOexJtGgCyt3qdtcv5NYpHC9iuMAyF0M8iqln
	CENDyo+Wa+R4oqfc0bHKxuCEuVGuVLtz0nl1yzyML5m4gBub3B4XskWkdrTvEcwi
	tK1VIuswy34Pa27cJQAkLjIGu3gvBmIXcERxE1STX0WiO7RrYF47R38Sdw/nIso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mToK50
	eGNNKU/t9HKT0x8NTlfvrU6wXcN7XdMWKFFpMxaOmphftt+u0gMcxj2/ioZ7l1an
	ErltCCD8ku8A2xKU6BsyB3K4xpFCDgw0PnD0N3+21VWQvqc41u9njsK8JJExrJ6e
	X5iNLgmqQowbIrEj6rM6PMI29uo2gE4i0Ez+M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C40695222;
	Sun,  5 Feb 2012 15:38:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F88C5217; Sun,  5 Feb 2012
 15:38:04 -0500 (EST)
In-Reply-To: <CAMP44s2djXurzMSXLOAkx84Sm8P2YV67M1yS2AuidkfGbTdmEQ@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 4 Feb 2012 23:59:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DCFDCB2-5039-11E1-89F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189954>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

>>> Look at the title:
>>> add 'git blame -e' tests
>>>
>>> s/blame/blame -e/
>>
>> And? =C2=A0After copy/pasting this particular test with that substit=
ution,
>> what do we get a test for?
>
> For 'git blame -e'.
>
>> What class of problem is it supposed to catch?
>
> Problems related to 'git blame -e'?

You very well know that we know you better than that, so it is no use t=
o
pretend to be dumb.  It does not do anything other than wasting bandwid=
th
and irritating readers.

You know that you are not addressing "git blame with the -e option show=
s
wrong line numbers on its output".  The symptom you are checking with i=
s
"e-mail address output from 'blame -e' used to add an extra '>' at the =
end
when only name is mapped, and I fixed it with the previous patch."

Why is it so hard to either

 (1) give the more descriptive answer upfront when somebody who did not
     read the first patch of the 3-patch series pointed it out the comm=
ent
     is not descriptive enough the first time; or

 (2) give the more descriptive answer and then say "we could do that, b=
ut
     when somebody views this change in "git log" as a part of 3-patch
     series, it should be clear enough---so let's aim for brevity inste=
ad
     of adding that two-line description" to defend the line in the pat=
ch?

> Or just apply it. Don't let the perfect be the enemy of the good.

Perfect is the enemy of the good, but it is not an excuse to be sloppy.

I tend to think that a single line "# blame -e" is sufficient if this w=
ere
a part of just a single patch that has the fix and the test to guard th=
e
fix against future breakage (i.e. "not sloppy"). I would even say that =
not
even "# blame" is necessary in such a case.

But if this is a standalone patch to add this test, it does not describ=
e
what it wants to test very well.

In any case, I have doubts that the fix should go to blame and not to
map_user(), so I'll see what happens in the further discussions.

Thanks.
