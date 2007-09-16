From: Michele Ballabio <barra_cuda@katamail.com>
Subject: RFC: Italian translation vocabulary
Date: Sun, 16 Sep 2007 22:11:16 +0200
Message-ID: <200709162211.16872.barra_cuda@katamail.com>
References: <200709161438.37733.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 22:08:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX0Q7-0008BT-BH
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 22:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbXIPUIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 16:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbXIPUIj
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 16:08:39 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:54395 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbXIPUIh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 16:08:37 -0400
Received: from host254-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.254]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.254+rb9aInuYQO7; Sun, 16 Sep 2007 22:08:33 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <200709161438.37733.stimming@tuhh.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58339>

[Thank you, Christian. I'll use your mail as a template for the
Italian speakers, as most issues apply here as well. For those
interested, s/German/Italian/ :). Appended there's a draft of the
Italian glossary.]

On Sunday 16 September 2007, Christian Stimming wrote:
> Dear all,
>=20
> as git-gui has now picked up the i18n features and the initial German=
=20
> translation has been included as well, it is about time to discuss an=
d=20
> finalize the actual translation wordings of git terminology in German=
=2E=20
>=20
> In particular, for all keywords of git and git-gui one needs to find=20
> corresponding keywords in German, which will then be used consistentl=
y=20
> throughout all of git-gui translations. Those keywords and (for some =
of them)=20
> their english definition are contained in the "glossary" file, see [1=
]. I=20
> would like to invite all German-speaking readers here to review the G=
erman=20
> keyword translations that have been chosen in the glossary, and I'll =
denote=20
> the most important ones below for immediate feedback.=20
>=20
> (I'll mostly stick to an english discussion so that other languages c=
an use=20
> this as a model on how to discuss this, if they want to.)
>=20
> One word on the intended audience for the translated git-gui: The tra=
nslated=20
> form of git-gui is *not for you* :-). In other words, it is not inten=
ded for=20
> those who are reading this list and, by doing so, are completely fami=
liar=20
> with all the English terminology of git. Instead, the translation is =
intended=20
> for German developers who know *some* English, but feel much more com=
fortable=20
> with a fully German development environment and probably wouldn't tou=
ch an=20
> english-language git-gui anyway. Hence, the translation should try re=
ally=20
> hard to find German words wherever possible.
>=20
> Also, other version control systems have worked on their German trans=
lation as=20
> well. If you want to check the wordings that have been chosen there, =
I'd=20
> recommend looking into their translations [2].
>=20
> I'll list the most important glossary terms here, starting with the e=
asier=20
> ones:

These are the terms currently used in it.po:

repository - archivio, repository
revision - revisione
staging area - area di preparazione
branch [noun] - ramo
branch [verb] - creare ramo (well, git-gui never uses "branch" as a ver=
b,
                actually)
working copy, working tree - directory di lavoro (git-gui uses the espr=
ession
                             "working directory")
[commit] message - messaggio
fetch - recuperare, prelevare

Note: in it.po, "repository" is sometimes left untranslated and sometim=
es
traslated as "archivio". Also, git-gui uses the term "database" too.
Should it be translated in the same way? Currently is left unchanged. W=
e
probably should use the same term throughout all the translation. The
same applies to "fetch"; which one is better: "recuperare" or "prelevar=
e"
(we currently use both)?

> For some of them you can see alternatives considered in the glossary =
[1], but=20
> overall the above ones were rather easy. Now for the difficult ones:
>
> commit [noun]=20
> commit [verb]
> checkout [noun]
> checkout [verb]

These are currently left untranslated in it.po. "commit [verb]" becomes
"effettuare un commit". Other SCM suggest "depositare" or "inviare". If=
 we
translate "repository" with "archivio" we may as well translate
"commit [verb]" with "archiviare".

> I'm still rather unsure what to do about them. One problem here is th=
at both=20
> words are used in several different meanings all at once. For example=
,=20
> the "commit [noun]" is used interchangeably with "revision". I'm actu=
ally=20
> inclined to translate it with "Version" for exactly that reason. And=20
> then "checkout": The noun is probably used interchangeably with "work=
ing=20
> copy". Hence, it could be translated as such. OTOH the verb means "to=
 update=20
