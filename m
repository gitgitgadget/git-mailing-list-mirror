From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: [git-new-workdir RFC] Backlinking $workdir/logs/HEAD to
	$GIT_DIR/logs/workdir?
Date: Sat, 27 Dec 2008 13:15:26 +0100
Message-ID: <20081227121526.GA12120@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 13:18:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGY7s-0004hp-T1
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 13:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbYL0MP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 07:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbYL0MP3
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 07:15:29 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4504
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbYL0MP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 07:15:29 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id A40E3801BF66
	for <git@vger.kernel.org>; Sat, 27 Dec 2008 13:15:27 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGY4k-0003DG-TU
	  for git@vger.kernel.org; Sat, 27 Dec 2008 13:15:26 +0100
Content-Disposition: inline
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104001>

Hello,

I use git new-workdir for some of my projects. Apart from the usual
caveat "don't checkout the same branch twice", I found another small
issue, surely known: the reflog for HEAD in the workidirs does not exis=
t
in the source git repo, hence git-gc will happily prune what it believe=
s
to be dangling commits.

Would it be, perhaps, be okay to create a logs/workdir/<name>/HEAD
symlink pointing to $workdir/logs/HEAD, so that this does not happen?

Comments welcome.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
                                            Listening to: Niza - Paraso=
l
