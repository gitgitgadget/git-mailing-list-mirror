From: Quark <unixuser2000-fbsd@yahoo.com>
Subject: Re: git-svn too slow, contacts upstream svn repo
Date: Tue, 28 May 2013 15:42:57 +0800 (SGT)
Message-ID: <1369726977.1915.YahooMailNeo@web190701.mail.sg3.yahoo.com>
References: <1369668359.69324.YahooMailNeo@web190701.mail.sg3.yahoo.com>
Reply-To: Quark <unixuser2000-fbsd@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 28 09:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhEe7-0006Xg-D9
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 09:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759081Ab3E1Hsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 03:48:35 -0400
Received: from nm19-vm8.bullet.mail.sg3.yahoo.com ([106.10.149.119]:48153 "EHLO
	nm19-vm8.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751348Ab3E1Hse convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 03:48:34 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2013 03:48:33 EDT
Received: from [106.10.166.114] by nm19.bullet.mail.sg3.yahoo.com with NNFMP; 28 May 2013 07:42:57 -0000
Received: from [106.10.151.187] by tm3.bullet.mail.sg3.yahoo.com with NNFMP; 28 May 2013 07:42:57 -0000
Received: from [127.0.0.1] by omp1013.mail.sg3.yahoo.com with NNFMP; 28 May 2013 07:42:57 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 252601.26252.bm@omp1013.mail.sg3.yahoo.com
Received: (qmail 2018 invoked by uid 60001); 28 May 2013 07:42:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1369726977; bh=AIMmCTXgcFkIKdPGPSKkRiNwLPEBtc1X3WGzNUujEtk=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=KaL2JoxpzzyWx/WDnKjN1VHuD2baO/Aig3XEwWzMl+R0hnZbTguf6MpPt4u0cyiZKU0X5t8m2E92ke7iMrM9k2IBXj4NaCLJemqJhbXFVa3f9OGte/QAXKtbu+Sd1hPqH+TJO7a6PrLaE9Q3SIBCibWm/zNIvi4LStZsSS3FgxE=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YHov56ItrQp5bFJyAPLWiRK34ix9ws/psFoZvuRcp7pNxBy7Jv83eHpg5/EaF1K4Xwsnm+zaX2GzYcha/jaCxFnhRyyTISPUQNSk28+khox9m/kySyp2ig5WYFCdADsFODPMCn222yWuJnQgBKoKqwLaDZlTXC8fYxT20ajFiAU=;
X-YMail-OSG: dJXYGIgVM1kwanH3b7NEIwJ_2X7c59x71OpSxyYYpHfqwO1
 L9bWnAZYH79pmllGvCIxLdIs8LxPwg6jw5MpzIo.VXvpYk93DiFPU.k4WjfY
 oMqBq4UQS9UV7acG5qGoTF7jsbXQYA_K5FCdPc1XjIjWHMf._DGGVXcXcUIM
 yDjyOCkNmX7gNajNV9XPaa9H.olTDvqXHxcwMR9qLCJVFJVY5bU2kEpxE_pg
 8ehf6zd0wvehqtN.GLCs_V9SCkY_WFwjcrgvi8ZoHtHCQTDSIZU8IP8MhDfJ
 .ch_Ok.Fpwlu5p5qU7_M8XZLU.6FR6Y1clqapzA4JGJqGlYvK.8IMSOf3FTy
 sjPLT0YF2wjhwtxt0ZaU9qXT4vhjwixEfPk3TasoU3F9MzZwkQ6LCrsynnWS
 j2I.CuMuMmVxVH1ALw0zjmUTVipjR9gsNnezPAUIen.rlCi3rUtsMHaTOAR0
 u1BABNMDSxYyzIJPLhllCZ6LOpcCCOZ.4HeV1O4gfsr2CxzfjbprxPzcnOlT
 0uuHgIbvIW3q2FSBNORKVfcDg6j8xy66.50t0gfnXFCOctiOrLI9meaT9S86
 q2_bMwjCvXA20iAiajbd.BAc8Liqj96ikA5PZrlXbCEnxAcBS.nDigV6aFYl
 Vyak-
Received: from [103.245.47.20] by web190701.mail.sg3.yahoo.com via HTTP; Tue, 28 May 2013 15:42:57 SGT
X-Rocket-MIMEInfo: 002.001,CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogUXVhcmsgPHVuaXh1c2VyMjAwMC1mYnNkQHlhaG9vLmNvbT4KPiBUbzogR2l0IExpc3QgPGdpdEB2Z2VyLmtlcm5lbC5vcmc.Cj4gQ2M6IAo.IFNlbnQ6IE1vbmRheSwgMjcgTWF5IDIwMTMgODo1NSBQTQo.IFN1YmplY3Q6IGdpdC1zdm4gdG9vIHNsb3csIGNvbnRhY3RzIHVwc3RyZWFtIHN2biByZXBvCj4gCj4gaGVsbG8gbGlzdCwKPiAKPiBJIGhhdmUgYmVlbiB1c2luZyBnaXQtc3ZuIGluIGFuIGNvcnBvcmF0ZSBlbnZpcm9ubWVudCB3aGUBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.144.546
In-Reply-To: <1369668359.69324.YahooMailNeo@web190701.mail.sg3.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225620>



----- Original Message -----
> From: Quark <unixuser2000-fbsd@yahoo.com>
> To: Git List <git@vger.kernel.org>
> Cc:=20
> Sent: Monday, 27 May 2013 8:55 PM
> Subject: git-svn too slow, contacts upstream svn repo
>=20
> hello list,
>=20
> I have been using git-svn in an corporate environment where svn repo =
has lot of=20
> branches, (lot means > 100). To avoid cloning all branches my config =
looks as=20
> below
>=20
> [svn-remote "svn"]
> =A0=A0=A0=A0=A0=A0=A0 url =3D svn+ssh://url
> =A0=A0=A0=A0=A0=A0=A0 fetch =3D srcroot/trunk:refs/remotes/trunk
> =A0=A0=A0=A0=A0=A0=A0 branches =3D srcroot/branches/{branch_1, branch=
_2,=20
> branch_3}:refs/remotes/*
>=20
> Now, when a new branch of my interest is added in svn repo, I had lik=
e it to be=20
> in my git-repo as well. In an ideal world, one shall simply add that =
branch name=20
> to list in curly braces above, but that does not work. I had love to =
be proved=20
> wrong here. Somebody on stackoverflow.com suggested (to else's questi=
on, not=20
> mine) to add one more "fetch" as show below.
>=20
> [svn-remote "svn"]
> =A0=A0=A0=A0=A0=A0=A0 url =3D svn+ssh://url
> =A0=A0=A0=A0=A0=A0=A0 fetch =3D srcroot/trunk:refs/remotes/trunk
> =A0=A0=A0=A0=A0=A0=A0 fetch =3D srcroot/branch_4:refs/remotes/* # NEW=
 BRANCH
> =A0=A0=A0=A0=A0=A0=A0 branches =3D srcroot/branches/{branch_1, branch=
_2,=20
> branch_3}:refs/remotes/*
>=20
> haven't tried it, neither do I like it.
>=20
> I do have a solution which WORKS, it is modified version of an exampl=
e from=20
> \doc\git\html\git-svn.html page. Below I have pasted the example=20
> and modified it to reflect my specifics.
>=20
> # assume an existing git-svn repo
> =A0=A0=A0=A0=A0=A0=A0 D:\sourcecode
> # Clone locally - make sure the refs/remotes/ space matches the serve=
r
> =A0=A0=A0=A0=A0=A0=A0 mkdir project
> =A0=A0=A0=A0=A0=A0=A0 cd project
> =A0=A0=A0=A0=A0=A0=A0 git init
> =A0=A0=A0=A0=A0=A0=A0 git remote add origin file:///D:/sourcecode # f=
ile:// is delibrate, want=20
> true n/w behaviour
> =A0=A0=A0=A0=A0=A0=A0 git config --replace-all remote.origin.fetch=20
> '+refs/remotes/*:refs/remotes/*'
> =A0=A0=A0=A0=A0=A0=A0 git fetch
> # Prevent fetch/pull from local git repo,
> # we only want to use git svn for form here
> =A0=A0=A0=A0=A0=A0 git config --remove-section remote.origin
> # Create a local branch from one of the branches just fetched
> =A0=A0=A0=A0=A0=A0=A0 git checkout -b master FETCH_HEAD
> # Initialize 'git svn' locally (be sure to use the same URL and -T/-b=
/-t=20
> options as were used on server)
> =A0=A0=A0=A0=A0=A0=A0 git svn init http://svn.example.com/project
>=20
> # edit config to include newly added branch in curly braces
> # Pull the latest changes from Subversion
> =A0=A0=A0=A0=A0=A0=A0 git svn fetch -r <recentish rev, say BEGIN>:HEA=
D
>=20
> Above works exactly as I want, except the last step of "git-svn fetch=
"=20
> connects to svn repo for each revision from BEGIN to HEAD. I want fai=
rly long=20
> history (for pretty blame). Which implies my BEGIN is not so recentis=
h adterall.=20
> Hence, it takes awfully long to finish, 2 days typically.
>=20
> When GIT_TRACE is 1, below is output received
>=20
> trace: exec: 'git-svn' 'fetch'
> trace: run_command: 'git-svn' 'fetch'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.fetchall'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.parent'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.noauthcache'
> trace: built-in: git 'config' '--get' 'svn.revision'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.nocheckout'
> trace: built-in: git 'config' '--get' 'svn.authorsprog'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.followparent'
> trace: built-in: git 'config' '--get' 'svn.authorsfile'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.useSvmProps'
> trace: built-in: git 'config' '--get' 'svn.username'
> trace: built-in: git 'config' '--get' 'svn.repackflags'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.localtime'
> trace: built-in: git 'config' '--int' '--get'=20
> 'svn.repack'
> trace: built-in: git 'config' '--get' 'svn.ignorepaths'
> trace: built-in: git 'config' '--int' '--get'=20
> 'svn.logwindowsize'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.quiet'
> trace: built-in: git 'config' '--get' 'svn.ignorerefs'
> trace: built-in: git 'config' '--get' 'svn.configdir'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.addauthorfrom'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.useSvnsyncProps'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.noMetadata'
> trace: built-in: git 'config' '--bool' '--get'=20
> 'svn.uselogauthor'
> trace: built-in: git 'rev-parse' '--symbolic' '--all'
> trace: built-in: git 'config' '-l'
> trace: built-in: git 'config' '-l'
> trace: built-in: git 'config' '--bool' 'svn.useSvmProps'
> trace: built-in: git 'config' '-l'
> trace: built-in: git 'config' 'svn-remote.svn.branches-maxRev'=20
> '524908'
> trace: built-in: git 'rev-list' '--pretty=3Draw'=20
> '--reverse'=20
> '9f1414be94ab007b62ace31bf4d210a069276127..refs/remotes/branch_1'=20
> '--'
> trace: built-in: git 'rev-list' '--pretty=3Draw'=20
> '--reverse'=20
> '5eb0a454bcf066a8199b851add9ec07cde80119d..refs/remotes/branch_2'=20
> '--'
> trace: built-in: git 'rev-list' '--pretty=3Draw'=20
> '--reverse'=20
> '383b68b8514010a71efe10821e5ccc3541903ceb..refs/remotes/branch_3'=20
> '--'
> trace: built-in: git 'rev-list' '--pretty=3Draw'=20
> '--reverse'=20
> '89fe1a1d2cfca0886003f043c408fb5afadfec93..refs/remotes/trunk'=20
> '--'
>=20
> I keep an watch for "svn-remote.svn.branches-maxRev", this serves as=20
> my progress. This wait is too much for a simple branch. Though, I mus=
t point=20
> out, day feels fresh once it finishes :) Does any one know any for th=
is?
>=20
> If you paid attention this is Windows machine
> git version 1.8.1.msysgit.1
>=20
>=20
> thanks,
> Quark
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>

is this not right forum?

thanks,
Quark