> the working copy", and it could be translated as such instead of one =
single=20
> word. This would leave only "commit [verb]" as the last tricky issue =
for=20
> which a single-word translation must be found. "=FCbertragen" is my c=
urrent=20
> favorite but I'm absolutely open for further proposals here.

=46ollowing these advices, "commit [noun]" will be "revisione",
"checkout [noun]" "revisione attiva", and "checkout [verb]"
"attivare revisione".

> As you can see in the glossary file, I'm still unhappy with the trans=
lations=20
> for those, but anyway here's the current status (not taking into acco=
unt the=20
> discussion of the previous paragraph so far):

I've highlighted like *this* the terms currently used in it.po:

msgid "checkout [noun]"
msgstr "*checkout*, revisione attiva, prelievo (TortoiseCVS)?"

msgid "checkout [verb]"
msgstr "effettuare un checkout, attivare revisione, prelevare (Tortoise=
CVS),
ritirare (TSVN)?"

msgid "commit [noun]"
msgstr "*commit*, revisione, deposito (TortoiseCVS), invio (TSVN)?"

msgid "commit [verb]"
msgstr "*effettuare un commit*, archiviare, depositare (nel server),
fare un deposito (TortoiseCVS), inviare (TSVN)?"


Then, I think there are some problems regarding English terms
vs Git terms vs Italian terms.

E.g. these are the current translations:

reset - *ripristinare*, *annullare* (reset is used as a Git term,
        but with different meanings)
revert - *annullare* (Git term)
undo - *annullare* (English term)

I.e. there's an overlap: the same Italian word is used in three
different contexts (and two of them with different Git commands).
We should try to have an 1:1 relationship here. Or, at least,
more different terms in Italian than in Gittish :)


> [1]

See below an Italian glossary proposal.
=20
> [2]

* http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortois=
e_it.po
  (username=3Dguest, password empty)
* http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/it_=
IT.po?view=3Dmarkup
* http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/it_IT/rapids=
vn.po
  (username=3Dguest, password empty)

---
# Translation of git-gui glossary to Italian
# Copyright (C) 2007 Shawn Pearce, et al.
# This file is distributed under the same license as the git package.
# Christian Stimming <stimming@tuhh.de>, 2007
#
msgid ""
msgstr ""
"Project-Id-Version: git-gui glossary\n"
"PO-Revision-Date: 2007-07-29 16:24+0200\n"
"Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
"Language-Team: Italian \n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=3DUTF-8\n"
"Content-Transfer-Encoding: 8bit\n"

#. "English Definition (Dear translator: This file will never be visibl=
e to the user! It should only serve as a tool for you, the translator. =
Nothing more.)"
msgid ""
"English Term (Dear translator: This file will never be visible to the =
user!)"
msgstr ""
"Traduzione italiana.\n"
"Altri SCM in italiano:\n"
"  http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortoi=
se_it.po (username=3Dguest, password empty),\n"
"  http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/po/TortoiseCVS/it=
_IT.po?view=3Dmarkup ,\n"
"  http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/it_IT/rapid=
svn.po (username=3Dguest, password empty)"
"Le traduzioni evidenziate con '*' sono quelle correntemente utilizzate=
=2E"

#. ""
msgid "amend"
msgstr "correggere, correzione"

#. ""
msgid "annotate"
msgstr "annotare, annotazione"

#. "A 'branch' is an active line of development."
msgid "branch [noun]"
msgstr "*ramo*, diramazione, ramificazione"

#. ""
msgid "branch [verb]"
msgstr "creare ramo, ramificare, diramare"

#. ""
msgid "checkout [noun]"
msgstr "*checkout*, revisione attiva, prelievo (TortoiseCVS)?"

