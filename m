From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Sun, 19 May 2013 18:53:18 +0200
Message-ID: <CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
	<CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
	<51936218.9020306@ira.uka.de>
	<519370D3.3000306@web.de>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 19 18:53:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue6rO-0002LC-Cq
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 18:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab3ESQxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 12:53:22 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:40174 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab3ESQxU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 12:53:20 -0400
Received: by mail-we0-f169.google.com with SMTP id x54so4676054wes.0
        for <git@vger.kernel.org>; Sun, 19 May 2013 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=r9WmE22t9kZpyo+VmAfi0GHh3/ziCr1IyTqpselGZk8=;
        b=dPpiKjL+bFazDFWei+WxfbFDnBW0Z6TeRPLcKliKyeuqqXS+Y14WXVhYzfHUZbjVrt
         X+kPfrsg03cPPEs5L73JVtSQJ6ISbMuY9KlUDkmLMNN7RqZ/d9O56vAv2HFWClIMiUEc
         gzEQ2aC1UvJKb8GM0FHNSD9m5NbL7jM9rdJhMIGtnscZrMsvKZkm91IxHYCeuhoB1hSU
         PP6f7q1EOA/Z7WK6aDazPDU5IAdtNc9ylBHOVRV4zhkQrctszxIdIVkJUa9blwDONyUe
         OSATCxyMe1mKqPjl/beypShBfKFoUG3O+kKPjQVK//Cop8ZfNL+TqV12jbU7f0cbiBz9
         ot8Q==
X-Received: by 10.180.210.225 with SMTP id mx1mr6800731wic.15.1368982399036;
 Sun, 19 May 2013 09:53:19 -0700 (PDT)
Received: by 10.194.237.5 with HTTP; Sun, 19 May 2013 09:53:18 -0700 (PDT)
In-Reply-To: <CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224899>

Hi,

here's an updated version of the glossary. Comments are appreciated.

Basic repository objects:

    blob           =3D Blob
    tree           =3D Baum, Baum-Objekt (bevorzugt), "Tree"-Objekt
    submodule      =3D Submodul
    pack(noun)     =3D Pack-Datei
    pack(verb)     =3D packen (ggf. Pack-Datei erstellen)
    ancestor       =3D Vorfahre, Vorg=C3=A4nger, Vorg=C3=A4nger-Commit =
(bevorzugt)

Content in a repository:

    file(s)        =3D Datei(en)
    tracked file   =3D beobachtete Datei
    track file     =3D beobachte Datei
    untracked file =3D unbeobachtete Datei
    directory      =3D Verzeichnis

Repositories / tracking concepts:

    clone (verb)           =3D klonen
    clone (noun)           =3D der Klon
    repository             =3D Repository
    bare repository        =3D Bare Repository
    working directory      =3D Arbeitsverzeichnis
    working tree           =3D -||-

    remote branch          =3D Remote-Branch
    remote-tracking branch =3D Remote-Tracking-Branch
    upstream branch        =3D Upstream-Branch

    remote repository      =3D Remote-Repository
    remote(noun)           =3D -||-
    remote(adj)            =3D extern, entfernt liegend

Authorship:

    author    =3D Autor
    committer =3D Commit-Ersteller
    tagger    =3D Tag-Ersteller

Commits, tags and other references:

    HEAD           =3D HEAD
Konzept aus der Git-Welt, daher nicht zu =C3=BCbersetzen.
    detached HEAD  =3D losgel=C3=B6ster HEAD

    commit(noun)      =3D Commit
    commit(verb)      =3D committen
    commit the result =3D das Ergebnis committen
    parent commit     =3D Eltern-Commit
    child commit      =3D Kind-Commit
    commit message    =3D Commit-Beschreibung

    stash(noun)       =3D der Stash
    stash(verb)       =3D "stashen", "stash" benutzen (bevorzugt)
    unstash(verb)     =3D "unstashen", "zur=C3=BCckladen", "aus 'stash'
zur=C3=BCckladen" (bevorzugt)

    reference      =3D Referenz
    revision       =3D Commit
    branch         =3D Branch
    tag(noun)      =3D Tag
    tag(verb)      =3D taggen, Tag erstellen
    annotated tag  =3D annotierter Tag
    tag message    =3D Tag-Beschreibung

    orphan commit    =3D
    orphan reference =3D

    boundary commit =3D Grenz-Commit
    root commit     =3D Ursprungs-Commit, Wurzel-Commit

    stage/index (noun) =3D Staging-Area, Index
    stage/index (verb) =3D (f=C3=BCr einen | zum) Commit vormerken
(bevorzugt), zur Staging Area hinzuf=C3=BCgen, dem Index hinzuf=C3=BCge=
n
    unstage (verb)     =3D aus Staging Area entfernen, aus Index entfer=
nen

The DAG:

    commit graph =3D Commit-Graph
    merge =3D Merge

References in relation to other references:

    branches that have diverged =3D Branches sind divergiert
    diverging references        =3D divergierte Referenzen
    your branch is ahead        =3D Ihr Branch ist voraus
    your branch is behind       =3D Ihr Branch ist hinterher

Moving data around:

    fetch =3D anfordern
    pull  =3D zusammenf=C3=BChren
    push  =3D versenden

    fast-forward     =3D vorspulen
    non-fast-forward =3D nicht vorspulen

Commands:

    log                =3D Log
    interactive commit =3D interaktiver Commit
    cherry-pick        =3D "cherry-pick" benutzen
    rebase(verb)       =3D "rebase" benutzen
    rebase(noun)       =3D "rebase"
    archive            =3D archivieren
    revert             =3D zur=C3=BCcknehmen
    clean(verb)        =3D s=C3=A4ubern/aufr=C3=A4umen
    clean(noun)        =3D S=C3=A4uberung
    merge              =3D zusammenf=C3=BChren

    bundle(noun)       =3D Paket
    bundle(verb)       =3D Paket erstellen
    unbundle(verb)     =3D Paket entpacken

    bisect             =3D bin=C3=A4re Suche
    bisecting          =3D bei einer bin=C3=A4ren Suche sein, bin=C3=A4=
re Suche durchf=C3=BChren

Diff/patch related:

    diff               =3D Differenz
    delta              =3D Differenz (or Delta)
    patch              =3D Patch
    apply              =3D anwenden
    diffstat           =3D (leave it as it is)
    hunk               =3D Bereich
    whitespace         =3D Whitespace

Still being worked out:

    prune              =3D veraltete(n) Branch(es) entfernen
    checkout(verb)     =3D auschecken

    git add      =3D hinzuf=C3=BCgen

    merge conflict =3D Merge-Konflikt
    3-way merge    =3D 3-Wege-Merge
    paths          =3D Pfade

    symbolic link =3D symbolische Verkn=C3=BCfung
    path =3D Pfad
    link =3D Verkn=C3=BCpfung

    reflog =3D Referenzprotokoll
    partial commit (verb) =3D teilweise committen, partiell committen
    partial commit (noun) =3D Teil-Commit

    reset =3D neu setzen (maybe "umsetzen"?)

    register   =3D in die Konfiguration eintragen
    unregister =3D aus der Konfiguration austragen
