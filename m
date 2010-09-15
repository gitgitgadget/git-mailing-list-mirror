From: Peter Krefting <peter@softwolves.pp.se>
Subject: RE: [PATCH 2/2] Add Swedish translation.
Date: Wed, 15 Sep 2010 11:24:47 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se>
References: <20100912202111.B11522FC00@perkele> <A612847CFE53224C91B23E3A5B48BAC749BF60444B@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Swedish <tp-sv@listor.tp-sv.se>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 12:25:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvpAv-0008Ak-W4
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 12:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab0IOKZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 06:25:06 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:40038 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751523Ab0IOKZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 06:25:04 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8FAOmf3025578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 Sep 2010 12:24:48 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o8FAOlZr025572;
	Wed, 15 Sep 2010 12:24:48 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC749BF60444B@xmail3.se.axis.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 15 Sep 2010 12:24:48 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156228>

Peter Kjellerstedt:

> Mainly comments on the Swedish translation below, but there are a few=
=20
> references to the English messages as well.

Thanks.

Cc'ing TP-SV as I posted the translation for review there as well.

>> +#: wt-status.c:100
>> +msgid "#   (commit or discard the untracked or modified content in =
submodules)"
>> +msgstr "#   (checka in eller f=F6rkasta osp=E5rat eller =E4ndrat in=
neh=E5ll i undermoduler)"
> Wouldn't "f=F6lja" be a better translation than "sp=E5ra" for "track"=
?

Yeah, perhaps it would. We already use "sp=E5ra" in the git-gui/gitk=20
translations, though, so it needs to be changed everywhere.

> [cut]
>
>> +#: builtin/add.c:41
>> +#, c-format
>> +msgid "unexpected diff status %c"
>> +msgstr "diff-status %c f=F6rv=E4ntades inte"
> "ov=E4ntad diff-status %c" ?

Changed.

>> +#: builtin/add.c:77
>> +#, c-format
>> +msgid "remove '%s'\n"
>> +msgstr "ta bort \"%s\"\n"
> Any particular reason to change ' to " in the Swedish translation?

Yes, Swedish usually uses double-quotes, while English often uses singl=
e.

> +#: builtin/add.c:191
> +msgid "Unstaged changes after refreshing the index:"
> +msgstr "Osp=E5rade =E4ndringar efter att ha uppdaterat indexet:"
> "Osp=E5rade" -> "Icke-k=F6ade"

Changing to "ok=F6ade".

>> +#: builtin/archive.c:17
>> +#, c-format
>> +msgid "could not create archive file '%s'"
>> +msgstr "Kunde inte skapa arkivfilen \"%s\""
> "Kunde" -> "kunde"

=46ixed.

>> +#: builtin/branch.c:136
>> +#, c-format
>> +msgid ""
>> +"deleting branch '%s' that has been merged to\n"
>> +"         '%s', but it is not yet merged to HEAD."
>> +msgstr ""
>> +"tar bort grenen \"%s\" som inte har slagits ihop med\n"
> Remove "inte".

=46ixed.

>> +"         \"%s\", men som =E4nnu inte slagits ihop med HEAD."
>> +
>> +#: builtin/branch.c:140
>> +#, c-format
>> +msgid ""
>> +"not deleting branch '%s' that is not yet merged to\n"
>> +"         '%s', even though it is merged to HEAD."
>> +msgstr ""
>> +"tar inte bort grenen \"%s\" som inte har slagits ihop med\n"
> "som inte" -> "som =E4nnu inte"

=46ixed.

>> +#: builtin/branch.c:198
>> +#, c-format
>> +msgid "Couldn't look up commit object for '%s'"
>> +msgstr "Kunde inte sl=E5 upp incheckningsobjekt f=F6r \"%s\""
> "incheckningsobjekt" -> "incheckningsobjektet"?

=46ixed.

>> +#: builtin/branch.c:557
>> +msgid "cannot rename the current branch while not on any."
>> +msgstr "kunde inte byta namn p=E5 aktuell gren n=E4r du inte befinn=
er dig p=E5 n=E5gon."
> "kunde" -> "kan"

=46ixed.

>> +#: builtin/branch.c:567 builtin/branch.c:571
>> +#, c-format
>> +msgid "Invalid branch name: '%s'"
>> +msgstr "Felaktigt namn p=E5 gren: \"%s\""
> "namn p=E5 gren" -> "grennamn"

