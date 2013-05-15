From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Wed, 15 May 2013 13:26:11 +0200
Message-ID: <519370D3.3000306@web.de>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net> <alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr> <001d01ce500b$c7c08b70$5741a250$@scanmyfood.de> <alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr> <CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com> <51936218.9020306@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?B?UmFscGggSGF1w59tYW5u?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 15 13:26:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcZqo-0000Pr-0B
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 13:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab3EOL00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 May 2013 07:26:26 -0400
Received: from mout.web.de ([212.227.17.12]:49340 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab3EOL0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 07:26:25 -0400
Received: from [192.168.178.41] ([91.3.187.16]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Lfzwp-1U9FeB1BVL-00osEk; Wed, 15 May 2013 13:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <51936218.9020306@ira.uka.de>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:xsHlCJtbVMOTR7TpgG+BJYLzEG7o0fs+1JmwehDW7jr
 iGRsTAy5YsVAYLBiE/vK5ZcrAGl3kmwCNty0QaieBqAStUW2GC
 i257as8hGyYwiIZIWYycgsgCjRHRI1jj6hHv1Yp/7cGMncQZt6
 8yJC7iFckkfsCjo+3cFBqSaxokr+lNyJwyHKRDZSxnVR2Klr/d
 KDBORqgM01lefEMQGYoFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224398>

Am 15.05.2013 12:23, schrieb Holger Hellmuth (IKS):
> Am 14.05.2013 19:51, schrieb Ralf Thielow:
>> - repository =3D Projektarchiv
>> - bare repository =3D blo=C3=9Fes Projektarchiv
>> + repository =3D Projektarchiv, (or just Repository?)
>> + bare repository =3D blo=C3=9Fes Projektarchiv (-||-), (reines, pur=
es Repository)
>=20
> I would vote for Repository or if it needs to be translated, simply A=
rchiv. Neither Projektarchiv nor Archiv is commonly used by me but Arch=
iv is shorter and not everything in a repository is a project.

Hmm, I rather tend towards using "Repository" instead of "Archiv" too, =
as
"Archiv" can mean anything from a tar-file to a git repository, while w=
e are
talking about something very specific here (and a German might be surpr=
ised
what the command "git archive" is about if we use "Archiv" here ;-). So=
 if
it has to be translated, I like "Projektarchiv" better than "Archiv" fo=
r
those reasons. We can also think about using "Repo" as an abbreviated f=
orm,
we often use that when talking about repositories in German. That would=
 be a
new term without ambiguity and will be pronounced pretty much correctly=
 by
all Germans too. But this remains one of the tougher questions.

And then "pack" is currently translated as "Archiv":

  pack(noun) =3D Archiv

but I believe "Packdatei" would be a much better translation (especiall=
y as
the translation of "pack(verb)" is "packen"). I find it natural that a =
file
with the extension ".pack" is named Packdatei, just like a file with th=
e
extension ".zip" is a "Zipdatei" (known by the Duden) in German. And th=
e
Duden already knows "Pack" as an assembly of smaller parts, so we shoul=
d be
safe here.

>> I'm not sure about using "Repository". I think "Projektarchiv" is
>> actually good enough.
>>
>> - committer =3D Eintragender
>> - tagger =3D Markierer
>> + committer =3D Eintragender (or Committer, Commit-Ersteller)
>> + tagger =3D Markierer (or Tagger, Tag-Ersteller)
>> ...[each usage of commit and tag]...
>=20
> Both "commit" and "tag" are used in commands so with the exception of=
 the place where they are defined the english words should be used. I t=
hink Commit-/Tag-Ersteller actually sounds fine and german enough so no=
 one notices there is an english word in there ;-)

Yup, im my experience "committen" (to commit), "einchecken" (to check i=
n),
"auschecken" (to check out) und "taggen" (to tag) made it into our dail=
y
German language use. To avoid e.g. having past tenses look strange (lik=
e
"committet") the combined Form ("Commit erstellt") could solve that pro=
blem.

>> + branch =3D Zweig (or Branch)
>>
>> I think "Zweig" is already fine.
>=20
> Same reason, branch is used as a command and should not be translated=
=2E But "Zweig" is a really natural and together with "Baum" fitting tr=
anslation, so I'm conflicted here.

Yes, Baum, Wurzel and Zweig are obviously equivalent to tree, root and =
branch,
so I don't care much if we translate that or not.
