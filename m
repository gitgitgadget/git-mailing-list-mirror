From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update l10n guide
Date: Wed, 29 Feb 2012 21:25:11 -0800
Message-ID: <7vk434q4eg.fsf@alter.siamese.dyndns.org>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
 <7v1upew6d0.fsf@alter.siamese.dyndns.org>
 <7vfwduujxw.fsf_-_@alter.siamese.dyndns.org>
 <CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6wC5JiAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:25:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2yWR-0003QE-VD
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 06:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587Ab2CAFZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 00:25:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab2CAFZP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 00:25:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1FBF756E;
	Thu,  1 Mar 2012 00:25:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dsJZThVkkZ5U
	RjGtg728XnE4QCI=; b=aqxQ9XwQgkSyu8n3wBkeJSUoMnehFi+5HVvWA3yhRaIB
	1uupWjAFiu43uHG23YJvMECB7H6NwdEVpczNaX6u2YxZxDgg9TtNSdd4zchkcVjH
	SoIWOSwV9VnrLQYyT4ZHhQupBdpeQOrxsiCm0sVVIvfcgQIxgr09dSZKIZ/Fvbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fjVsz5
	IBv7awS0QWWmDrOork1KaSkb6syVR3lRH2u/G1HH8Stq/scYP6Wqz2MNnE1++OlT
	oe0PpCS8S91zcIStUDqLZUOU2HauNbmlF6asDLLXs02qAy2DZd1kav7oQW6HU8wJ
	LXZ3zzQ6WpacDbfxEZ1LQp5xEA62jgtZKLiLI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8959756D;
	Thu,  1 Mar 2012 00:25:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECF667568; Thu,  1 Mar 2012
 00:25:12 -0500 (EST)
In-Reply-To: <CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6wC5JiAA@mail.gmail.com> (Jiang
 Xin's message of "Thu, 1 Mar 2012 12:05:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBAC0FD6-635E-11E1-887E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191896>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2012/2/29 Junio C Hamano <gitster@pobox.com>:
>
>> @@ -1,33 +1,78 @@
>> +The localization (l10n) coordinator, Jiang Xin <worldhello.net@gmai=
l.com>,
>> +coordinates our localization effort in his repository:
>> +
>> +        https://github.com/gotgit/git-po/
>
> I create a new dedicated team, named git-l10n, and transfer this repo=
 to the
> new place: https://github.com/git-l10n/git-po/ for the following reas=
ons:
>
>  - git-po is a long-term repo, so has a dedicated, stabilized URL is =
better.
>    The repo URL may not change if l10n coordinator change.
>
>  - git-l10n is a github organization account, and has a dedicated own=
ers
>    group, who can assign new l10n coordinator.
>
>  - Owners group of git-l10n organization will not receive pull reques=
ts to
>    git-po. I add gister, avar to the owners team.
>
>  - Members of the git-l10n-coordinators team of git-l10n organization
>    will receive pull requests.
>
>  - Some Chinese guys used to send pull request to gotgit/git-po, so y=
ou
>    can find some closed pull requests written in Chinese. It won't ha=
ppen
>    after the repo transfer to git-l10n/git-po.

It is unclear the distinction between gotgit and git-l10n but I am
guessing that (1) you feel "gotgit" is more for _your_ personal use, (2=
)
you happen to be the volunteer coordinator right now, but (3) the team
effort deserves more permanent home, detached from your identity.

And if that is the case, I agree 100% with the reasoning.

>> +As a contributor for a language XX, you would fork this repository,
>
> As a contributor for a language XX, you should first check TEAMS file=
 in
> this directory to see whether a dedicated repository for your languag=
e XX
> exists. Fork the dedicated repository and start to work if it exists.
>
> If you are the first contributor for the language XX, please fork thi=
s
> repository,

That's better.

>> +prepare and/or update the translated message file po/XX.po (describ=
ed
>> +later), and ask the l10n coordinator to pull your work.
>
> Shall we remind the contributors for l10n to write commit log in Engl=
ish,
> but not language XX? It's a common mistake for translators.

I would prefer to see the subject line (the first line summary) in Engl=
ish
to say something like "Update zh_CN translation for 1.7.12".  That much=
 of
English shouldn't be too much burden for language teams.

On the other hand, the body of the log that describes the change _may_ =
be
hurt if you forbid the use of language XX.  The translators may want to
write something like:

	The earlier translation used word '[%#$@$#]' for original phrase
	'to distim' in English, but word '[**&*#$]' is a more appropriate
        language XX translation in the context the message for such and
	such reasons.

and I suspect that "for such and such reasons" part is far easier to
explain and understand if written in language XX for native speakers of
language XX.  Such a description often has to discuss connotations and
subtle nuances of the particular word that is hard to explain.

>> diff --git a/po/TEAMS b/po/TEAMS
>> new file mode 100644
>> index 0000000..8ee6199
>> --- /dev/null
>> +++ b/po/TEAMS
>> @@ -0,0 +1,10 @@
>> +Core Git translation language teams
>> +(please keep the list sorted alphabetically on language field)
>> +
>> +Language:      is (Icelandic)
>> +Leader:                =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com>
>> +
>
> I think we should add the URL of the dedicated repository for languag=
e XX here.
> Example:
>
> Language:      zh_CN (Simplified Chinese)
> Leader:           Jiang Xin <worldhello.net@gmail.com>
> Homepage:     https://github.com/jiangxin/git-po-zh_CN/

Good thinking; I don't know if Homepage or Repository is more appropria=
te,
but some URL would definitely help.
>
>> +Members:       Yichao Yu <yyc1992@gmail.com>
>> +               Riku <lu.riku@gmail.com>
>
> Contributors and members can add to the header of the XX.po file.
> Add here may cause the TEAMS file grows rapidly.

Sorry, I do not understand what you are worried about here.  Could you
clarify a bit?

In any case, the patch you are replying to is "I'd like to see *somethi=
ng*
*like* *this*...", so feel free to take the ownership and update it.  I=
'll
try to help refining it if you send an updated draft to back the list f=
or
review.

Thanks.