Changed. I thought mine was easier to read, though :-)

>> +#: builtin/branch.c:574
>> +#, c-format
>> +msgid "A branch named '%s' already exists."
>> +msgstr "Det finns redan en gren som heter \"%s\""
> Add missing period.

=46ixed.

>> +#: builtin/checkout.c:554
>> +#, c-format
>> +msgid "Switched to and reset branch '%s'\n"
>> +msgstr "V=E4xlade till och nollst=E4llde grenen \"%s\"\n"
> "V=E4xlade" -> "Bytte" ?

Changed "v=E4xla" to "byta" globally.

>> +#: builtin/checkout.c:603
>> +msgid "You are on a branch yet to be born"
>> +msgstr "Du =E4r p=E5 en gren som =E4nnu inte =E4r f=F6dd"
> "=E4r f=F6dd" -> "finns" ?

Yes, sounds better. Changed.

>> +#: builtin/checkout.c:744
>> +msgid "--track needs a branch name"
>> +msgstr "--track beh=F6ver ett namn p=E5 en gren"
> "namn p=E5 en gren" -> "grennamn"

Changed.

>> +#: builtin/checkout.c:757
>> +msgid "--orphan and -b|-B are mutually exclusive"
>> +msgstr "--orphan och --b|-B kan inte anv=E4ndas samtidigt"
> "--b" -> "-b"

=46ixed.

>> +#: builtin/checkout.c:904
>> +#, c-format
>> +msgid "git checkout: we do not like '%s' as a branch name."
>> +msgstr "git checkout: vi tycker inte om \"%s\" som namn p=E5 en gre=
n."
> "namn p=E5 en gren" -> "grennamn"

=46ixed.

>> +#: builtin/commit.c:380
>> +msgid "cannot do a partial commit during a merge."
>> +msgstr "kan inte utf=F6ra en delvis incheckning under en sammanslag=
ning."
> "delvis" -> "partiell"

Is that better? Sounds a bit to technical to me.

>> +#: builtin/commit.c:456 builtin/commit.c:1294
>> +msgid "could not parse HEAD commit"
>> +msgstr "kunde inte tolka HEAD:s incheckning"
> "HEAD:s incheckning" -> "HEAD-incheckningen" ?

Yeah, probably better. Changed the other "HEAD:s" translation as well.

>> +#: builtin/commit.c:650
>> +#, c-format
>> +msgid ""
>> +"#\n"
>> +"# It looks like you may be committing a MERGE.\n"
>> +"# If this is not correct, please remove the file\n"
>> +"#\t%s\n"
>> +"# and try again.\n"
>> +"#\n"
>> +msgstr ""
>> +"#\n"
>> +"# Det verkar som du checkar in en SAMMANSLAGNING.\n"
>> +"# Om det inte st=E4mmer tar du bort filen\n"
>> +"#\t%s\n"
>> +"# och f=F6rs=F6ker igen.\n"
>> +"#\n"
> "tar du bort filen" -> "s=E5 ta bort filen" and
> "f=F6rs=F6ker" -> "f=F6rs=F6k".

OK. Changed.

>> +#: builtin/commit.c:659
>> +#, c-format
>> +msgid ""
>> +"\n"
>> +"# Please enter the commit message for your changes."
>> +msgstr ""
>> +"\n"
>> +"# Ange ett incheckningsmeddelande f=F6r dina =E4ndringar."
>> +
>> +#: builtin/commit.c:663
>> +#, c-format
>> +msgid ""
>> +" Lines starting\n"
>> +"# with '#' will be ignored, and an empty message aborts the commit=
=2E\n"
>> +msgstr ""
>> +" Rader som inleds\n"
>> +"# med \"#\" kommer ignoreras, och ett tomt meddelande avbryter inc=
heckningen.\n"
>> +""
> "kommer ignoreras" -> "kommer att ignoreras"

Changed. Now just fits in <80 characters.

