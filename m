From: Quark <unixuser2000-fbsd@yahoo.com>
Subject: git-svn too slow, contacts upstream svn repo
Date: Mon, 27 May 2013 23:25:59 +0800 (SGT)
Message-ID: <1369668359.69324.YahooMailNeo@web190701.mail.sg3.yahoo.com>
Reply-To: Quark <unixuser2000-fbsd@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 27 17:32:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgzPD-0007hE-UP
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 17:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab3E0PcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 11:32:11 -0400
Received: from nm7-vm10.bullet.mail.sg3.yahoo.com ([106.10.148.185]:34742 "HELO
	nm7-vm10.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752724Ab3E0PcK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 11:32:10 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2013 11:32:09 EDT
Received: from [106.10.166.115] by nm7.bullet.mail.sg3.yahoo.com with NNFMP; 27 May 2013 15:25:59 -0000
Received: from [106.10.151.253] by tm4.bullet.mail.sg3.yahoo.com with NNFMP; 27 May 2013 15:25:59 -0000
Received: from [127.0.0.1] by omp1002.mail.sg3.yahoo.com with NNFMP; 27 May 2013 15:25:59 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 846888.93386.bm@omp1002.mail.sg3.yahoo.com
Received: (qmail 70663 invoked by uid 60001); 27 May 2013 15:25:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1369668359; bh=uYafVqnHPgkJ79QD0oqAXjl6uk3SZz0HQVisRp//FoE=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=WAIiiae5meV7mgAk15F2Lls0lIIcLlbX6zWWRn5RpnYNU3wsMU3alNztiy8zeGfazxuHiQFPAQIgDDjuyzns2g7Cbp+GOGtk1QU1Ukn9q/tVPQG5WR9ytSc1T+mF9zHDi6a96sY+sT5dc321OBRt8PonkZGDfSSVlQsK36FwLI4=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=c6vNBVWoj1l1Zgj8jHQU1N32K7MT+hEwDA+wVvgN/um6u8HVcpU7PnJs/NRAWCPyR3sVAAxR9d5uf/UMNIDHYtmalGCEph6POsPz9l/lvtnydqcflh2yCOtT6LxMH89M+5IAHQopmw0p885ab+hWyLrEjpE6SNfwWh54DyYJHj0=;
X-YMail-OSG: yQ9NwloVM1me2hvgEiyVU6T4IZy2fdb7anf46lJhzpP_kPY
 KsCamW2CPeiyVJU8CUP18b2UEDwUiox_gi4rlzXXqAnCyjkU8SguiYurlt9R
 4MCw1TSEG4nsimaQliFJs8m.immptya5WUmRQ7IsJaoEE2gj1RiMOqDMYU_j
 rjHvp5p67NeVFHdwBdTSLFE5stvB7CrYOSVcC.ExgzWtyiMJGiTSj7Vfb6Q6
 tx7ULmX2nJMbtsvDic4ksUFhS6u1EW1MdCHzmEEwVH.aiuel631NfWaBkZg4
 SApQtehzdRdwcc3VmPGSgg2Oz3YsG18fR67r.KBGGEUW4L4SoDE04C5JBI2r
 dFj.4IoYHiDk5N2d7udo0HZHCmzAe67XHcPf0i9noLLm66SbThoOXW2Wpguu
 Wdjany6kNG6.fC9JuJpVfv16B4iSeLNV0N_Y.d4fdw30S7USmvRyY7DJnRAh
 EZecXAabFdAYAO_5xuNeG_03oSaPAfOCCuPKIgfsCtOvBWZEwoHIZhfS_DK8
 73mYRQSe7pOAS7ZWvIuLZxHlI_KBKaOw8bPMu9Kh5EqTaBCL0ZCJuAqj6LSD
 5ZNQ5fUQDr8IW0SdbwwSEAz2WC8qYtA5ChzB6dGjy
Received: from [103.245.47.20] by web190701.mail.sg3.yahoo.com via HTTP; Mon, 27 May 2013 23:25:59 SGT
X-Rocket-MIMEInfo: 002.001,aGVsbG8gbGlzdCwKCkkgaGF2ZSBiZWVuIHVzaW5nIGdpdC1zdm4gaW4gYW4gY29ycG9yYXRlIGVudmlyb25tZW50IHdoZXJlIHN2biByZXBvIGhhcyBsb3Qgb2YgYnJhbmNoZXMsIChsb3QgbWVhbnMgPiAxMDApLiBUbyBhdm9pZCBjbG9uaW5nIGFsbCBicmFuY2hlcyBteSBjb25maWcgbG9va3MgYXMgYmVsb3cKCltzdm4tcmVtb3RlICJzdm4iXQrCoMKgwqDCoMKgwqDCoCB1cmwgPSBzdm4rc3NoOi8vdXJsCsKgwqDCoMKgwqDCoMKgIGZldGNoID0gc3Jjcm9vdC90cnVuazpyZWZzL3JlbW90ZXMvdHJ1bmsKwqABMAEBAQE-
X-Mailer: YahooMailWebService/0.8.144.546
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225599>

hello list,

I have been using git-svn in an corporate environment where svn repo ha=
s lot of branches, (lot means > 100). To avoid cloning all branches my =
config looks as below

[svn-remote "svn"]
=A0=A0=A0=A0=A0=A0=A0 url =3D svn+ssh://url
=A0=A0=A0=A0=A0=A0=A0 fetch =3D srcroot/trunk:refs/remotes/trunk
=A0=A0=A0=A0=A0=A0=A0 branches =3D srcroot/branches/{branch_1, branch_2=
, branch_3}:refs/remotes/*

Now, when a new branch of my interest is added in svn repo, I had like =
it to be in my git-repo as well. In an ideal world, one shall simply ad=
d that branch name to list in curly braces above, but that does not wor=
k. I had love to be proved wrong here. Somebody on stackoverflow.com su=
ggested (to else's question, not mine) to add one more "fetch" as show =
below.

[svn-remote "svn"]
=A0=A0=A0=A0=A0=A0=A0 url =3D svn+ssh://url
=A0=A0=A0=A0=A0=A0=A0 fetch =3D srcroot/trunk:refs/remotes/trunk
=A0=A0=A0=A0=A0=A0=A0 fetch =3D srcroot/branch_4:refs/remotes/* # NEW B=
RANCH
=A0=A0=A0=A0=A0=A0=A0 branches =3D srcroot/branches/{branch_1, branch_2=
, branch_3}:refs/remotes/*

haven't tried it, neither do I like it.

I do have a solution which WORKS, it is modified version of an example =
from \doc\git\html\git-svn.html page. Below I have pasted the example a=
nd modified it to reflect my specifics.

# assume an existing git-svn repo
=A0=A0=A0=A0=A0=A0=A0 D:\sourcecode
# Clone locally - make sure the refs/remotes/ space matches the server
=A0=A0=A0=A0=A0=A0=A0 mkdir project
=A0=A0=A0=A0=A0=A0=A0 cd project
=A0=A0=A0=A0=A0=A0=A0 git init
=A0=A0=A0=A0=A0=A0=A0 git remote add origin file:///D:/sourcecode # fil=
e:// is delibrate, want true n/w behaviour
=A0=A0=A0=A0=A0=A0=A0 git config --replace-all remote.origin.fetch '+re=
fs/remotes/*:refs/remotes/*'
=A0=A0=A0=A0=A0=A0=A0 git fetch
# Prevent fetch/pull from local git repo,
# we only want to use git svn for form here
=A0=A0=A0=A0=A0=A0 git config --remove-section remote.origin
# Create a local branch from one of the branches just fetched
=A0=A0=A0=A0=A0=A0=A0 git checkout -b master FETCH_HEAD
# Initialize 'git svn' locally (be sure to use the same URL and -T/-b/-=
t options as were used on server)
=A0=A0=A0=A0=A0=A0=A0 git svn init http://svn.example.com/project

# edit config to include newly added branch in curly braces
# Pull the latest changes from Subversion
=A0=A0=A0=A0=A0=A0=A0 git svn fetch -r <recentish rev, say BEGIN>:HEAD

Above works exactly as I want, except the last step of "git-svn fetch" =
connects to svn repo for each revision from BEGIN to HEAD. I want fairl=
y long history (for pretty blame). Which implies my BEGIN is not so rec=
entish adterall. Hence, it takes awfully long to finish, 2 days typical=
ly.

When GIT_TRACE is 1, below is output received

trace: exec: 'git-svn' 'fetch'
trace: run_command: 'git-svn' 'fetch'
trace: built-in: git 'config' '--bool' '--get' 'svn.fetchall'
trace: built-in: git 'config' '--bool' '--get' 'svn.parent'
trace: built-in: git 'config' '--bool' '--get' 'svn.noauthcache'
trace: built-in: git 'config' '--get' 'svn.revision'
trace: built-in: git 'config' '--bool' '--get' 'svn.nocheckout'
trace: built-in: git 'config' '--get' 'svn.authorsprog'
trace: built-in: git 'config' '--bool' '--get' 'svn.followparent'
trace: built-in: git 'config' '--get' 'svn.authorsfile'
trace: built-in: git 'config' '--bool' '--get' 'svn.useSvmProps'
trace: built-in: git 'config' '--get' 'svn.username'
trace: built-in: git 'config' '--get' 'svn.repackflags'
trace: built-in: git 'config' '--bool' '--get' 'svn.localtime'
trace: built-in: git 'config' '--int' '--get' 'svn.repack'
trace: built-in: git 'config' '--get' 'svn.ignorepaths'
trace: built-in: git 'config' '--int' '--get' 'svn.logwindowsize'
trace: built-in: git 'config' '--bool' '--get' 'svn.quiet'
trace: built-in: git 'config' '--get' 'svn.ignorerefs'
trace: built-in: git 'config' '--get' 'svn.configdir'
trace: built-in: git 'config' '--bool' '--get' 'svn.addauthorfrom'
trace: built-in: git 'config' '--bool' '--get' 'svn.useSvnsyncProps'
trace: built-in: git 'config' '--bool' '--get' 'svn.noMetadata'
trace: built-in: git 'config' '--bool' '--get' 'svn.uselogauthor'
trace: built-in: git 'rev-parse' '--symbolic' '--all'
trace: built-in: git 'config' '-l'
trace: built-in: git 'config' '-l'
trace: built-in: git 'config' '--bool' 'svn.useSvmProps'
trace: built-in: git 'config' '-l'
trace: built-in: git 'config' 'svn-remote.svn.branches-maxRev' '524908'
trace: built-in: git 'rev-list' '--pretty=3Draw' '--reverse' '9f1414be9=
4ab007b62ace31bf4d210a069276127..refs/remotes/branch_1' '--'
trace: built-in: git 'rev-list' '--pretty=3Draw' '--reverse' '5eb0a454b=
cf066a8199b851add9ec07cde80119d..refs/remotes/branch_2' '--'
trace: built-in: git 'rev-list' '--pretty=3Draw' '--reverse' '383b68b85=
14010a71efe10821e5ccc3541903ceb..refs/remotes/branch_3' '--'
trace: built-in: git 'rev-list' '--pretty=3Draw' '--reverse' '89fe1a1d2=
cfca0886003f043c408fb5afadfec93..refs/remotes/trunk' '--'

I keep an watch for "svn-remote.svn.branches-maxRev", this serves as my=
 progress. This wait is too much for a simple branch. Though, I must po=
int out, day feels fresh once it finishes :) Does any one know any for =
this?

If you paid attention this is Windows machine
git version 1.8.1.msysgit.1


thanks,
Quark
