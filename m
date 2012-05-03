From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH de.po 5/5] de.po: collection of suggestions
Date: Thu, 3 May 2012 09:42:06 +0200
Message-ID: <877gwtyalt.fsf@thomas.inf.ethz.ch>
References: <cover.1335966202.git.trast@student.ethz.ch>
	<abfde735e408a8fc34e143ec25d1a345b6fcbd27.1335966202.git.trast@student.ethz.ch>
	<3137881.zK1NKVIFJ3@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Thu May 03 09:42:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPqg4-0003gj-QP
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 09:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab2ECHmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 03:42:10 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:9517 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab2ECHmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 03:42:09 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 3 May
 2012 09:42:04 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 3 May
 2012 09:42:06 +0200
In-Reply-To: <3137881.zK1NKVIFJ3@cs-pc> (Christian Stimming's message of "Wed,
	2 May 2012 21:42:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196890>

Christian Stimming <stimming@tuhh.de> writes:

> As one of the earlier translators: I agree with most of those as well=
=2E Thanks=20
> a lot. However, one small remark:
>
> Am Mittwoch, 2. Mai 2012, 15:49:27 schrieb Thomas Rast:
>> @@ -676,11 +675,11 @@ msgstr "hinter "
>>=20
>>  #: wt-status.c:908 wt-status.c:911
>>  msgid "ahead "
>> -msgstr "=C3=BCber "
>> +msgstr "weiter: "
>>=20
>>  #: wt-status.c:913
>>  msgid ", behind "
>> -msgstr ", hinter "
>> +msgstr ", zur=C3=BCckgefallen "
>>=20
>>  #: builtin/add.c:62
>>  #, c-format
>> @@ -903,12 +902,12 @@ msgstr "Zweig '%s' zeigt auf keine Version"
>>  #: builtin/branch.c:396
>>  #, c-format
>>  msgid "behind %d] "
>> -msgstr "hinter %d] "
>> +msgstr "%d hinterher] "
>>=20
>>  #: builtin/branch.c:398
>>  #, c-format
>>  msgid "ahead %d] "
>> -msgstr "vor %d] "
>> +msgstr "%d voraus] "
>
> In the above hunk, you said "ahead =3D weiter" and "behind =3D zur=C3=
=BCckgefallen",=20
> but now you say "ahead =3D voraus" and "behind =3D hinterher". Is it =
helpful to=20
> use two different translations, or shouldn't those rather be chosen=20
> identically? The second set sounds somewhat better to me, but the mor=
e=20
> important question is whether both hunks should use the same translat=
ions.

Yeah, sorry about that.  The whole thing is a mess because of the lego
going on.  It would probably be better to first patch the code into
shape so that it builds the displays in one step, and then translate
that.  As it stands, it's very hard to translate because wt-status.c
does not even let you reposition the number.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