>> +#: builtin/commit.c:668
>> +#, c-format
>> +msgid ""
>> +" Lines starting\n"
>> +"# with '#' will be kept; you may remove them yourself if you want =
to.\n"
>> +"# An empty message aborts the commit.\n"
>> +msgstr ""
>> +" Rader som inleds\n"
>> +"# med \"#\" kommer beh=E5llas; du kan sj=E4lv ta bort dem om du vi=
ll.\n"
>> +"# Ett tomt meddelande avbryter incheckningen.\n"
> "kommer beh=E5llas" -> "kommer att beh=E5llas"

Changed.

>> +#: builtin/commit.c:737
>> +msgid "Error building trees"
>> +msgstr "Fel vid byggande av tr=E4d"
> "byggande av tr=E4d" -> "tr=E4dbygge" ?

That sounds even weirder to me.

>> +#: builtin/commit.c:752 builtin/tag.c:321
>> +#, c-format
>> +msgid "Please supply the message using either -m or -F option.\n"
>> +msgstr "Ange meddelandet en av flaggorna -m eller -F.\n"
> "meddelandet en" -> "meddelandet med en"

=46ixed.

>> +#: builtin/commit.c:880
>> +msgid "You are in the middle of a merge -- cannot amend."
>> +msgstr "Du =E4r i mitten av en incheckning -- kan inte ut=F6ka."
> "incheckning" -> "ihopslagning"

Good catch. Using "sammanslagning" as elsewhere.

>> +#: builtin/commit.c:941
>> +msgid "Clever... amending the last one with dirty index."
>> +msgstr "Smart... ut=F6ka den senaste med smutsigt index."
>> +
>> +#: builtin/commit.c:943
>> +msgid "Explicit paths specified without -i nor -o; assuming --only =
paths..."
>> +msgstr "Explicita s=F6kv=E4gar angavs utan -i eller -o; antar --onl=
y-paths..."
> "--only-paths" -> "--only-s=F6kv=E4gar"

Oh... Good catch.

>> +#: builtin/commit.c:1142
>> +msgid "couldn't look up newly created commit"
>> +msgstr "kunde inte sl=E5 upp en precis skapad incheckning"
> "sl=E5 upp" -> "hitta" ? I have seen this translation for lookup
> in some other places, and I think "hitta" is a better translation.

Yeah.

> "precis skapad" -> "nyskapad"

Both changed.

>> +#: builtin/commit.c:1375
>> +msgid "cannot lock HEAD ref"
>> +msgstr "kunde inte l=E5sa HEAD-referens"
>
> "kunde" -> "kan"
> "referens" -> "referensen" ?

Changed (in both).

>> +#: builtin/describe.c:205
>> +#, c-format
>> +msgid "annotated tag %s not available"
>> +msgstr "den dekorerade taggen %s inte tillg=E4nglig"
> "dekorerade" -> "annoterade"

Is that a word?

>> +#: builtin/fetch.c:230
>> +msgid "[up to date]"
>> +msgstr "[=E0jour]"
> "[=E0jour]" -> "[=E0 jour]" ?

Changed.

>> +#: builtin/fetch.c:325 builtin/fetch.c:648
>> +#, c-format
>> +msgid "cannot open %s: %s\n"
>> +msgstr "kan inte =F6ppna %s. %s\n"
> "%s." -> "%s:"

=46ixed.

>> +#: builtin/fetch.c:917
>> +msgid "Fetching a group and specifying refspecs does not make sense=
"
>> +msgstr "Kan inte h=E4mta fr=E5n grupp och ange referensspecifikatio=
ner"
> "fr=E5n" -> "en" ?

Well, I was thinking "fetch" -> "h=E4mta fr=E5n", and just dropped the =
"en".

>> +#: builtin/gc.c:63
>> +#, c-format
>> +msgid "Invalid %s: '%s'"
>> +msgstr "Felaktigt %s: \"%s\""
> I think this should be "Felaktig". This could use a TRANSLATORS
> comment to avoid having to check the code to find out what the
> first %s is referring to.

OK, changing.

>> +#: builtin/grep.c:252
>> +#, c-format
>> +msgid "grep: failed to create thread: %s"
>> +msgstr "grep: misslyckades skapa tr=E5d. %s"
> "." -> ":"

=46ixed.

>> +#: builtin/grep.c:581
>> +#, c-format
>> +msgid "Failed to chdir: %s"
>> +msgstr "Kunde inte byta katalog (chdir): %s"
> I think you can skip the " (chdir)" explanation without=20
> loss of information.

