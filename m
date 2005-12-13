From: Pavel Roskin <proski@gnu.org>
Subject: qgit reports errors in the git repository
Date: Mon, 12 Dec 2005 19:24:00 -0500
Message-ID: <1134433440.3798.27.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Dec 13 01:25:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elxxg-0004Hn-Dg
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 01:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVLMAYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 19:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVLMAYF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 19:24:05 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:36994 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932245AbVLMAYE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 19:24:04 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ElxwU-0005zI-U6
	for git@vger.kernel.org; Mon, 12 Dec 2005 19:22:55 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1ElxxY-0005Pp-Lv; Mon, 12 Dec 2005 19:24:00 -0500
To: git <git@vger.kernel.org>, Marco Costalba <mcostalba@yahoo.it>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13550>

Hello!

qgit reports an error from git-cat-file when run in the git repository.
The error shown in a message box with the text:

Git says:
fatal: git-cat-file 23ea3e201cea0deea909569e08e950a9ec2345f7: bad file

I believe qgit runs "git-cat-file -t tag" on in, but it's a commit.  If
I change the git-cat-file invocation in  src/git_startup.cpp to use
"commit" instead of "tag", qgit complains about
0918385dbd9656cab0d1d81ba7453d49bbc16250.

Maybe qgit should check the type of the object first?  Or maybe there
should another type for git-cat-file that would match both tag and
commit?

-- 
Regards,
Pavel Roskin
