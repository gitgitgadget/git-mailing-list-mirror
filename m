From: Christian Stimming <stimming@tuhh.de>
Subject: RFC: German translation vocabulary
Date: Sun, 16 Sep 2007 14:38:37 +0200
Message-ID: <200709161438.37733.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 14:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWtPc-0005r6-9h
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 14:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbXIPMji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 08:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbXIPMjh
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 08:39:37 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:51711 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbXIPMjg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 08:39:36 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l8GCdY2x022299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 16 Sep 2007 14:39:34 +0200
Received: from [192.168.2.102] (p54903878.dip0.t-ipconnect.de [84.144.56.120])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l8GCdVVi016584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 16 Sep 2007 14:39:34 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58315>

Dear all,

as git-gui has now picked up the i18n features and the initial German=20
translation has been included as well, it is about time to discuss and=20
finalize the actual translation wordings of git terminology in German.=20

In particular, for all keywords of git and git-gui one needs to find=20
corresponding keywords in German, which will then be used consistently=20
throughout all of git-gui translations. Those keywords and (for some of=
 them)=20
their english definition are contained in the "glossary" file, see [1].=
 I=20
would like to invite all German-speaking readers here to review the Ger=
man=20
keyword translations that have been chosen in the glossary, and I'll de=
note=20
the most important ones below for immediate feedback.=20

(I'll mostly stick to an english discussion so that other languages can=
 use=20
this as a model on how to discuss this, if they want to.)

One word on the intended audience for the translated git-gui: The trans=
lated=20
form of git-gui is *not for you* :-). In other words, it is not intende=
d for=20
those who are reading this list and, by doing so, are completely famili=
ar=20
with all the English terminology of git. Instead, the translation is in=
tended=20
for German developers who know *some* English, but feel much more comfo=
rtable=20
with a fully German development environment and probably wouldn't touch=
 an=20
english-language git-gui anyway. Hence, the translation should try real=
ly=20
hard to find German words wherever possible.

Also, other version control systems have worked on their German transla=
tion as=20
well. If you want to check the wordings that have been chosen there, I'=
d=20
recommend looking into their translations [2].

I'll list the most important glossary terms here, starting with the eas=
ier=20
ones:

repository - Projektarchiv
revision - Version
staging area - Bereitstellung
branch [noun] - Zweig
branch  [verb] - verzweigen
working copy, working tree - Arbeitskopie
[commit] message - Meldung (Nachricht?; Source Safe: Kommentar)

=46or some of them you can see alternatives considered in the glossary =
[1], but=20
overall the above ones were rather easy. Now for the difficult ones:

commit [noun]=20
commit [verb]
checkout [noun]
checkout [verb]

I'm still rather unsure what to do about them. One problem here is that=
 both=20
words are used in several different meanings all at once. For example,=20
the "commit [noun]" is used interchangeably with "revision". I'm actual=
ly=20
inclined to translate it with "Version" for exactly that reason. And=20
then "checkout": The noun is probably used interchangeably with "workin=
g=20
copy". Hence, it could be translated as such. OTOH the verb means "to u=
pdate=20
the working copy", and it could be translated as such instead of one si=
ngle=20
word. This would leave only "commit [verb]" as the last tricky issue fo=
r=20
which a single-word translation must be found. "=FCbertragen" is my cur=
rent=20
favorite but I'm absolutely open for further proposals here.

As you can see in the glossary file, I'm still unhappy with the transla=
tions=20
for those, but anyway here's the current status (not taking into accoun=
t the=20
discussion of the previous paragraph so far):

msgid "checkout [noun]"
msgstr "Auscheck? Ausspielung? Abruf? (Source Safe: Auscheckvorgang)"

msgid "checkout [verb]"
msgstr "auschecken? ausspielen? abrufen? (Source Safe: auschecken)"

msgid "commit [noun]"
msgstr "=DCbertragung (Sendung?, =DCbergabe?, Einspielung?, Ablagevorga=
ng?)"

msgid "commit [verb]"
msgstr "=FCbertragen (TortoiseSVN: =FCbertragen; Source Safe: einchecke=
n; senden?,=20
=FCbergeben?, einspielen?, einpflegen?, ablegen?)"

Regards,

Christian Stimming


[1] http://repo.or.cz/w/git-gui.git?a=3Dblob_plain;f=3Dpo/glossary/de.p=
o;hb=3DHEAD=20
(note: the file is in UTF-8, but repo.or.cz's webserver claims it is la=
tin1,=20
hence the messed-up Umlauts)

[2]=20
* http://tortoisesvn.net/docs/release/TortoiseSVN_de/index.html (very g=
ood)
* http://msdn.microsoft.com/de-de/library/ms181038(vs.80).aspx (MS Visu=
al=20
Source Safe, commercial)
* http://cvsbook.red-bean.com/translations/german/Kap_06.html (not so g=
ood)
*=20
http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/de_DE=
=2Epo?view=3Dmarkup=20
(not so good)
* http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/de/rapidsvn.=
po=20
(username=3Dguest, password empty, quite bad)
