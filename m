From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: files are disappearing in git
Date: Thu, 24 Nov 2005 09:46:33 +0100
Message-ID: <20051124084633.GA3361@schottelius.org>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Cc: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 09:47:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfCkf-0007Ue-RE
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 09:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030620AbVKXIqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 03:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbVKXIqk
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 03:46:40 -0500
Received: from wg.technophil.ch ([213.189.149.230]:4511 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1030620AbVKXIqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 03:46:39 -0500
Received: (qmail 3614 invoked by uid 1000); 24 Nov 2005 08:46:33 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12696>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus Torvalds [Wed, Nov 23, 2005 at 09:20:28AM -0800]:
> On Wed, 23 Nov 2005, Nico -telmich- Schottelius wrote:
> >=20
> > I've the problem that some files (a directory with 3 files) is simply '=
away':
> >=20
> > - We added it once
> > - In current tree it's away
> > - pasky aided me in irc to find the commit where it is gone with git bi=
sect
> > --> very nice tool
> > - the commit, after which the directory was gone did NOT modify this di=
rectory
> > - though the directory is gone
> >=20
> > What should I do know to find out what's the reason git 'forgot' that d=
irectory?
>=20
> I bet somebody just messed up the index before that commit.

What would be the best things to corrupt the index?
Our developers here do the following each day:

- cg-update
- <work>
- cg-commit
- cg-update + merge if there are changes
- cg-push origin
--> this goes to NFS mounted /home (in which developers also work)
[9:34] klapperwachstum:walderlift% cat .git/branches/origin=20
/home/server/git/walderlift.git


> So the commit=20
> probably _did_ modify the directory, though some incorrect patching or=20
> some scripting bug.

Hrm, perhaps this is true, though I am not aware _how_ they (two people
besides me) could even manage to do that. Our developers are
Kylix developers under Linux, who are raelly limited to the above
cg-commands and using gitweb for seeing changes.

> If you can guess at all what went on at around that commit (what else=20
> happened there?) that might help.

In this commit where specified three files changed. The commit text is not =
related
to the directory which is missing.

Files changed are

Code/Components/Utilities/LW1Calendar.pas
Code/lw1/Client/Terminierung/FeinTerminierungForm.pas
Code/lw1/Client/Terminierung/FeinTerminierungForm.xfm

and files missing after this release are

Code/Spikes/Statistik/

If I select "history" of one of the files at the point it still existed in =
the tree,
it has only one entry, where it was added.

> Was it a merge?

No, we also assumed that first, but git bisect showed that it is not.

> Is the tree public so that we can look at it and perhaps make a guess fro=
m=20
> what happened around it?

I am sorry it is not. Perhaps I can convince my boss to allow access to it =
for
some git developers, so someone could debug it. Thought, every information
found in the tree would have to be treated confidental.

Do you have some other hints on how to debug that? Perhaps some conistency =
checking
tool?

Or perhaps should I put that git directory under cvs? ;-)

Nico

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ4V96LOTBMvCUbrlAQLxGg//XlL4ulGzoIEACwGsL05Fik5gem07JsDa
whpthYonaz4q81uwoyHdUzzFEWcxrOL/sKvXb4AQM0GI3MZywSPcQr5bjm5cI3+r
2RIdJ+w9b/VxNDb28Jm+lPZqODKoETwIyTfz8/u+jNnZ4Fnwf+tWwFCaxwrC+cYz
bydZicTU6rQgZLHsio7ner9iOmJrgvN2flHg1eTgQZhjzL2kG1HKf2S98Y8tRhJd
yw22YW7kVf43ico9q7H61ZcoJWV5EnLDLStki1irnvHHn+GPC2J1nUH4jL41gJXt
GEjuzJrmVip/+2AnDCYYwb8y6VB1rniY3215IEj2G4BzkYQsm4R3iZPRlLQnGABz
p4oqeg+tRqh//RFZhFQznY9enyIbzD6aa1duvxtcraUAsfT1RjEggDFz7MRo80oC
OWBI9/TosRwo9fw5mrIj5wv4Qga+M0IDCkdfMGsQWKovsPvA1cAxHH7NhvMVcaoe
2KrhidIjolpvtZbbErt8ACL1dpEXFgfFZCCKStey+PijyOfja8H/aNJyUjpArVln
rKztnZnG2bYNjtZkXFY6M6Y47DSBA62eLLEIfmkW/RyQmafGAMd23Z4jlpC4mHS9
8goF5dX8DPItG9f4/+R/WPc6D1Wdyxlv5HdLDMvcsxr/ove04RZsqeD9xQ5l8dKT
ood2SYbF+CE=
=PJo8
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
