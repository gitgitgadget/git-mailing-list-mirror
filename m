From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: AW: English/German terminology, git.git's de.po, and pro-git
Date: Tue, 14 May 2013 19:51:40 +0200
Message-ID: <CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>, jens.lehmann@web.de
To: Jan Engelhardt <jengelh@inai.de>, Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 14 19:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJO8-0005pT-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 19:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760Ab3ENRvo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 May 2013 13:51:44 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:52556 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab3ENRvn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 May 2013 13:51:43 -0400
Received: by mail-wg0-f54.google.com with SMTP id x12so790248wgg.9
        for <git@vger.kernel.org>; Tue, 14 May 2013 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=1AivOuoyDwJBGdLcUvmLX9Pewp8nHApQEYpYB0Tni6g=;
        b=c6brn78huTTh3UTjW85eUBnlVFrQxxwxf/j+d1FzWFOYxY8Jz+OaOp6yKKVGZeamVg
         GPtD65cdaktCS2HWODXc7MYKL/0FMPss8g7gxJgqc7bTMNNVt/C8OblRMh6ZqT266MQX
         nLvT4TqECSkvJRNdVy46j1/f0iQVxNEPBmHm/eJh+UY2vcUw/1IQo4YCN5SMZobtbuWm
         Yox91ORROBRq+QlAZ+4hVIj8+CbUIXVri390waY8xBFCvmQF9U47Jva4jtg3U7yrDWNV
         LLmaKf7UYQ4O2UWhp/2Q+GmKwzdWW2U6Mc23A/+BH23B3SAwQZ1lZ3Avcfm6DOItWKNb
         CrOA==
X-Received: by 10.180.160.200 with SMTP id xm8mr8733336wib.23.1368553900970;
 Tue, 14 May 2013 10:51:40 -0700 (PDT)
Received: by 10.194.82.41 with HTTP; Tue, 14 May 2013 10:51:40 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224308>

Hi all,

I tried to merge these different glossaries together (based on git de.p=
o)
as a new wiki page [1]. You can see the diff against the current git de=
=2Epo
glossary at [2]. I've also created a branch in my repository which only=
 contains
the wiki page as a text file. This allows comments on each line of a co=
mmit,
which perhaps can be used for discussions (see [3]) and/or pull-request=
s?!
If we really want to use one glossary, I'm also happy with other soluti=
ons or
repositories.

The new wiki page is in WIP state and it turns out that there aren't so=
 many
changes to the current one as I expected. I want to give a few comments=
 on
the most important changes:

- tree =3D Baum
+ tree =3D Baum, Baum-Objekt, "Tree"-Objekt

"Baum" is already fine. Depending on the message context we could use
"Baum-Objekt", but not necessarily.

- submodule =3D Unterprojekt
+ submodule =3D Submodul (suggested by JL) (before it was "Unterprojekt=
")

I'm fine with that.

- ancestor =3D Vorfahre
+ ancestor =3D Vorfahre, Vorg=C3=A4nger, Vorg=C3=A4nger-Commit

"Vorg=C3=A4nger" sounds a bit better for me.

- repository =3D Projektarchiv
- bare repository =3D blo=C3=9Fes Projektarchiv
+ repository =3D Projektarchiv, (or just Repository?)
+ bare repository =3D blo=C3=9Fes Projektarchiv (-||-), (reines, pures =
Repository)

I'm not sure about using "Repository". I think "Projektarchiv" is
actually good enough.

- committer =3D Eintragender
- tagger =3D Markierer
+ committer =3D Eintragender (or Committer, Commit-Ersteller)
+ tagger =3D Markierer (or Tagger, Tag-Ersteller)
=2E..[each usage of commit and tag]...

This goes to the question if we should translate "Commit" and "Tag".
I think we shouldn't since everyone who uses/learn Git or come from
other SCMs know what it means.

+ revision =3D Revision (use Commit instead (see dfb4410 (glossary: a
revision is just a commit))

So just "Commit".

+ branch =3D Zweig (or Branch)

I think "Zweig" is already fine.

+ stage/index (noun) =3D Bereitstellung (Staging-Area, Index)
+ stage/index (verb) =3D stagen, f=C3=BCr einen Commit vormerken, zur S=
taging
Area hinzuf=C3=BCgen, dem Index hinzuf=C3=BCgen
+ unstage (verb) =3D unstagen, aus Staging Area entfernen/nehmen, aus
Index entfernen/nehmen

I think we should replace "Bereitstellung" and "bereitstellen". "f=C3=BC=
r
einen/den Commit vormerken" is
nice when "stage" is used as a verb. When "stage" is used as a noun,
we have to decide between
"Index" and "Staging Area" (and "Cache"?) I'd prefer "Index".

+ merge =3D Zusammenf=C3=BChrung (Merge)

We currently translate the noun of "merge" as "Zusammenf=C3=BChrung" an=
d
the verb as "zusammenf=C3=BChren".
I'd change it so "der Merge" and "mergen".

The diff in [2] shows a couple of more changes but they're all based
on the things I've mentioned here.

[1]
https://github.com/ralfth/git-po-de/wiki/Glossary-new-WIP
[2]
https://github.com/ralfth/git-po-de/wiki/_compare/25baaa323929949283a0b=
920c1ef66dc16288d0b...12f08b8973bd4b7ea55779f6eb5ad3a86bac13d8
[3]
https://github.com/ralfth/git-po-de/commit/28852f8ea33ac6a9dbf7e3b17dfa=
00ddd4e7ecb5

Thanks,
Ralf

2013/5/13 Jan Engelhardt <jengelh@inai.de>:
>
> On Monday 2013-05-13 20:57, Ralph Hau=C3=9Fmann wrote:
>>
>>There is a glossary for the pro-git book (see [2]) but it is not up-t=
o-date
>>and it is also mixed. Therefor I would like to avoid using this gloss=
ary.
>>I like the idea of a shared wiki (git de.po and pro-git).
>>I suggest a single page as overview and single pages for
>>complicated terms. Maybe we can use our GitHub wiki (see also [3]).
>>
>>[2] https://github.com/progit/progit/blob/master/de/NOTES
>>[3] https://github.com/progit-de/progit/wiki/Glossar
>
> This is how I envision a good glossary
>
>         http://inai.de/files/git-glossary.txt
>
> Maybe the "Benevolent Dictator" model might be better suited
> instead of a wiki? (Think of the edit wars.)
