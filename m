From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Wed, 17 Apr 2013 17:35:35 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <2437082.cf76RUS0j0@cs-pc>
References: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com> <CAN0XMOLmwUpwOi0xz4iOy3wfhzCeeNKNgywgS9ZfaET172vsBQ@mail.gmail.com> <87a9ox1sue.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	git <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:35:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USUOk-0005Yc-7N
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966787Ab3DQPfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 11:35:47 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:43392 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966772Ab3DQPfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 11:35:46 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id r3HFZc3M029799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 17 Apr 2013 17:35:38 +0200
Received: from cs-pc.localnet (g224000185.adsl.alicedsl.de [92.224.0.185])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id r3HFZbOE022963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Apr 2013 17:35:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2013-16;
	t=1366212938; bh=zOI+56HmocQJEkXhhdyn/zu5v5IMH5p6N+s8b59dLCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nSvOZ6m0dGcXgovpHVy3NMr+lPKINyeqNoa/VtJbcFo1KVYpcOG40YO2YhFmxcEzU
	 BXIh17SKzEfhvN3KRU6d5rSTgyiuIbSbKmM9yZ6iVd5MfXnuDy3RGGsSIjELjykU2Z
	 5txz8IbDHZuH+WmD6rbV0PR3b1wWzOuV+JwTkBFE=
User-Agent: KMail/4.7.3 (Linux/3.0.0-32-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <87a9ox1sue.fsf@linux-k42r.v.cablecom.net>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221547>

Am Mittwoch, 17. April 2013, 10:09:29 schrieb Thomas Rast:
> >> >  msgid "The bundle contains this ref:"
> >> >  msgid_plural "The bundle contains these %d refs:"
> >> >=20
> >> > -msgstr[0] "Das Paket enth=E4lt %d Referenz"
> >> > -msgstr[1] "Das Paket enth=E4lt %d Referenzen"
> >> > +msgstr[0] "Das Paket enth=E4lt diese Referenz:"
> >> > +msgstr[1] "Das Paket enth=E4lt diese %d Referenzen:"
> >>=20
> >> The msgstr[0] must still contain a %d conversion specifier (which =
will
> >> be filled with the number 1) even though the translated sentence
> >> wouldn't need the 1 anymore. The previous msgstr[0] was correct; t=
he
> >> English singular msgid
> >> is not.
> >=20
> > That made me wonder, too. I've played around a bit with this, and i=
t
> > seems to be OK as long as one of those strings contain at least one
> > format specifier.
>=20
> C printf() only knows about the number and types of arguments from th=
e
> format string, so *ignoring* arguments is not a problem for correctne=
ss.

Indeed both of you are correct and I learned something new.=20

http://stackoverflow.com/questions/3578970/passing-too-many-arguments-t=
o-
printf

where the second answer quotes  Online C Draft Standard (n1256), sectio=
n=20
7.19.6.1, paragraph 2: "If the format is exhausted while arguments rema=
in, the=20
excess arguments are evaluated (as always) but are otherwise ignored."

Hence, it is indeed safe to skip unneeded conversion specifiers both in=
=20
general ngettext messages and also in their respective translation. Thi=
s is an=20
explanation which has yet to be added to ngettext's documentation.

Best Regards,

Christian