As long as the original string uses the system call reference, and not =
the=20
action, I will keep it in the translation.

>> +#: builtin/grep.c:703
>> +#, c-format
>> +msgid "unable to grep from object of type %s"
>> +msgstr "Kunde inte \"grep\" fr=E5n objekt av typen %s"
> "\"grep\"" -> "greppa" ?

That's a word that means something else... I don't really have any good=
 idea=20
on how to translate "grep" when used as a verb...

>> +#: builtin/grep.c:755
>> +#, c-format
>> +msgid "switch `%c' expects a numerical value"
>> +msgstr "flaggan \"%c\" antar ett numeriskt v=E4rde"
> "antar" -> "f=F6rv=E4ntar sig"

Changed (without "sig").

>> +#: builtin/init-db.c:34
>> +#, c-format
>> +msgid "Could not make %s writable by group"
>> +msgstr "Kunde inte g=F6ra %s skrivbar f=F6r grubben"
> "grubben" -> "gruppen"

=46ixed.

>> +#: builtin/init-db.c:79
>> +#, c-format
>> +msgid "cannot opendir '%s'"
>> +msgstr "kan inte =F6ppna katalogen (opendir) \"%s\""
> Skip " (opendir)".
>
>> +#: builtin/init-db.c:96
>> +#, c-format
>> +msgid "cannot readlink '%s'"
>> +msgstr "kan inte l=E4sa l=E4nk (readlink) \"%s\""
> "l=E4nk (readlink)" -> "l=E4nken"

Keeping them for the same reason as above. Changing "l=E4nk" to "l=E4nk=
en",=20
though.

>> +#: builtin/init-db.c:357
>> +msgid " shared"
>> +msgstr " delat"
> " delat" -> " och delat" ?

OK.

>> +#: builtin/init-db.c:376
>> +msgid "cannot tell cwd"
>> +msgstr "kan inte l=E4sa aktuell katalog (cwd)"
> "l=E4sa aktuell katalog (cwd)" -> "avg=F6ra aktuell katalog"

Changing, but keeping cwd as above.

>> +#: builtin/log.c:630
>> +msgid "name of output directory is too long"
>> +msgstr "namn p=E5 utdatakatalogen =E4r f=F6r l=E5ng"
> "namn" -> "namnet"
> "l=E5ng" -> "l=E5ngt"

I think this is where I started to get a bit tired :-)

=46ixed.

>> +#: builtin/log.c:825
>> +#, c-format
>> +msgid "insane in-reply-to: %s"
>> +msgstr "tokigt in-reply-to: %s"
> "tokigt" -> "tokig"

My sense of language says that it should be "neutrum", so "tokigt".

>> +#: builtin/log.c:1166
>> +msgid "standard output, or directory, which one?"
>> +msgstr "standard ut, eller katalog, vilken skall det vara?"
> "vilken" -> "vilket" ?

=46ixed.

>> +#: builtin/merge.c:223
>> +msgid "could not run stash."
>> +msgstr "kunde k=F6ra stash."
> "kunde k=F6ra" -> "kund inte k=F6ra"

=46ixed.

>> +#: builtin/merge.c:396
>> +#, c-format
>> +msgid "'%s' does not point to a commit"
>> +msgstr "\"%s\" verkar inte peka p=E5 en incheckning"
> "verkar inte peka " -> "pekar inte

=46ixed.

>> +#: builtin/merge.c:651
>> +#, c-format
>> +msgid "Unknown option for merge-recursive: -X%s"
>> +msgstr "Felaktig flagga f=F6r merge-recursive: -X%s"
> "merge-recursive" -> "rekursiv ihopslagning" ?

No, merge-recursive is a name of a merge strategy.

>> +#: builtin/merge.c:1271
>> +#, c-format
>> +msgid "Using the %s to prepare resolving by hand.\n"
>> +msgstr "Anv=E4nder %s f=F6r att f=F6rbereda l=F6sning f=F6r hand.\n=
"
> "%s" -> "strategin %s" ?

Yeah. The English string should probably also be fixed, though.

>> +#: builtin/mv.c:206
>> +#, c-format
>> +msgid "Renaming %s to %s\n"
>> +msgstr "Byter namn p=E5 %s till %s\n"
> "Byter namn p=E5" -> "D=F6per om" ?

