From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Thu, 16 May 2013 07:57:11 +0200
Message-ID: <CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
	<CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
	<51936218.9020306@ira.uka.de>
	<519370D3.3000306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 16 07:57:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcrBm-00045K-Ak
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 07:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab3EPF5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 May 2013 01:57:14 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59735 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab3EPF5N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 01:57:13 -0400
Received: by mail-wi0-f170.google.com with SMTP id hr14so6242684wib.5
        for <git@vger.kernel.org>; Wed, 15 May 2013 22:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=80xouW8BFMzUqNeCj7YdHr+D7dkdA9tvcM64dqvqLiU=;
        b=u+qTnjn43VDttnW04y+akr89k91zqMo1bQK0sIZQchB3MRFbllXumex9/z1D8PD+Zs
         OtbzI73byxrGYvWokgdU1Yl5mksepYjGzOg/uqSvK4+E61c9rWkG5vAf00tf5RLMscvz
         d8mRPoQ3iFYjxjWeMXfv8p3N38kxllgEUDeZoKduGwxTjQHmN6JJM6nF/TPmDQ5wk2kH
         M/UpmrsCxftOwvpcP4L6sXdscK5ajUx2qTRgaSoquCW+cGD8EM6U+fHxZEre9eNhFKA2
         cBT9OTbV1tFGgE0kbxxzbodMzX3bA2xYbDoUN6xcAiS6neUM2PupYCQVOF2Wnb/fO1Zu
         iPKg==
X-Received: by 10.180.14.129 with SMTP id p1mr21043224wic.6.1368683831868;
 Wed, 15 May 2013 22:57:11 -0700 (PDT)
Received: by 10.194.82.41 with HTTP; Wed, 15 May 2013 22:57:11 -0700 (PDT)
In-Reply-To: <519370D3.3000306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224481>

Hi,

I think the discussion might work better via ML than GitHub.
This is the full glossary of git's de.po as it would look
like with (hopefully) all the changes included that have been
discussed here. Still without any reasoning for decisions
(except HEAD).

Thanks for reading.

+Basic repository objects:
+
+    blob           =3D Blob
+    tree           =3D Baum, Baum-Objekt (bevorzugt), "Tree"-Objekt
+    submodule      =3D Submodul
+    pack(noun)     =3D Pack-Datei
+    pack(verb)     =3D packen (ggf. Pack-Datei erstellen)
+    ancestor       =3D Vorfahre, Vorg=C3=A4nger, Vorg=C3=A4nger-Commit=
 (bevorzugt)
