From: =?ISO-8859-1?Q?R=FCdiger?= Sonderfeld <ruediger@c-plusplus.de>
Subject: git-remote-bzr: fatal: mark :399654 not declared
Date: Thu, 06 Feb 2014 19:05:07 +0100
Message-ID: <8513837.uWFUjXk7Vu@descartes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 19:14:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBTTH-0002pT-T4
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 19:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbaBFSOj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 13:14:39 -0500
Received: from ptmx.org ([178.63.28.110]:35320 "EHLO ptmx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbaBFSOi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 13:14:38 -0500
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2014 13:14:38 EST
Received: from localhost (localhost [127.0.0.1])
	by ptmx.org (Postfix) with ESMTP id B145B258C4;
	Thu,  6 Feb 2014 19:05:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ptmx.org
Received: from ptmx.org ([127.0.0.1])
	by localhost (ptmx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xi22sACmIRkN; Thu,  6 Feb 2014 19:05:13 +0100 (CET)
Received: from descartes.localnet (chello080108246092.7.14.vie.surfer.at [80.108.246.92])
	by ptmx.org (Postfix) with ESMTPSA id 71FAD252EA;
	Thu,  6 Feb 2014 19:05:13 +0100 (CET)
User-Agent: KMail/4.11.3 (Linux/3.11.0-15-generic; KDE/4.11.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241707>

Hello,
I'm using git-remote-bzr to access the GNU Emacs Bazaar repo.  I follow=
ed the=20
guideline described here:=20
https://lists.gnu.org/archive/html/emacs-devel/2013-05/msg00008.html

Pulling and pushing worked flawless for several month.  But recently gi=
t=20
bzr stopped working with the following error message:

$ git pull
fatal: mark :399654 not declared
fast-import: dumping crash report to .git/fast_import_crash_16173
fatal: Error while running fast-import
Traceback (most recent call last):
  File "/usr/bin/git-remote-bzr", line 947, in <module>
    sys.exit(main(sys.argv))
  File "/usr/bin/git-remote-bzr", line 931, in main
    do_import(parser)
  File "/usr/bin/git-remote-bzr", line 399, in do_import
    export_branch(repo, name)
  File "/usr/bin/git-remote-bzr", line 327, in export_branch
    modified_final =3D export_files(cur_tree, modified)
  File "/usr/bin/git-remote-bzr", line 272, in export_files
    print d
IOError: [Errno 32] Broken pipe

And the crash report

$ cat .git/fast_import_crash_16173
fast-import crash report:
    fast-import process: 16173
    parent process     : 16172
    at Thu Feb 6 18:38:00 2014

fatal: mark :399654 not declared

Most Recent Commands Before Crash
---------------------------------
  feature done
  feature import-marks=3D.git/bzr/origin/marks-git
  feature export-marks=3D.git/bzr/origin/marks-git
  feature force
  blob
  mark :399656
  data 145827
  blob
  mark :399657
  data 19785
  blob
  mark :399658
  data 228415
  commit refs/bzr/origin/heads/trunk
  mark :399659
  author Glenn Morris <rgm@gnu.org> 1391150391 -0800
  committer Glenn Morris <rgm@gnu.org> 1391150391 -0800
  data 101
* from :399654

Active Branch LRU
-----------------
    active_branches =3D 0 cur, 5 max

  pos  clock name
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Inactive Branches
-----------------
refs/bzr/origin/heads/trunk:
  status      : dirty
  tip commit  : 0000000000000000000000000000000000000000
  old tree    : 0000000000000000000000000000000000000000
  cur tree    : 0000000000000000000000000000000000000000
  commit clock: 0
  last pack   :


Marks
-----
  exported to .git/bzr/origin/marks-git

-------------------
END OF CRASH REPORT

$ tail .git/bzr/origin/marks-git
:399643 b535a54e6bd1b98953aacda8e0c0bd4ffa4348e8
:399646 2c7d42a26b8984b4492b205f28b0de2ff8548a16
:399647 408cc787f4764481e8ca10861895970e579dec07
:399648 798ea0615d18b41dfe0dee321b286fd3570a4352
:399651 dfba6da980cfe657cb1be302131325011f5eb97d
:399652 5964046e0475262b27157e39ceb7516b1222330c
:399653 52dd3850ce599215898f5358997dd07f08c4d607
:399656 230b94e2fe9c6443b2ada399d8d985c7ae438727
:399657 8d0fc723f14c9b4a9de30754170b5ca5be21a05a
:399658 102818c18b5a0724dc1c11dc5dcf5e2ba5b72b22

I'm using git version 1.8.5.3 on Kubuntu 13.10 installed from=20
https://launchpad.net/~git-core/+archive/ppa.

What's wrong and how can I fix this?

Regards,
R=C3=BCdiger
