From: Christian Stimming <stimming@tuhh.de>
Subject: Re: German translations (was: [PATCH 3/5] Internationalization of git-gui)
Date: Sat, 21 Jul 2007 21:27:51 +0200
Message-ID: <200707212127.51840.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211437.43524.stimming@tuhh.de> <85ps2l98eq.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 21:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICKcG-0007X0-3P
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 21:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508AbXGUT1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jul 2007 15:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756720AbXGUT1o
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 15:27:44 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:49814 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbXGUT1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 15:27:43 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6LJRcVJ028676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 21:27:39 +0200
Received: from [192.168.2.102] (p5490088F.dip0.t-ipconnect.de [84.144.8.143])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6LJRaCi017869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 21:27:38 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <85ps2l98eq.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53181>

Am Samstag, 21. Juli 2007 15:46 schrieb David Kastrup:
> Christian Stimming <stimming@tuhh.de> writes:
> > And a new German translation, so far 100% but many more strings are=
 to
> > come.
>
> I have somewhat different proposals which sound less awkward, I
> think.  Of course, it is always a matter of taste whether a technical
> term should really be translated always, but assuming that, I'll make
> some German proposals.  Some may be tongue in cheek.

Thanks for additional word proposals. I'll discuss these and the two fo=
llowups=20
in German below.

> > +#: git-gui.sh:1627 git-gui.sh:1802 git-gui.sh:2134
> > +msgid "Commit"
> > +msgstr "=DCbertragen"
>
> Einpflegen ist als Verb gebr=E4uchlich, aber dann ist es schwer, ein
> passendes Substantiv zu finden.  "Sendung"?

Richtig - eine Kombination Substantiv/Verb wird ben=F6tigt. Ich habe im=
=20
Glossar "=FCbertragen (senden?, =FCbergeben?)". Ersteres wird bei Torto=
iseSVN=20
benutzt. Im Prinzip gehen die anderen auch; bei "Sendung"/"senden" bef=FC=
rchte=20
ich aber zu viele Mehrdeutigkeiten, wenn man z.B. davon redet. den comm=
it=20
=FCber TCP wohin senden will. Die Sendung wohin senden? Andererseits ha=
t man=20
bei =DCbertragung das gleiche Problem.

> > +#: git-gui.sh:1631
> > +msgid "Fetch"
> > +msgstr "Holen"
>
> Importieren (haupts=E4chlich, weil es zu Exportieren pa=DFt und Schie=
ben
> h=E4=DFlich ist)

Importieren ist bereits f=FCr "git-{cvs,svn}import" reserviert, kann al=
so hier=20
nicht verwendet werden. Deswegen wird was anderes ben=F6tigt. F=FCr fet=
ch und=20
pull gleicherma=DFen w=FCrden holen/ziehen/=FCbernehmen gehen und man m=
uss sich=20
halt auf eine Zuordnung festlegen.

> > +#: git-gui.sh:1632 git-gui.sh:2140
> > +msgid "Push"
> > +msgstr "Schieben"
>
> Exportieren

Dito - bereits reserviert f=FCr git-cvsexport u.=E4., also hier nicht b=
enutzbar.=20
Deswegen momentan dieses, ich bin aber auch nicht gl=FCcklich damit. Si=
ehe=20
Glossar: "schieben (hochladen? verschicken?)"

> > +#: git-gui.sh:1641
> > +msgid "Browse Current Branch"
> > +msgstr "Aktuellen Zweig durchbl=E4ttern"
>
> Im aktuellen Zweig st=F6bern.

st=F6bern f=FCr "to browse"? Das ist aber definitiv nicht das, was norm=
alerweise=20
als =DCbersetzung von "to browse" gew=E4hlt wird. Da ist man eben bei b=
l=E4ttern.=20
Au=DFerdem ist "st=F6bern" hart an der Grenze zur Flapsigkeit, die man =
(im=20
Gegensatz zum engl. Original) bei deutscher Software unbedingt vermeide=
n=20
muss.

> > +#: git-gui.sh:1659
> > +msgid "Compress Database"
> > +msgstr "Datenbank komprimieren"
>
> Ganz Deutsch: verdichten.

Alle E-Mail-Programme reden aber bereits von komprimieren (was in den M=
otoren=20
schon immer ein deutscher Begriff war), so dass ich hier auch dabei ble=
iben=20
w=FCrde.

> > +#: git-gui.sh:1662
> > +msgid "Verify Database"
> > +msgstr "Datenbank pr=FCfen"
>
> =FCberpr=FCfen (pr=FCfen w=E4re eher zu "checking")

"to verify" -> =FCberpr=FCfen? Ok.

> > +#: git-gui.sh:1709 git-gui.sh:2217 git-gui.sh:2354
> > +msgid "Select All"
> > +msgstr "Alle ausw=E4hlen"
>
> Alles ausw=E4hlen z=F6ge ich vor.

Kommt auf den Kontext an - was soll denn ausgew=E4hlt werden? "Alle Sen=
dungen"=20
oder "Alles, was sichtbar ist"...

> > +#: git-gui.sh:1724
> > +msgid "Checkout..."
> > +msgstr "Auschecken..."
>
> Ausspielung.

=C4h... nein. Auschecken ist auch nicht so toll (auch hier =FCbernommen=
 von=20
TortoiseSVN), aber was besseres hab ich noch nicht gefunden.

> > +#: git-gui.sh:2057
> > +msgid "Staged Changes (Will Be Committed)"
> > +msgstr "Bereitgestellte =C4nderungen (werden =FCbertragen)"
>
> Einzupflegende =C4nderungen

Nein, hier muss irgendwie die "staging area" mit auftauchen, denn so la=
utet=20
die Beschriftung der linken Listbox. Da ich die mit "Bereitstellung" ge=
w=E4hlt=20
habe, muss das Wort hier wieder auftauchen.=20

> > David Kastrup wrote:
> >>> +#: git-gui.sh:1798 git-gui.sh:2130 git-gui.sh:2228
> >>> +msgid "Sign Off"
> >>> +msgstr "Freizeichnen"
> >>
> >> Gegenzeichnen?
> >
> > Abzeichnen!
>
> Absegnen. =A0Ich denke mal, in der Form mit "Ab" ist das derma=DFen
> gebr=E4uchlich, da=DF man damit keine religi=F6sen Befindlichkeiten
> verletzt.
>
> Ansonsten: Abnicken oder Guthei=DFen.

Absegnen ist zu flapsig, Abnicken und Guthei=DFen erst recht. Gegenzeic=
hnen=20
l=E4sst nicht erahnen, dass man seine eigenen commits ja auch "sign off=
" soll=20
(wie z.B. in git.git/Documents/SubmittingPatches erkl=E4rt).  Abzeichne=
n w=E4re=20
okay, aber das ist Freizeichnen auch.

Gru=DF

Christian
