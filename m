From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Updating a submodule with a compatible version from another
 submodule version using the parent meta-repository
Date: Wed, 26 Jan 2011 14:05:43 -0800
Message-ID: <7v1v3zjp6w.fsf@alter.siamese.dyndns.org>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
 <AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
 <4D407099.4010805@web.de>
 <AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
 <4D407875.7080607@web.de>
 <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
 <7v7hdrl7nw.fsf@alter.siamese.dyndns.org>
 <AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Julian Ibarz <julian.ibarz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 23:06:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiDV4-0002lZ-6S
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 23:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab1AZWF4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 17:05:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab1AZWFz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 17:05:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89A524085;
	Wed, 26 Jan 2011 17:06:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EylolH7nHL+C
	oXkyWPxujdMgsRU=; b=kpK44yoR60Y1cjBJsAP2sDLyMIluCKqEoTEBnxUZ6W6B
	5TfytDeC3uZl+VyfW9EOmPNEP+IjkMUTFV5g2lNpDCkX6oFiqolU5IunaGQvlKoV
	vLdin0KCzkUgrKgG8qpIt6qqVBotM50UhRR1gPd9RA3QkzmZ3EDQDIFIOg7uL8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F/OXPa
	xamXMoJ9FmK5oEJH7IQn1ra6vfzypPEnoQCM4slu9MgYQ/sb2l+m7E+YEL3BWLhS
	pXfTyrtvdHc1IWdLaw6egm/To8IKmOimK2ojtsvF/8BE4ng4a/BSF6pe3FsaN/rE
	cNjVkkTCfXsA98O12zEUWsDobAifciRqjri0w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5826A4084;
	Wed, 26 Jan 2011 17:06:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 028644083; Wed, 26 Jan 2011
 17:06:35 -0500 (EST)
In-Reply-To: <AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com>
 (Julian Ibarz's message of "Wed\, 26 Jan 2011 15\:45\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8D48D88A-2998-11E0-88D8-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165557>

Julian Ibarz <julian.ibarz@gmail.com> writes:

> On Wed, Jan 26, 2011 at 3:41 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Julian Ibarz <julian.ibarz@gmail.com> writes:
>>
>>>> Hmm, looks like I lost you here ... you want to bisect in B althou=
gh
>>>> you know what commit you want there? Care to explain a bit more?
>>>
>>> In B I have a feature to integrate in master branch. This feature i=
s
>>> in branch old_feature. But this branch is really old. To try this
>>> feature I need to rebuild it at this version. To make the build
>>> success I need also to revert back the submodule C because B is
>>> dependent on it. But finding the good version of C that match
>>> old_feature version is a pain... Is it clear?
>>
>> That sounds like bisecting in C with a frozen checkout of B to see w=
hich
>> version in C works well with that target commit in B you know you wa=
nt to
>> use. =C2=A0Why do you need to bisect in B???
>
> Forget about bisect. This is a different use case where I need the
> feature I am talking about: checkout an old version in B and
> automatically having A and C switch to a compatible version (the caus=
e
> can be because of a bisect or just because I want to try an old
> feature not yet integrated into master or whatever the reason I want
> to be on this old version).

If that version of submodule B is explicitly bound to a commit in the
superproject A, you know which version of A and C were recorded, and th=
e
problem is solved.

But otherwise, you are wishing for a miracle, I am afraid, without givi=
ng
your tool (git or your own tool you write on top of it) some hint to sa=
y
how "similar" commits in B are, as there is no guarantee that anybody e=
ven
tried a commit that is not directly referenced from the superproject
together with other parts of the system.

If you are confident that you didn't introduce different kind of
dependency to other submodules while developing your "old_feature" bran=
ch
in submodule B, one strategy may be to find an ancestor, preferrably th=
e
fork point, of your "old_feature" branch that is bound to the superproj=
ect
A.  Then at that point at least you know whoever made that commit in A
tested the combination of what was recorded in that commit, together wi=
th
the version of B and C, and you can go forward from there, replaying th=
e
changes you made to the "old_feature" branch in submodule B.
