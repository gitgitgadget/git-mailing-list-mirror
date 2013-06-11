From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/28] git-remote-mediawiki: Rewrite unclear line of instructions
Date: Tue, 11 Jun 2013 14:55:49 -0700
Message-ID: <7vwqq08g7u.fsf@alter.siamese.dyndns.org>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-8-git-send-email-celestin.matte@ensimag.fr>
	<7vsj0od6z5.fsf@alter.siamese.dyndns.org>
	<vpq1u8838rv.fsf@anie.imag.fr>
	<7vhah4bjtf.fsf@alter.siamese.dyndns.org>
	<51B784E8.8020700@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	benoit.person@ensimag.fr
To: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWXk-0008Tg-Ql
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab3FKVzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 17:55:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab3FKVzw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:55:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1EB327FDB;
	Tue, 11 Jun 2013 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5cPI9pLvyssk
	pkfEPmtUoOwQol4=; b=qaZ1SNkJ0cl1n4E08RHJFGrwZ7PpN4bFdKTPG0AXML1e
	0wXMwrBWN0LS1GqfWrdX9wB2HqOMHGdcD3/UbBygeEu1AlguDhizVvQOuaiBd7Rf
	I6vyyxunvjdH8rUdJhR41AiZCsjeHZ6eb2DpNaY+wJ8VmHVY+BqM04bDFeWFJxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=umkRNV
	1ckFU4id2gim32XmNKCCW1COuqD1KZ/Bxt2vMeVPpek/7OvmqK9E4p6LPshfdfgp
	GMoOnsPn5vCc8hBstL+Ud/Nu+Tn5ZsOfYaHF2tyin8GKHhA6slM/FYtIGjsMgeJA
	wjYSmn1hzCaJy4q6kVjwqs2mURFuUdY177KuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9113827FDA;
	Tue, 11 Jun 2013 21:55:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B79227FD9;
	Tue, 11 Jun 2013 21:55:50 +0000 (UTC)
In-Reply-To: <51B784E8.8020700@ensimag.fr> (=?utf-8?Q?=22C=C3=A9lestin?=
 Matte"'s message of
	"Tue, 11 Jun 2013 22:13:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE6F9CE8-D2E1-11E2-8A65-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227532>

C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:

> Le 11/06/2013 20:09, Junio C Hamano a =C3=A9crit :
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>=20
>>>>       my ($namespace) =3D @_;
>>>> 	my $namespace =3D shift;
>>>>
>>>> My impression has been that both are equally common,
>>>
>>> The second is the most common in git-remote-mediawiki (but I don't =
have
>>> any preference nor know what is recommended elsewhere).
>>=20
>> I wasn't implying I prefer the former.  I was just being curious,
>> and if the latter is more prevalent in the code _and_ Perlcritique
>> does not have any issue with it, it is perfectly fine.
>
> Perlcritic doesn't have an issue with any of both cases.

OK.  As this topic is about matching the opinion of Perlcritique, I
think it is fine either way (which was the primary thing that I
wanted to find out).

> I think the second method is clearer when there is only one argument,
> because it makes it clear that there is only one.

Hmm, from the maintenance point of view, the second one invites the
next person to extend this function like this:

	my $namespace =3D shift;
+       my $newargument =3D shift;
+	my $anotherargument =3D shift;

If your original were in the first style, instead you would likely to
get this:

-	my ($namespace) =3D @_;
+	my ($namespace, $newargument, $anotherargument) =3D @_;

When there is only one argument, it is clear that there is only one
argument in either style.  It is not a strong factor to pick one
style over the other.  Once you start taking more than one argument,
however, I think "it makes it clear what arguments the function
takes" would actually favor the style to split @_ into a list of
local variables.

But as I said earlier, this patch is about following Perlcritique's
advice, and because it does not have opinion on these styles, it is
outside the scope of this patch.

Thanks for checking.