I've used "byta namn" in other places, so if I change here, I should ch=
ange=20
it globally.

>> +#: builtin/mv.c:209
>> +#, c-format
>> +msgid "renaming '%s' failed"
>> +msgstr "misslyckades byta namn p=E5 \"%s\""
> "namnbytet av \"%s\" misslyckades"

Changed.

>> +#: builtin/notes.c:122
>> +#, c-format
>> +msgid "unable to start 'show' for object '%s'"
>> +msgstr "kunde int estarta \"show\" f=F6r objektet \"%s\""
> "int estarta" -> "inte starta"

=46ixed.

>> +#: builtin/notes.c:128
>> +msgid "can't fdopen 'show' output fd"
> Horrible English error message...

Yeah.

>> +#: builtin/notes.c:234 builtin/tag.c:445
>> +#, c-format
>> +msgid "cannot read '%s'"
>> +msgstr "kunde inte l=E4sa \"%s\""
> "kunde" -> "kan"

=46ixed.

> "list" -> "lista" (assuming this is the first argument to the message=
 from=20
> builtin/notes.c:481 above.)

As I mentioned in 1/2, I though these were used as command names (as on=
e of=20
them was unified with a command name that I removed). I will try fixing=
 these.

>> +#: builtin/push.c:77
>> +#, c-format
>> +msgid "The current branch %s is tracking multiple branches, refusin=
g
>> to push."
>> +msgstr "Den aktuella grenen %s sp=E5rar flera grenar, v=E4grar s=E4=
nda."
> "s=E4nda" -> "trycka iv=E4g" ?

"Trycka iv=E4g" sounds horrible, IMHO. I used "S=E4nd" in the git-gui=20
translation of "Push". As long as git doesn't grow a "git send" command=
, I=20
think that should be OK.

>> +#: builtin/push.c:132
>> +#, c-format
>> +msgid ""
>> +"To prevent you from losing history, non-fast-forward updates were =
rejected\n"
>> +"Merge the remote changes (e.g. 'git pull') before pushing again.  =
See the\n"
>> +"'Note about fast-forwards' section of 'git push --help' for detail=
s.\n"
>> +msgstr ""
>> +"F=F6r att f=F6rhindra att du tappar historik har icke snabbspoland=
e uppdateringar\n"
>> +"avvisats. Sl=E5 ihop fj=E4rr=E4ndringarna (t.ex \"git pull\") inna=
n du s=E4nder igen.\n"
>> +"Se avsnittet \"Note about fast-forward\" i \"git push --help\" f=F6=
r detaljer.\n"
> "icke snabbspolande" -> "icke-snabbspolande"

Changed.

> "t.ex" -> "t ex"

I think it looks clearer with the full stop.

>> +#: builtin/reset.c:97
>> +msgid "Failed to find tree of HEAD."
>> +msgstr "Kunde inte hitta tr=E4der f=F6r HEAD."
> "tr=E4der" -> "tr=E4det"

=46ixed (both of them).

>> +#: builtin/reset.c:307
>> +#, c-format
>> +msgid "Could not parse object '%s'."
>> +msgstr "Kan inte tolka objektet \"%s\""
> "Kan" -> "Kunde"

=46ixed.

>> +#: builtin/reset.c:321
>> +msgid "--mixed with paths is deprecated; use 'git reset -- <paths>'=
 instead."
>> +msgstr "--mixed rekommenderas inte med s=F6kv=E4gar; anv=E4nd \"git=
 reset -- <s=F6kv=E4gar>\"."
> "." -> " ist=E4llet."

I dropped it to fit an 80 character line.

>> +#: builtin/revert.c:270
>> +#, c-format
>> +msgid "Error wrapping up %s"
>> +msgstr "Fel vid ombrytning av %s"
>
> I do not think this "wrapping up" refers to reformatting of the commi=
t=20
> message. I think it refers to finishing writing the message (a rephra=
sing=20
> of the English message is advisable). Thus the Swedish translation sh=
ould=20
> probably be:
>
> "Fel vid avslutandet av %s"

Are you sure about that? I was unable to figure it out when I looked at=
 it.

