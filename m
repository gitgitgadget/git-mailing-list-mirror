From: Eric James Michael Ritz <Eric@cybersprocket.com>
Subject: Replacing a Remote Branch
Date: Fri, 23 Jul 2010 16:14:51 -0400
Organization: Cyber Sprocket Labs
Message-ID: <4C49F83B.4060903@cybersprocket.com>
Reply-To: Eric@cybersprocket.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 22:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcOjC-0002G2-6c
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 22:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab0GWUUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 16:20:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:57194 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754868Ab0GWUUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 16:20:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OcOiy-00027J-5d
	for git@vger.kernel.org; Fri, 23 Jul 2010 22:20:04 +0200
Received: from 173.221.45.130.nw.nuvox.net ([173.221.45.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 22:20:04 +0200
Received: from Eric by 173.221.45.130.nw.nuvox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 22:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173.221.45.130.nw.nuvox.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Thunderbird/3.0.5
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151571>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello everyone.  I have a question about pushing branches that I hope
a more experienced user could help me with.

Commonly I run into this situation:

  1. I have pushed a topic branch out to a repo where other developers
  on my team push their work until its ready to be merged.

  2. I realized I need to perform some =E2=80=98destructive=E2=80=99 ac=
tion like
  =E2=80=98rebase -i=E2=80=99 or amend the last commit to fix a typo in=
 the message.

  3. Then I want to push the changed branch as a replacement.

Currently I deal with this by running

    $ git push origin :foo && git push origin foo

to replace `foo`.  But is there a shorter way to do this?  I thought
that writing something like

    $ git push origin +foo:foo

may have the intended effect, but I still get a rejection due to a
non-fast-forward, so I am likely misunderstanding the purpose of `+`.

If there is any short-cut for this, I would greatly appreciate it.
And if not, writing a simple script is not a huge hassle :)

- --
Eric James Michael Ritz
Cyber Sprocket Labs
(843) 225-3830
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJMSfg7AAoJEEHUZXw5hMWshwAIALOnsArQIWoxXNmOVNvi3ptd
oXpUXbfX2ZgMnhOQAYmJXYjkqc/fKFh+MultDP1PRgQwPdPCEUfK/n5TEJXB66Jf
nsgnGWIHk7nULuKJmCb9BrDd+xVI4tvbhI3gZYXrypoWdrfUat9rlUL52+eiAXp7
CG/FQrSoFRydREGUuAi1UNtTPt9UG2MT65dEx/S8wqRn8phpJHZI94mKOVZ58lI1
oQDfx+Ox6p2RJG/HRrX7/jWOiGzMk3Ix/cToAaltBWWp7MgvDq31pjrN0TZJfUu+
+vcgafAqseXDDuStlEGd8O5WT+uRYjn9/K3YHf55MKsMvKVzNxgS8IHQGzC+Yk4=3D
=3D/0uY
-----END PGP SIGNATURE-----