+
+Content in a repository:
+
+    file(s)        =3D Datei(en)
+    tracked file   =3D beobachtete Datei
+    track file     =3D beobachte Datei
+    untracked file =3D unbeobachtete Datei
+    directory      =3D Verzeichnis
+
+Repositories / tracking concepts:
+
+    clone (verb)           =3D klonen
+    clone (noun)           =3D der Klon
+    repository             =3D Repository
+
+    bare repository        =3D blo=C3=9Fes Repository
+    working directory      =3D Arbeitsverzeichnis
+
+    remote branch          =3D externer Zweig
+    remote tracking branch =3D externer =C3=9Cbernahmezweig
+    upstream branch        =3D -||-
+    tracking branch        =3D =C3=9Cbernahmezweig
+
+    remote repository      =3D externes Repository
+    remote(noun)           =3D -||-
+    remote(adj)            =3D extern
+
+Authorship:
+
+    author    =3D Autor
+    committer =3D Commit-Ersteller
+    tagger    =3D Tag-Ersteller
+
+Commits, tags and other references:
+
+    HEAD           =3D HEAD
+ Konzept aus der Git-Welt, daher nicht zu =C3=BCbersetzen.
+    detached HEAD  =3D losgel=C3=B6ster HEAD
+
+    commit(noun)      =3D Commit
+    commit(verb)      =3D committen
+    commit the result =3D das Ergebnis committen
+    parent commit     =3D Eltern-Commit
+    child commit      =3D Kind-Commit
+    commit message    =3D Commit-Beschreibung
+
+    stash(noun)       =3D der Stash
+    stash(verb)       =3D "stashen", "stash" benutzen (bevorzugt)
+    unstash(verb)     =3D "unstashen", "zur=C3=BCckladen", "aus 'stash=
'
zur=C3=BCckladen" (bevorzugt)
+
+    reference      =3D Referenz
+    revision       =3D Commit
+    branch         =3D Zweig (or Branch)
+    tag(noun)      =3D Tag
+    tag(verb)      =3D taggen, Tag erstellen
+    annotated tag  =3D annotierter Tag
+    tag message    =3D Tag-Beschreibung
+
+    orphan commit    =3D
+    orphan reference =3D
+
+    boundary commit =3D Grenz-Commit
+    root commit     =3D Ursprungs-Commit, Wurzel-Commit
+
+    stage/index (noun) =3D Staging-Area, Index
+    stage/index (verb) =3D (f=C3=BCr einen | zum) Commit vormerken, zu=
r
Staging Area hinzuf=C3=BCgen, dem Index hinzuf=C3=BCgen
+    unstage (verb)     =3D aus Staging Area entfernen/nehmen, aus Inde=
x
entfernen/nehmen
+
+The DAG:
+
+    commit graph =3D Commit-Graph
+    merge =3D Merge
+
+References in relation to other references:
+
+    branches that have diverged =3D Zweige sind divergiert
+    diverging references        =3D divergierte Referenzen
+    your branch is ahead        =3D dein Zweig ist voraus
+    your branch is behind       =3D dein Zweig ist hinterher
+
+Moving data around:
+
+    fetch =3D anfordern
+    pull  =3D zusammenf=C3=BChren
+    push  =3D versenden
+
+    fast-forward     =3D vorspulen
+    non-fast-forward =3D nicht vorspulen
+
+Commands:
+
+    log                =3D Log
+    interactive commit =3D interaktiver Commit
+    cherry-pick        =3D "cherry-pick" benutzen
+    rebase(verb)       =3D "rebase" benutzen
+    rebase(noun)       =3D "rebase"
+    archive            =3D archivieren
+    revert             =3D zur=C3=BCcknehmen
+    clean(verb)        =3D
+    clean(noun)        =3D
+    merge              =3D mergen
+
+    bundle(noun)       =3D Paket
+    bundle(verb)       =3D Paket erstellen
+    unbundle(verb)     =3D Paket entpacken
+
+    bisect             =3D bin=C3=A4re Suche
+    bisecting          =3D bei einer bin=C3=A4ren Suche sein, bin=C3=A4=
re Suche durchf=C3=BChren
+
+Diff/patch related:
+
+    diff               =3D Differenz
+    delta              =3D Differenz (or Delta)
+    patch              =3D Patch
+    apply              =3D anwenden
+    diffstat           =3D (leave it as it is)
+    hunk               =3D Bereich
+    whitespace         =3D Leerzeichen (FIXME?) (maybe "Leerraum")
+
+Still being worked out:
+
+    prune              =3D veraltete(n) Zweig(e) entfernen
+    checkout(verb)     =3D auschecken
+
+    git add      =3D hinzuf=C3=BCgen
+
+    merge conflict =3D Merge-Konflikt
+    3-way merge    =3D 3-Wege-Merge
+    paths          =3D Pfade
+
+    symbolic link =3D symbolische Verkn=C3=BCfung
+    path =3D Pfad
+    link =3D Verkn=C3=BCpfung
+
+    reflog =3D Referenzprotokoll
+    partial commit =3D teilweise committen, partiell committen
+
+    reset =3D neu setzen (maybe "umsetzen"?)
+
+    register   =3D in die Konfiguration eintragen
+    unregister =3D aus der Konfiguration austragen
--
