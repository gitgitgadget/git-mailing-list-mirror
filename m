From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/20] [CONTINUE] Add gettext support to Git
Date: Fri, 10 Sep 2010 09:01:28 -0700
Message-ID: <7vaanpio4n.fsf@alter.siamese.dyndns.org>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
 <7vd3sonq2n.fsf@alter.siamese.dyndns.org>
 <AANLkTinC59XFt8pPyUF3ifMTeVMSC1e44MDPto5Fy1+n@mail.gmail.com>
 <AANLkTimU6Cznnqp+SokZDK7fnhV712a9QcAAd5peo93m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 18:01:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou62x-0003gi-ER
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab0IJQBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 12:01:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab0IJQBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 12:01:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 126CAD5B21;
	Fri, 10 Sep 2010 12:01:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r6g/16IxlMH1
	lescRLcQn4ZF8tg=; b=KIYzy6c2V0U9VHc1C76i/kH34UnmUN5MZ5IkWPliPbXx
	rZ4ohZkUVdYQzK0ovdO0TtUa2/UpmVh+N/xeG+kLaiFUS6xlgcLFtFXecD+BzURk
	NBwUgHBbL2CW5IuSz8IF+24FPGMV2UdclXcD6Henv0rvW4iG8PRtAJMHTE1xJNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UE63ks
	87F2sD1FB9pykQ5gkwvSnYhkeG43brxj0KVvN6SCBTRK5jCLsiHMFcleHGzqAHEL
	PZsNq/qUet3J86b6mMYMCfTQj9NeRU9WKDiIb16I28NX3vqR6l9/RwKfioG3wJ6N
	5OCpM5Pr6p2mXFUbSoAaNS8Suy6LO8ZrIF9XE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B12F3D5B1A;
	Fri, 10 Sep 2010 12:01:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D123D5B10; Fri, 10 Sep
 2010 12:01:32 -0400 (EDT)
In-Reply-To: <AANLkTimU6Cznnqp+SokZDK7fnhV712a9QcAAd5peo93m@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 10 Sep
 2010 12\:00\:43 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B14B198E-BCF4-11DF-88FC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155936>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Hi, since you didn't pick this up in the last push I fixed it up a bi=
t
> more.
>
> I rebased ab/i18n-all-continue on the new master:
>
>     git fetch git://github.com/avar/git +ab/i18n-all-continue:ab/i18n
>
> But you probably want this instead:
>
>     git fetch git://github.com/avar/git +ab/i18n-all-continue-with-hi=
ndi:ab/i18n
>
> I took the liberty of adding Ramkumar Ramachandra's hi.po patch to th=
e
> series.

I think that the latter is "i18n-continue-with-hindi" (no "all"), and a=
lso
suspect that ab/i18n-all-continue either hasn't be pushed out or is sta=
le?

The copy of "all-continue" I just fetched ends with 2b5170f (gettextize=
:
git-shortlog basic messages, 2010-09-05) while hindi^ is at c4adf2e
(gettextize: git-am printf(1) message to eval_gettext, 2010-09-07).

I haven't formed an opinion as to what to do with the *.po files after =
the
series hits 'next' (or anything more stable than 'pu'); my preference i=
s
to delegate that part of the system to somebody who volunteers as an i1=
8n
coordinator, and pull from him/her from time to time, just like the way
gitk and git-gui are managed.

=46or now, I'll queue the whole thing and merge that to 'pu', but we wo=
uld
want to squash l10n commits after (but not including) 8d65a35 (gettext
tests: test re-encoding with a UTF-8 msgid under Shell, 2010-08-30) tha=
t
touch only one file in po/*.po into one commit per language, move them
near the tip after all the infrastructure enhancements (and fix-ups to =
the
infrastructure, if necessary) and individual command i18ns, to make the
end result a reasonably complete and clean "first cut for public testin=
g"
of the series before it hits 'next'.

As a companion update to 6495411 (gettext docs: add po/README file
documenting Git's gettext, 2010-09-03), we would need a file in
Documentation/ directory to describe the use of _() and N_() for
programmers and point it from CodingGuidelines.  We might also want to
move po/README to Documentation/ but I don't have strong preference eit=
her
way.

Thanks.
