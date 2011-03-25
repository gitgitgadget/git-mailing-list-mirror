From: Matt Harrison <iwasinnamuknow@genestate.com>
Subject: Re: shell script calling git fails when called from scheduler
Date: Fri, 25 Mar 2011 22:19:14 +0000
Message-ID: <20110325221914.GA11156@genestate.com>
References: <0v62r6q2lm.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Cc: git@vger.kernel.org
To: Markus Heller <hellerm2@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 23:25:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3FRT-0006oc-TX
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 23:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425Ab1CYWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 18:25:08 -0400
Received: from pathfinder.genestate.com ([212.21.116.18]:45691 "EHLO
	genesis.genestate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab1CYWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 18:25:06 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Mar 2011 18:25:05 EDT
Received: from localhost (exodus.genestate.com [10.194.217.3])
	by genesis.genestate.com (Postfix) with ESMTP id 9505961A1D;
	Fri, 25 Mar 2011 22:19:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=genestate.com; h=
	user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date:received:received; s=default; t=1301091676;
	 bh=sf2JkYHMOANaQjlC3FGB8JuGfSh3j109v7FaGfDGREI=; b=B+9RX1NTgCfx
	CPfg1SdpsDW18j/G30LANG3/TMog5zkNGPN6Pno5E5OASTfm5UifhUvCcRzAMzFz
	z83eAh0DoXGqU2SCEJfjzrl3dEanA43P99iGOwX9Q6G4bNZG6qmD2l08QP80SrL0
	FEoMNKwydqb54LC7eCtTRplXZVBsTxk=
Received: from genesis.genestate.com ([10.194.217.1])
	by localhost (exodus.genestate.com [10.194.217.3]) (amavisd-new, port 10025)
	with ESMTP id mj7ajzJ1Yn51; Fri, 25 Mar 2011 22:21:16 +0000 (GMT)
Received: by genesis.genestate.com (Postfix, from userid 1000)
	id 4C6BC61A45; Fri, 25 Mar 2011 22:19:14 +0000 (GMT)
Mail-Followup-To: Markus Heller <hellerm2@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <0v62r6q2lm.fsf@gmail.com>
X-Operating-System: Linux/2.6.27-gentoo-r8 (i686)
X-Uptime: 19 days
X-GPG-Key-ID: 0xDB2B79A4
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170028>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2011 at 03:04:05PM -0700, Markus Heller wrote:
> Hi all,
>=20
> I have the following batch shell script (org-git-synch.bat):
>=20
> @ECHO OFF
>=20
> REM get date and time
> for /f "delims=3D" %%a in ('date/t') do @set mydate=3D%%a
> for /f "delims=3D" %%a in ('time/t') do @set mytime=3D%%a
> set fvar=3D%mydate%%mytime%
>=20
> REM add all new files
> call git add .
> call git commit -a -m "Automated commit by org-git-sync.bat on %fvar%"
>=20
> The script resides in h:/org/; and I have a working git repository in
> this directory (in h:/org/.git).
>=20
> I can run the script from the command line no problem, but when I try to
> run it from the Windoze scheduler, all I get is a cmd window saying:
>=20
> fatal: not a git repository (or any of the parent directories): .git
> fatal: not a git repository (or any of the parent directories): .git
>=20
> I did re-initialize the repository, but that didn't matter, since git
> status and everything else works fine from the command line.  I'm on Win
> 7 Pro 64 bit SP 1.
>=20
> Any ideas?
>=20
> Thanks and Cheers
> Markus

At a guess (I dont use the windows scheduler), the working directory of the=
 batch file
is not being set to h:/org

I dont know if there is a way to tell the windows scheduler what the workin=
g directory
should be, so maybe try cd'ing to h:/org at the start of your script?

HTH

Matt

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQEcBAEBAgAGBQJNjRThAAoJEAy5yA3bK3mkcH4H/23FL+X5PDZNxg1a0EXGbRMQ
ggEYMm+6A7AjC23oZEPnIAqa4TFpjSpUoJuDjmfBMeU2KrLCoJREx2Lhlsn5egEA
Zgq9nYWT4sA51PQD51A/QVwVZoVisXMslYAjqg79/Qr/CsAXdnv2qG/ZdYXUkIOO
3g+2DfVzJYX74dnc3ffRr2pF6HjKmPkCsm4yhSv7RonSr9l9jh+k6VxIzopG9STe
wIN51BbcOx86SahDMZ5+JZ+jpZ+GnC6ztt9Tlw9bca7DBnCi8IS+OWtLZRG53J1l
lR92HMLqA60vdW1re9T7qfknxKP4K2OakQrl43PeQ3SiBKzdcbmTj6FsQ1SiWnk=
=JK6Z
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
