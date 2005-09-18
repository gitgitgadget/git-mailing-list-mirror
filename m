From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Garbage in .git directories???
Date: Sat, 17 Sep 2005 21:41:30 -0500
Message-ID: <200509172141.31591.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 18 04:42:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGp83-0005xO-O4
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 04:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVIRCli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Sep 2005 22:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVIRCli
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 22:41:38 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:33396 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751278AbVIRClh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 22:41:37 -0400
Received: (qmail 1126 invoked from network); 18 Sep 2005 02:41:33 -0000
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@69.208.153.209 with login)
  by smtp106.sbc.mail.re2.yahoo.com with SMTP; 18 Sep 2005 02:41:33 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8775>

Hi,

I just did:

git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux-2.6.git work

and it seems there is some garbage in .git directory:

[dtor@anvil work]$ ls -la .git/
total 40
drwxrwxr-x    9 dtor dtor 4096 Sep 17 21:17 .
drwxrwxr-x    3 dtor dtor 4096 Sep 17 21:17 ..
drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 branches
-rw-rw-r--    1 dtor dtor   58 Sep 17 21:17 description
lrwxrwxrwx    1 dtor dtor   17 Sep 17 21:17 HEAD -> refs/heads/master
drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 hooks
drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 info
drwxr-xr-x  260 dtor dtor 4096 Sep 17 17:41 objects
drwxrwxr-x    4 dtor dtor 4096 May  1 19:15 refs
drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:28 remotes
drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 V?Cl?=ED=AE=9F?E ???#V?C??=C5=
=BFl??E#V?C??;H
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^

The similar garbage(?) shows when I clone git's repository.

Is this expected?

--=20
Dmitry
