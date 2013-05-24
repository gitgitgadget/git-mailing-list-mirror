From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Fri, 24 May 2013 18:51:13 +0200
Message-ID: <CAN0XMOKwwDmq9WqrJDzknMCxT0AxkBKLYDwKeEN4vg+vzBwmTA@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
	<CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
	<51936218.9020306@ira.uka.de>
	<519370D3.3000306@web.de>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
	<CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	=?UTF-8?Q?Jan_Kr=C3=BC?= =?UTF-8?Q?ger?= <jk@jk.gs>,
	"Bernhard R. Link" <brl+git@mail.brlink.eu>,
	Jens Lehmann <jens.lehmann@web.de>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 18:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfvD5-000876-BX
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab3EXQvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 12:51:15 -0400
Received: from mail-vb0-f49.google.com ([209.85.212.49]:51201 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3EXQvO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 12:51:14 -0400
Received: by mail-vb0-f49.google.com with SMTP id q13so1024899vbe.36
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=852OvrJX384jH+cN0di8cZXSFv+b1YoRWU1xTuLnoas=;
        b=Y/XnJ5bPHyq4tgiluz4weIcuFW6VeiEURQZ18dhtskceHYb2H1rFR6h3it+WjR2UmW
         yaxM72hBC9CUL/8mIzxEZN4FpY5P9/LFst+S4YJ9OP3vnROlY7M77qO8nLoT3Pay2ci6
         94V1fKZjf+fqaL+dErrgT+5r5B35B1qM3T9gIwmOk6DPxOEDnfYRQPycUvvZ6zbHvpUz
         LgNZXNpdiyV6DodwpUYzFf3bJ2yf1GmCYYuMGoMl7UZ/HHKqpmTKHv6oae+rEiGj9MDK
         RY7kfnqbCC88MVLxzYLriJKD4UFXFt3rawjichr+B8og2u4Qu15zI48cx6BSGA8fBSoy
         Ghjw==
X-Received: by 10.220.104.135 with SMTP id p7mr9099044vco.10.1369414273608;
 Fri, 24 May 2013 09:51:13 -0700 (PDT)
Received: by 10.220.106.208 with HTTP; Fri, 24 May 2013 09:51:13 -0700 (PDT)
In-Reply-To: <CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225379>

Hi all,

thanks for all your comments. Here's an updated version of the glossary
including (hopefully) all the changes you've suggested.

Basic repository objects:

    blob           =3D Blob
    tree           =3D Baum-Objekt (bevorzugt), "Tree"-Objekt
    submodule      =3D Submodul
    pack(noun)     =3D Pack-Datei
    pack(verb)     =3D Pack-Datei erstellen
    ancestor       =3D Vorg=C3=A4nger-Commit

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
    stash(verb)       =3D "stash" benutzen
    unstash(verb)     =3D aus Stash zur=C3=BCckladen

    reference      =3D Referenz
    refspec        =3D (die) Refspec
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

    stage/index (noun) =3D Staging-Area
    stage/index (verb) =3D (f=C3=BCr einen | zum) Commit vormerken
    unstage (verb)     =3D aus Staging Area entfernen

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

When a message is referering to the command, e.g. in
error messages, we do not translate the term.
=46or example: "revert" ist fehlgeschlagen
When a message is referering to the thing the command
is doing, e.g. in help messages, we translate the term.
=46or example: "fordert von allen externen Projektarchiven an"
=46or some commands we currently don't have a sane translation
(e.g. "cherry-pick") so we don't translate it in any case.

    add(verb)           =3D hinzuf=C3=BCgen
    log                =3D Log
    interactive commit =3D interaktiver Commit
    cherry-pick        =3D "cherry-pick" benutzen
    rebase(verb)       =3D "rebase" benutzen
    rebase(noun)       =3D "rebase"
    archive            =3D archivieren
    revert             =3D zur=C3=BCcknehmen
    clean(verb)        =3D s=C3=A4ubern/aufr=C3=A4umen
    clean(noun)        =3D S=C3=A4uberung
    merge(verb)        =3D zusammenf=C3=BChren
    merge(noun)        =3D Zusammenf=C3=BChrung
    reset(verb)        =3D umsetzen
    reset(noun)        =3D der "reset"
("Umsetzung" would be too confusing.)
    apply              =3D anwenden

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
    diffstat           =3D Diffstat
    hunk               =3D Block (maybe "Patch-Block")
    whitespace         =3D Whitespace

Still being worked out:

    prune              =3D veraltete(n) Branch(es) entfernen
    checkout(verb)     =3D auschecken

    git add            =3D hinzuf=C3=BCgen

    merge conflict =3D Merge-Konflikt
    3-way merge    =3D 3-Wege-Merge
    paths          =3D Pfade

    symbolic link =3D symbolischer Verweis
    path =3D Pfad
    link =3D Verweis

    reflog =3D Referenzprotokoll
    partial commit (verb) =3D teilweise committen
    partial commit (noun) =3D Teil-Commit

    register   =3D in die Konfiguration eintragen
    unregister =3D aus der Konfiguration austragen