#. "The action of updating the working tree to a revision which was sto=
red in the object database."
msgid "checkout [verb]"
msgstr "effettuare un checkout, attivare revisione, prelevare (Tortoise=
CVS), ritirare (TSVN)?"

#. "A single point in the git history."
msgid "commit [noun]"
msgstr "*commit*, revisione, deposito (TortoiseCVS), invio (TSVN)?"

#. "The action of storing a new snapshot of the project's state in the =
git history."
msgid "commit [verb]"
msgstr "*effettuare un commit*, archiviare, depositare (nel server), fa=
re un deposito (TortoiseCVS), inviare (TSVN)?"

#. ""
msgid "diff [noun]"
msgstr "*differenza*, confronto, comparazione, raffronto"

#. ""
msgid "diff [verb]"
msgstr "confronta, mostra le differenze"

#. "A fast-forward is a special type of merge where you have a revision=
 and you are merging another branch's changes that happen to be a desce=
ndant of what you have."
msgid "fast forward merge"
msgstr "*fusione in 'fast-forward'*, fusione in avanti veloce"

#. "Fetching a branch means to get the branch's head from a remote repo=
sitory, to find out which objects are missing from the local object dat=
abase, and to get them, too."
msgid "fetch"
msgstr "*recuperare*, *prelevare*, prendere da, recuperare (TSVN)"

#. "A collection of files. The index is a stored version of your workin=
g tree."
msgid "index (in git-gui: staging area)"
msgstr "*indice*"

#. "A successful merge results in the creation of a new commit represen=
ting the result of the merge."
msgid "merge [noun]"
msgstr "*fusione*, unione"

#. "To bring the contents of another branch into the current branch."
msgid "merge [verb]"
msgstr "*effettuare la fusione*, unire, fondere, eseguire la fusione"

#. ""
msgid "message"
msgstr "*messaggio*, commento"

#. "Pulling a branch means to fetch it and merge it."
msgid "pull"
msgstr "prendi (recupera) e fondi (unisci)? (in pratica una traduzione =
di fetch + merge)"

#. "Pushing a branch means to get the branch's head ref from a remote r=
epository, and ... (well, can someone please explain it for mere mortal=
s?)"
msgid "push"
msgstr "*propaga*"

#. ""
msgid "redo"
msgstr "*ripeti*, rifai"

#. "A collection of refs (?) together with an object database containin=
g all objects which are reachable from the refs... (oops, you've lost m=
e here. Again, please an explanation for mere mortals?)"
msgid "repository"
msgstr "*archivio*, *repository*, database? deposito (rapidsvn)?"

#. ""
msgid "reset"
msgstr "*ripristinare*, *(annullare)*, azzerare, ripristinare"

#. ""
msgid "revert"
msgstr "*annullare*, inverti (rapidsvn), ritorna allo stato precedente,=
 annulla le modifiche della revisione"

#. "A particular state of files and directories which was stored in the=
 object database."
msgid "revision"
msgstr "*revisione* (TortoiseSVN)"

#. ""
msgid "sign off"
msgstr "*sign off*, firma"

#. ""
msgid "staging area"
msgstr "*area di preparazione*, zona di preparazione, modifiche in prep=
arazione? modifiche in allestimento?"

#. ""
msgid "status"
msgstr "stato"

#. "A ref pointing to a tag or commit object"
msgid "tag [noun]"
msgstr "*etichetta*, etichettatura (TortoiseCVS)"

#. ""
msgid "tag [verb]"
msgstr "etichettare"

#. "A regular git branch that is used to follow changes from another re=
pository."
msgid "tracking branch"
msgstr "*ramo in 'tracking'*, ramo inseguitore? ramo di {inseguimento,a=
llineamento,rilevamento,puntamento}?"

#. ""
msgid "undo"
msgstr "*annulla*"

#. ""
msgid "update"
msgstr "*aggiornamento*, *aggiornare*"

#. ""
msgid "verify"
msgstr "*verifica*, *verificare*"

#. "The tree of actual checked out files."
msgid "working copy, working tree"
msgstr "*directory di lavoro*, copia di lavoro"
