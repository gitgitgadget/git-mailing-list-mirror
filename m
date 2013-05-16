From: Christian Stimming <stimming@tuhh.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Thu, 16 May 2013 12:49:13 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <2181104.gkP5j47vG8@cs-pc>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	Ralph Haussmann <ralph@scanmyfood.de>, git@vger.kernel.org,
	Jan Engelhardt <jengelh@inai.de>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 16 12:49:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucvkc-0002N5-5O
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab3EPKta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 May 2013 06:49:30 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:55796 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3EPKt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 06:49:29 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id r4GAnIa8010899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 16 May 2013 12:49:18 +0200
Received: from cs-pc.localnet (g224015159.adsl.alicedsl.de [92.224.15.159])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id r4GAnHNM011390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 May 2013 12:49:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2013-20;
	t=1368701358; bh=9cspKKNjdpqvhAqHTLpWjAGAmIJMHwCvbZZqtl8v3Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ysj609yn8Z1Hsl+K2gknGUzMggjD+FmQEpLWgR32j0r613aP9OpgxJhettIxH3/Ut
	 kcyEjvpsNFergJ0gpts/Hl9KjPzSaMBoxEmv8DwkqhdHHoVqWVYMpo5T8JKZpT80Pk
	 ihXobdc+cUg8Nin44+X9OamaBNNG9oMJTcE3ll4k=
User-Agent: KMail/4.7.3 (Linux/3.0.0-32-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224553>

Dear translators,

Here's the main point in this discussion: The translation is not for us=
! The=20
translation is for those who don't speak much English and who don't kno=
w the=20
English git terminology very well. By definition, this target audience =
is not=20
present here on this mailing list and in this discussion. Hence, argume=
nts=20
such as "I like word x better" are rather weak. Instead, stating "Word =
x gives=20
the intended target audience a better picture of what is going on" is p=
robably=20
a better argument.

Am Montag, 13. Mai 2013, 14:54:51 schrieb Thomas Rast:
> However, an unfortunate and unsatisfactory situation has developed:
> Christian Stimming's git-gui de.po uses a Ger translation, and Ralf
> Thielow built core git's de.po on top of it, so it's also Ger.
>=20
> Meanwhile, and independently, Sven Fuchs and Ralph Haussmann wrote a
> translation of pro-git (which is also quite mature at this point, hav=
ing
> apparently begun in 2009), and as you probably guessed by now, it's G=
+E.

Thanks, Thomas, for spotting the conflicting translations in those exce=
llent=20
book projects vs. the git core and git gui. I think it's rather obvious=
 why=20
the pro-git translators chose the G+E approach for their work: Their go=
al is=20
to explain the command line usage of git, which means they inevitably h=
ave to=20
use the git command names, which happen to be in English (and will sure=
ly stay=20
so). Hence, any translation approach will have to deal with the English=
=20
command names as useful words in the normal translated text. That's pro=
bably a=20
constraint that is true for any translation of a command-line tool to s=
tay=20
useful.

I noticed with some amusement, though, that even in the pro-git book wi=
th the=20
described constraint there are places where a "pure Ger" translation is=
 almost=20
shining through... Such as in [1]: "Jedes Mal, wenn Du committest (d.h.=
 den=20
gegenw=E4rtigen Status deines Projektes als eine Version in Git speiche=
rst)..."=20
Can you notice how the translators identified "Version" as translation =
for=20
"commit (noun)" and "speichern" as translation for "commit (verb)" :-) =
? Of=20
course this is just the explanation and not the actual translation late=
r=20
during the text.=20

However, I take this spot as an example that there exist meaningful pur=
e-Ger=20
translations even for the most important git terminology. In fact, to f=
ind=20
useful Ger translations, I wonder how I would talk to someone from the =
target=20
audience a sentence such as "Finde mal den richtigen Commit, also die V=
ersion,=20
=2E.." When I find myself saying such an " - also das xy -" appendix of=
ten=20
enough, I take this as an indication that the latter word can just as w=
ell be=20
used as the main translation.

Back to the original question: I think the book shows quite nicely that=
 for=20
working with the git command line, a G+E translation is more useful as =
long as=20
the command names also appear unchangedly in the translation. However,=20
everything else that does not appear as a command name can be translate=
d=20
either in G+E or in Ger. The argument can go on to state that someone w=
ho is=20
geek enough to use the command line is probably more proficient in Engl=
ish=20
language anyway. Hence, using more English terms in the translation is=20
probably fine as well and a full G+E translation is probably a good app=
roach.=20

The pro-git book has some places where the translated word is not alway=
s used=20
consistently (e.g. in [2] "Externes Repository" vs. "Remote Repository"=
), and=20
some G+E suggestions from this mailing list have been translated Ger in=
 the=20
book (they use "zusammenf=FChren" in [2] and [3] instead of "merge" wit=
h only a=20
few exceptions). It is also a good point to make the pro-git and git co=
re=20
translation consistent, once the approach is decided on.

*However*: This argument is completely different when we talk about the=
 GUI=20
tools. The target audience of the git gui etc. are those developers who=
 write=20
great code, but #1 do not know the English language well enough, and #2=
 are so=20
far away from the geek corner that they use a development workflow pure=
ly in=20
GUI tools. The question is: What GUI button labels helps those people t=
he most=20
to get a good picture of what is going on? And in this case I still bel=
ieve a=20
pure Ger translation is the better choice! I wonder how feedback on thi=
s claim=20
can be collected from developers of the target audience. When I started=
 on the=20
git-gui translation, I asked some coworkers that fall into this categor=
y for=20
feedback on the wordings, and their response indicated agreement to my=20
approach. What feedback have others here heard from people who fall int=
o=20
described category? At the end of the day that sort of feedback has to =
be the=20
ground for a decision on the approach in the GUI translation.=20

In the meantime I think a different translation approach between git co=
re and=20
git gui is not a problem at all. For git gui I propose to stick to a Ge=
r=20
translation. For git core and the books that describe the command line=20
interface, a G+E translation is probably a good choice but even in this=
 case=20
there is room for useful German words instead of taking all difficult t=
erms=20
directly as English ones.=20

By the way, I'm puzzled why this sort of discussion appears only for Ge=
rman=20
language translations and not others. Don't other languages have the sa=
me=20
conflict of the English terms and potential translated words which are =
then=20
unknown to the geeks on this list? Just curious.

Best Regards,

Christian


[1] http://git-scm.com/book/de/Los-geht%27s-Git-Grundlagen
[2] http://git-scm.com/book/de/Git-Grundlagen-Mit-externen-Repositorys-
arbeiten
[3] http://git-scm.com/book/de/Git-Branching-Basic-Branching-and-Mergin=
g
