From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Wed, 07 Mar 2012 13:58:40 -0800
Message-ID: <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 23:00:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Ouc-0006X9-Pv
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597Ab2CGWA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 17:00:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758539Ab2CGV6m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 16:58:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C8A2704A;
	Wed,  7 Mar 2012 16:58:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7Imd8c5JRFKn
	o1uIF6X6YrR02Z8=; b=FkqqK6gJQ9PGvfOQzs8VW3qZ1MISby3/aqcp4XrnMFRK
	dW8lJu4lOIdHr3t88pMUlVqzh6Axtms5TRqmswI2W/eRDc1aaet8iRGxzyX0jULG
	IlGgvqLCWoMM0NeqqIH2sp9nXdsUWGKnyOSPaaxcY0SS1Uqusi+dAwtIjS+BtMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WDWNAr
	rgDtp8honVLRQHjKPr2n5sUgFm0cv92+TzqeDbMclBQj3TIQz2vMFJo9h0e0n559
	Zku2h2xtWehE5G7ZqGpqQl926lQ5LdL2BXNqGxVxg96tFYT66TWksOMZ+OZa0Rc+
	9We9Jk52pV2u0nAOgwtPoxWVBGB4jPt6wKRqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 041047049;
	Wed,  7 Mar 2012 16:58:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 893397048; Wed,  7 Mar 2012
 16:58:41 -0500 (EST)
In-Reply-To: <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Mar
 2012 22:43:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3A3AD0A-68A0-11E1-88F5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192489>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Mar 7, 2012 at 22:34, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> I think it's important to be pro-active about trying to spot
>>> any issues that might affect end users before they happen.
>>
>> The goal is noble, but asking the platform to perform an impossible
>> task and subjectively judging if the failure mode is acceptable is
>> not the way to do so, I would have to say.
>
> I leave it up to you whether you want to accept the patch to remove
> it, but with it included we at least *know* what the failure modes
> are, since we get user reports about it.
>
> That's the reason I put it in there to begin with. Because I have no
> idea how all these pieces play together with systems in the wild, and
> I'd like to pro-actively find out about that.

Are we talking about the same specific test?

What you said above all makes sense and I agreed that it is a noble
goal, *if* and only if the test is about the case we *expect* to
work.  This particular one prepares a message that cannot possibly
be transliterated to iso-8859-1 and asks the system to show it.

What scenario do you have in mind that we (or the end user for that
matter) might benefit by having this test?  What would be the next
step for us, when this test finds yet another mode of breakage that
spews out a different kind of garbage other than runs of "?", the
key used to query the message catalog ("TEST: Old English Runes"),
or the raw value stored in the message catalog (runes in UTF-8)?
