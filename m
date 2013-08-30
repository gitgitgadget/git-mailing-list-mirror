From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] hotfix on fr.po for the maint branch
Date: Fri, 30 Aug 2013 11:07:06 -0700
Message-ID: <xmqqli3jyrw5.fsf@gitster.dls.corp.google.com>
References: <CANYiYbG6MweCwLaUw5Uk3S9a0hUY1vuS+ORCF1BipkZkJeHjrw@mail.gmail.com>
	<xmqq61un15lo.fsf@gitster.dls.corp.google.com>
	<21533323.C8UgJI1nMs@cayenne>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Sebastien Helleu <flashcode@flashtux.org>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Fri Aug 30 20:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFT6J-0003sZ-SQ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804Ab3H3SHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 14:07:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699Ab3H3SHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 14:07:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAACF3CA4D;
	Fri, 30 Aug 2013 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BxStaYxfcnvW
	pD77w8XD+w7g8q4=; b=qKMwB6LVWS8Mai0wyTEU81u8mu1PYyC1wk3rgAGmu2+l
	xLxoOokzTpCqosCPsLWL6ybHri4+0jvFuApb8UcQ4s712wkTELjb1j+lMo67a3/l
	1Mg8czm9c5ic8NSsElHAoEkIawJcxrfJn4QDVIJyK1mNZWRu9n6QGHP27SKhZOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B8GZkM
	eCRGLMLaDqHjQzzVDg9+chfoiaBT74ZYOH5RyldLtIUsAkxTOLpyw+gO3jyu4bvi
	FrQkix3aR2RyGqI1MV78J9rUArTVvSu9TlwU0Cpotu8y0tx6JuoKEyCulZuI0zK4
	FWx0dHamk48GZTeaZAK8WO7uek7TM7ZNyfmxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD4543CA4C;
	Fri, 30 Aug 2013 18:07:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 467F23CA4A;
	Fri, 30 Aug 2013 18:07:08 +0000 (UTC)
In-Reply-To: <21533323.C8UgJI1nMs@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Fri, 30 Aug 2013 19:23:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FC14EF56-119E-11E3-B726-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233448>

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Le vendredi 30 ao=C3=BBt 2013 09:54:59 Junio C Hamano a =C3=A9crit :
>> Jiang Xin <worldhello.net@gmail.com> writes:
>> > Please merge this commit to the maint branch.
>> >=20
>> > The following changes since commit=20
> e230c568c4b9a991e3175e5f65171a566fd8e39c:
>> >   Git 1.8.4 (2013-08-23 11:49:46 -0700)
>> >=20
>> > are available in the git repository at:
>> >   git://github.com/git-l10n/git-po master
>> >=20
>> > for you to fetch changes up to 21860882c8782771e99aa68fab6e365c628=
ff39d:
>> >   l10n: fr.po: hotfix for commit 6b388fc (2013-08-30 16:59:29 +080=
0)
>> >=20
>> > ----------------------------------------------------------------
>> >=20
>> > Sebastien Helleu (1):
>> >       l10n: fr.po: hotfix for commit 6b388fc
>>=20
>> Hmph, what happened that requires a "hotfix" to message strings?
>
> Well, as the author of the first commit,, I must say that the quality=
 was not=20
> good. But it became visible and hooked up a reviewer only when it was=
 promoted=20
> to stable version...
>
> There are some strings that do not make sense in the usage pages, a m=
issing %s=20
> in one.  	Agreed that applying this patch does not solve a critical i=
ssue, but=20
> it is low risk.

OK, I was just reacting to the "hotfix" wording and wondering the
level of urgency.  Will pull to maint later before cutting 1.8.4.1.

Thanks.

>
>>=20
>> >  po/TEAMS |    1 +
>> >  po/fr.po | 1591
>> >  ++++++++++++++++++++++++++++++++++---------------------------- 2 =
files
>> >  changed, 874 insertions(+), 718 deletions(-)
>> >=20
>> > --
>> > Jiang Xin