>> +#: builtin/revert.c:290
>> +msgid ""
>> +"Your local changes would be overwritten by revert.\n"
>> +"Please, commit your changes or stash them to proceed."
>> +msgstr ""
>> +"Dina lokala =E4ndringar skulle skrivas =F6ver av \"revert\".\n"
>> +"Checka in dina =E4ndringar eller anv=E4nd \"stash\" f=F6r att fort=
s=E4tta."
> "stash" -> "git stash" ?

Changed (both).

>> +#: builtin/revert.c:449
>> +#, c-format
>> +msgid "Mainline was specified but commit %s is not a merge."
>> +msgstr "Huvudlinje angavs, men incheckningen %s =E4r inte en
>> sammanslagning"
> "Huvudlinje" -> "Huvudsp=E5r" ?

Changing, fits closer to the railway analogy.

>> +#: builtin/rm.c:118
>> +#, c-format
>> +msgid ""
>> +"'%s' has staged content different from both the file and the HEAD\=
n"
>> +"(use -f to force removal)"
>> +msgstr ""
>> +"\"%s\" har k=F6at =E4ndringar som skiljer sig b=E5de fr=E5n filen =
och HEAD\n"
>> +"(anv=E4nd -f f=F6r att tvinga borttagning)"
> "k=F6at" -> "k=F6ade"

"%s" expands to a file name, so you are right. It is "%s" that contains=
 the=20
changes, not "%s" that has staged them.

>> +#: builtin/shortlog.c:161
>> +#, c-format
>> +msgid "Missing author: %s"
>> +msgstr "Saknad f=F6rfattare: %s"
> "Saknad" -> "Saknar"

I think "missing" it is an adjective and not a verb here. The message i=
s=20
clear either way.

>> +#: builtin/tag.c:123 builtin/tag.c:464
>> +#, c-format
>> +msgid "tag name too long: %.*s..."
>> +msgstr "taggnamnet f=F6r l=E5ngt: %.*s..."
> "taggnamnet f=F6r" -> "taggnamnet =E4r f=F6r"

Changed. Should probably be changed in English as well.

>> +#: builtin/tag.c:170
>> +msgid "committer info too long."
>> +msgstr "incheckarinformation f=F6r l=E5ng."
> "incheckarinformation f=F6r" -> "incheckarinformation =E4r f=F6r"

Changed. Bad English again.

>> +#: builtin/tag.c:196
>> +msgid "gpg did not accept the tag data"
>> +msgstr "gpg godtog inte taggdata"
> "taggdata" -> "taggdatan"

"taggdatana" in that case. "data" is always plural.

>> +#: builtin/tag.c:203
>> +msgid "gpg failed to sign the tag"
>> +msgstr "gpg misslyckades signera taggen"
> "signera" -> "att signera"

=46ixed.

>> +#: builtin/tag.c:226
>> +#, c-format
>> +msgid "signing key value too long (%.10s...)"
>> +msgstr "signeringsnyckelv=E4rdet f=F6r l=E5ngt (%.10s...)"
> "f=F6r" -> "=E4r f=F6r"

=46ixed.

>> +#: builtin/tag.c:302
>> +msgid "tag header too big."
>> +msgstr "tagghuvud f=F6r stort."
> "tagghuvud f=F6r stort." - "f=F6r stort tagghuvud."

Changed.

>> +#: builtin/tag.c:335
>> +#, c-format
>> +msgid "The tag message has been left in %s\n"
>> +msgstr "Taggmeddelandet har l=E4mnats i %s\n"
> "l=E4mnats" -> "l=E4mnats kvar"

Much better. Changed.

>> +#: builtin/tag.c:428
>> +msgid "-n option is only allowed with -l."
>> +msgstr "Flaggan -n =E4r endast till=E5ten tillsammans med -l."
> "Flaggan" -> "flaggan" (guess based on other error messages)

Yes, changed (both).

>> +#: git-am.sh:120
>> +msgid ""
>> +"Did you hand edit your patch?\n"
>> +"It does not apply to blobs recorded in its index."
>> +msgstr ""
>> +"Vill du handredigera din patch?\n"
>> +"Den kan inte appliceras p=E5 blobbar som antecknats i dess index."
> "Vill du handredigera" -> "Handredigerade du"

=46ixed.

> "antecknats" -> "finns"

That's ambiguous. Changed second sentence to:
"Den kan inte appliceras p=E5 de blobbar som beskrivs i dess index."

--=20
\\// Peter - http://www.softwolves.pp.se/
