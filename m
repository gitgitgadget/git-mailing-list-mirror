From: Christian Stimming <stimming@tuhh.de>
Subject: Re: RFC: German translation vocabulary
Date: Mon, 17 Sep 2007 21:45:26 +0200
Message-ID: <200709172145.26291.stimming@tuhh.de>
References: <200709161438.37733.stimming@tuhh.de> <87y7f6fjjl.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:52:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXMdc-0004fC-OZ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 21:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbXIQTvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758796AbXIQTvZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 15:51:25 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:45086 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758768AbXIQTvX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 15:51:23 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l8HJpJFs009043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 17 Sep 2007 21:51:19 +0200
Received: from [192.168.2.102] (p54901244.dip0.t-ipconnect.de [84.144.18.68])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l8HJpEHs009302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2007 21:51:18 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <87y7f6fjjl.fsf@mid.deneb.enyo.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58473>

Thanks for the replies so far. I'll summarize the proposals below, and =
I'll=20
take the freedom to reply to them directly.  (Note: Please CC: me on re=
plies=20
as I'm not subscribed to this list - too much traffic for me.)

One thing to keep in mind (one reader proposed to use "commit"=20
and "repository" in untranslated form): This translation is really abou=
t=20
translating the program, and the intended audience are those people who=
 are=20
*not* familiar with the English git terminology. Hence, I really really=
 want=20
to try hard to avoid untranslated terminology here. German really has e=
nough=20
words to choose from (just like every other language), so that it shoul=
d be=20
possible to avoid using untranslated English words just because we coul=
dn't=20
come up with German ones that fir.

> repository - Projektarchiv

Simon Richter thinks just "Archiv" would be fine as well in most places=
=2E=20
=46lorian Weimar says "Projekt" or "Archiv" should suffice. David Kastr=
up=20
agrees to this.

I think "Archiv" sounds quite unspecific, because it can be another roo=
m, or=20
another harddisk, or another directory. Whereas a git repository is=20
particular to this single git project. Also, when reading through the=20
TortoiseSVN docs, "Projektarchiv" worked quite nicely. I'd still stick =
to=20
this.

> revision - Version

=46lorian Weimar proposes "Versionsangabe". He thinks "revision" is mos=
t used as=20
a short form of "revision specifier".

I think in sentences like "let's switch the working copy from revision =
xyz to=20
revision abc" the word "Version" would work much better than any longer=
 form.=20
I'd stick to this, especially since this proposal came here from the ma=
iling=20
list already :-)

> staging area - Bereitstellung

Simon Richter remarks this German word is being used a translation=20
for "deployment", i.e. making binaries available to end users (however,=
 this=20
is probably specific to some particular development environment, isn't =
it?).=20
He thinks "Vorbereitung" would be better here. Florian Weimar=20
proposes "Index".

I think the word should have a connotation of "another place which is=20
separated from the working copy". The military term "Bereitstellung" IM=
HO=20
gives this rather nicely. I haven't seen that term in the ambiguous mea=
ning=20
Simon pointed out; is this a problem? As for "Index": As mentioned abov=
e it=20
should be possible to find a German word here.=20

> branch [noun] - Zweig

No comments to this one; it seems to be just fine.

> branch  [verb] - verzweigen

=46lorian Weimar mentiones "abzweigen", if it's used transitive.

In itself "abzweigen" is a nice word, but "verzweigen" gives more of th=
e=20
(desired) connotation of a tree's branches (uh oh! Linas will beat me f=
or=20
this! Of course this isn't a tree, it's a graph!) and hence for consist=
ency I=20
would stick to "verzweigen".

> working copy, working tree - Arbeitskopie

No comments to this one (or did I miss anyone); it seems to be just fin=
e.

> [commit] message - Meldung (Nachricht?; Source Safe: Kommentar)

David Soria first preferred "Kommentar". David Kastrup=20
proposes "Beschreibung", or later instead "Zusammenfassung", which then=
 David=20
Soria thinks is the best so far.

I think "Zusammenfassung" would rather describe what the diffstat is ab=
out, as=20
this summarizes the actual commit. As we're naming "the short text that=
=20
describes what this is about", I think actually "Beschreibung" is proba=
bly=20
best so far.

> msgid "checkout [noun]"
> msgstr "Auscheck? Ausspielung? Abruf? (Source Safe: Auscheckvorgang)"
>
> msgid "checkout [verb]"
> msgstr "auschecken? ausspielen? abrufen? (Source Safe: auschecken)"

Simon Richter proposed the long translation "Erstellung einer Arbeitsko=
pie"=20
(gets less awkward when you make proper sentences from it). Florian Wei=
mar=20
asks how's a checkout different from a working copy? But he wouldn't=20
translate "repository" and "commit", at least if they are used as nouns=
=2E

I agree with Simon Richter here, just as I've already explained in my i=
nitial=20
email: The noun should probably simply be the working copy, "Arbeitskop=
ie",=20
and the verb should be something with "Arbeitskopie erstellen". However=
, we=20
have strings like "Checkout this branch...", and those need yet another=
 word.=20
Maybe "Arbeitskopie umstellen"? I'm still unsure.

> msgid "commit [noun]"
> msgstr "=DCbertragung (Sendung?, =DCbergabe?, Einspielung?, Ablagevor=
gang?)"

Alexander Wuerstlein proposed "Vorgang" (think governmental German). Fl=
orian=20
Weimar proposes "Sammlung" and "sammeln", to which David Kastrup replie=
d it=20
doesn't fit because "sammeln" is what you do _before_ committing. In ad=
dition=20
David Kastrup proposes Buchung, Einbuchung, Verbuchung, Registrierung.=20
Alexander Wuerstlein proposes "Transaktion", to which David replied he=20
thinks "Transaktion" is anything with a permanent effect, so he finds t=
his=20
term too unspecific: it would equally well cover resetting, tagging, an=
d a=20
number of other things. (Also, it wouldn't work as a verb.)

I think we should try to replace this (the noun!) with "revision" and h=
ence=20
translate it as "Version". However, this needs to be checked in actual=20
strings in the program.

> msgid "commit [verb]"
> msgstr "=FCbertragen (TortoiseSVN: =FCbertragen; Source Safe: einchec=
ken;
> senden?, =FCbergeben?, einspielen?, einpflegen?, ablegen?)"

David Soria prefers "Einspielung" as he think it reflects better, that =
the
commit is locally. Simon Richter proposes "einspielen"? Problem is that=
 this=20
cannot be properly turned into a noun.

This verb appears on the one-word button "commit", which is obviously t=
he most=20
important button in git-gui. I think both "einspielen" and "=FCbertrage=
n" would=20
work in that context, but David Kastrup's proposals of "buchen"=20
or "verbuchen" and the others of "einpflegen", "ablegen" might also wor=
k. Yet=20
more proposals, or other hints which one of these would work best?

Thanks for all the suggestions. This should be thought about for a few =
more=20
days, and then I'll prepare an updated German glossary file to be commi=
tted=20
to the repository.

Regards,

Christian
