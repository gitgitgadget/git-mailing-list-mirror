From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: git push hung?
Date: Sun, 7 Dec 2014 14:14:52 -0500
Organization: PD Inc
Message-ID: <8A724B8FE46E4B628FCC5A1A8A09918B@black>
References: <F818AFA80A5F46BBA007F6EB102A75C5@black> <5484950D.7080107@web.de>
Reply-To: <git@vger.kernel.org>,
	  =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?iso-8859-1?Q?'Torsten_B=F6gershausen'?=" <tboegi@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 20:15:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxhIJ-0003ei-Rf
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 20:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbaLGTO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 14:14:56 -0500
Received: from mail.pdinc.us ([67.90.184.27]:32857 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbaLGTOz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 14:14:55 -0500
Received: from black (five-58.pdinc.us [192.168.5.58])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id sB7JEr87031849;
	Sun, 7 Dec 2014 14:14:53 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdASR1TkTkIY0r4cR0iZ+iPJeZUbtgACcTdA
In-Reply-To: <5484950D.7080107@web.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260996>

No cc's please, I am on the list.
> -----Original Message-----
> From: Torsten B=F6gershausen=20
> Sent: Sunday, December 07, 2014 12:58
>=20
> On 2014-12-07 15.24, Jason Pyeron wrote:
> > I am trying to push to our local intranet git (smart https=20
> behind apache), and it has been at this point for 10+ hours.
> >=20
> > jpyeron@black /projects/git/git
> > $ GIT_TRACE=3D1 git push
> > 09:08:45.662902 git.c:349               trace: built-in: git 'push'
> > 09:08:45.662902 run-command.c:341       trace: run_command:=20
> 'git-remote-https' 'origin' 'https://intranet.pdinc.us/git/git/'
> > 09:08:46.225700 run-command.c:341       trace: run_command:=20
> 'git credential-cache --timeout=3D99999999999 get'
> > 09:08:46.256967 run-command.c:192       trace: exec:=20
> '/bin/sh' '-c' 'git credential-cache --timeout=3D99999999999=20
> get' 'git credential-cache --timeout=3D99999999999 get'
> > 09:08:46.366400 git.c:554               trace: exec:=20
> 'git-credential-cache' '--timeout=3D99999999999' 'get'
> > 09:08:46.366400 run-command.c:341       trace: run_command:=20
> 'git-credential-cache' '--timeout=3D99999999999' 'get'
> > 09:08:47.022999 run-command.c:341       trace: run_command:=20
> 'git credential-cache --timeout=3D99999999999 store'
> > 09:08:47.038632 run-command.c:192       trace: exec:=20
> '/bin/sh' '-c' 'git credential-cache --timeout=3D99999999999=20
> store' 'git credential-cache --timeout=3D99999999999 store'
> > 09:08:47.116799 git.c:554               trace: exec:=20
> 'git-credential-cache' '--timeout=3D99999999999' 'store'
> > 09:08:47.116799 run-command.c:341       trace: run_command:=20
> 'git-credential-cache' '--timeout=3D99999999999' 'store'
> > 09:08:47.366931 run-command.c:341       trace: run_command:=20
> 'send-pack' '--stateless-rpc' '--helper-status' '--thin'=20
> '--progress' 'https://intranet.pdinc.us/git/git/'=20
> 'refs/heads/master:refs/heads/master'
> > 09:08:47.382565 exec_cmd.c:134          trace: exec: 'git'=20
> 'send-pack' '--stateless-rpc' '--helper-status' '--thin'=20
> '--progress' 'https://intranet.pdinc.us/git/git/'=20
> 'refs/heads/master:refs/heads/master'
> > 09:08:47.429465 git.c:349               trace: built-in:=20
> git 'send-pack' '--stateless-rpc' '--helper-status' '--thin'=20
> '--progress' 'https://intranet.pdinc.us/git/git/'=20
> 'refs/heads/master:refs/heads/master'
> > 09:08:47.538898 run-command.c:341       trace: run_command:=20
> 'pack-objects' '--all-progress-implied' '--revs' '--stdout'=20
> '--thin' '--delta-base-offset' '--progress'
> > 09:08:47.695231 exec_cmd.c:134          trace: exec: 'git'=20
> 'pack-objects' '--all-progress-implied' '--revs' '--stdout'=20
> '--thin' '--delta-base-offset' '--progress'
> > 09:08:47.742131 git.c:349               trace: built-in:=20
> git 'pack-objects' '--all-progress-implied' '--revs'=20
> '--stdout' '--thin' '--delta-base-offset' '--progress'
> > Counting objects: 18734, done.
> > Delta compression using up to 2 threads.
> > Compressing objects: 100% (5707/5707), done.
> > Writing objects: 100% (18734/18734), 9.37 MiB | 0 bytes/s, done.
> > Total 18734 (delta 14519), reused 17108 (delta 12968)
> >=20
> > Servier died, this is in the log:
> >=20
> > fatal: protocol error: expected old/new/ref, got 'shallow=20
> 3339e9f686bd4c17e3575c71327c4ccf1e8e077b'
> >=20
> > What steps can I take to debug this hang in the client?
> >=20
> > Git fetch hangs the same way with a server exit of fatal:=20
> did not find object for shallow=20
> 3339e9f686bd4c17e3575c71327c4ccf1e8e077b
> >=20
> > Note: I fixed the underlying problem with a git fetch=20
> --unshallow upstream
> >
> Was the log above after the git fetch --unshallow upstream ?
> What is the output if you run the following commands on the server:

I will have to make a testcase, sice the underlying problem was fixed a=
t the time.

> git show 3339e9f686bd4c17e

jpyeron@black /projects/git/git
$ git show 3339e9f686bd4c17e
commit 3339e9f686bd4c17e3575c71327c4ccf1e8e077b
Author: Nicolas Pitre <nico@cam.org>
Date:   Wed Jul 16 02:31:38 2008 -0400
=2E..
> git fsck
jpyeron@black /projects/git/git
$ git fsck
Checking object directories: 100% (256/256), done.
Checking objects: 100% (188541/188541), done.
Checking connectivity: 183572, done.
> git --version
> which git
>=20
> (And what on the client)

jpyeron@black /projects/git/git
$ git --version
git version 2.1.1

root@server /
# git --version
git version 1.7.9.6


--
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
This message is copyright PD Inc, subject to license 20080407P00.=20
