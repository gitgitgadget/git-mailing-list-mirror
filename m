From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Tue, 22 Mar 2011 11:00:23 -0700
Message-ID: <7vbp13kpc8.fsf@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <AANLkTimsiM6k9t8H6q4cwB9i42Q4ysNJb2MYyeYYnF5D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:00:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q25sw-00062Q-Bs
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab1CVSAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 14:00:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab1CVSAd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 14:00:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 496E949F1;
	Tue, 22 Mar 2011 14:02:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3TRm4+JMDcUX
	Uc79ld3P5ERwXEA=; b=o4sNAz0560evFD2aWM2Fz/naDdSrqctKqcyUZlz5x7hh
	iOtoyddkQjP7fsxatg+oS77p1GJr6jJY5zvfdvBDVoJKo9aK7Ead5+Rx/LW6+LOa
	8jcMzAtOPKjxOMXOoOAhQH7VhoQcQzIAkhh64WNVsEdFGYQYtxjpyBHuv2TWWpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=J6pLbN
	hs++yamnID3ghIBrMOtgnZQSLaVzAU37s0epox00Py/WGVd9opzPEB5NVX1DslyH
	RBwMRM2fSPFdGOVm87hSFe3X4Vg0oKEyo7SHygGgEKxxthgALfLqXggcvpb+Jp5S
	sO87egOQD7kE4cBsf9RH+zgpSaNLCRrn4dlvQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2743949EF;
	Tue, 22 Mar 2011 14:02:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E84F949ED; Tue, 22 Mar 2011
 14:02:04 -0400 (EDT)
In-Reply-To: <AANLkTimsiM6k9t8H6q4cwB9i42Q4ysNJb2MYyeYYnF5D@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 22 Mar
 2011 11:57:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8141C240-54AE-11E0-86DD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169755>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Mar 20, 2011 at 20:49, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> [Graduated to "master"]
>>
>> * ab/i18n-basic (2011-02-25) 9 commits
>> =C2=A0(merged to 'next' on 2011-03-10 at ab70d57)
>> =C2=A0+ i18n: "make distclean" should clean up after "make pot"
>> =C2=A0+ i18n: Makefile: "pot" target to extract messages marked for =
translation
>> =C2=A0+ i18n: add stub Q_() wrapper for ngettext
>> =C2=A0+ i18n: do not poison translations unless GIT_GETTEXT_POISON e=
nvvar is set
>> =C2=A0+ i18n: add GETTEXT_POISON to simulate unfriendly translator
>> =C2=A0+ i18n: add no-op _() and N_() wrappers
>> =C2=A0+ commit, status: use status_printf{,_ln,_more} helpers
>> =C2=A0+ commit: refer to commit template as s->fp
>> =C2=A0+ wt-status: add helpers for printing wt-status lines
>> =C2=A0(this branch is used by ab/i18n-st.)
>
> Thanks a lot for merging this down.

Heh, thanks a lot for starting it.  Do I have to thank you every time p=
art
of this huge series advances???

>> * ab/i18n-st (2011-02-22) 69 commits
>> ...
>> =C2=A0- i18n: git-init basic messages
>
> What's your plan for merging this to master?

A handful of them down to 'next' first, and then trickle them all
reasonably quickly, but probably not before 1.7.5 happens.
