From: Asuka <c.bauers@gmx.de>
Subject: Cannot migrate from SVN to GIT -> Path problem
Date: Fri, 20 Jan 2012 01:26:36 -0800 (PST)
Message-ID: <1327051596101-7206879.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 10:26:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoAk8-0004Zr-3o
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 10:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab2ATJ0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 04:26:38 -0500
Received: from sam.nabble.com ([216.139.236.26]:45583 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469Ab2ATJ0h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 04:26:37 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <c.bauers@gmx.de>)
	id 1RoAk0-0008Ak-4G
	for git@vger.kernel.org; Fri, 20 Jan 2012 01:26:36 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188871>

Hi there

I=C2=B4m trying to migrate a repository from svn to git with the follow=
ing
command=20

git svn clone http://host/svn/project/subproject --no-metadata --stdlay=
out
-A ~/Desktop/users.txt subproject.=20

Unfortunately I receive no data in the new git repository except the .g=
it
folder and I get the following warning

W: Ignoring error from SVN, path probably does not exist: (175002): RA =
layer
request failed:REPORT request failed on '/svn/!svn/bc/100': REPORT of
'/svn/!svn/bc/100': 200 OK (http:/host).=20

What does that mean??

Then it seams to start a migration=20

Checked through r100
Checked through r200
Checked through r300
Checked through r400
Checked through r500

=2E.....

But as I said, I receive no data.

Does anybody know what to do now?

Best wishes




--
View this message in context: http://git.661346.n2.nabble.com/Cannot-mi=
grate-from-SVN-to-GIT-Path-problem-tp7206879p7206879.html
Sent from the git mailing list archive at Nabble.com.
