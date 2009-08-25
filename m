From: Fritz Anderson <fritza@uchicago.edu>
Subject: Confused about push/pull of a branch
Date: Tue, 25 Aug 2009 12:40:47 -0500
Message-ID: <BA2E0DDB-3DE0-4D49-BFA6-72CFEDEBA5AE@uchicago.edu>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=windows-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 19:48:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg08B-0004Fq-6C
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 19:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbZHYRsS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2009 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755299AbZHYRsS
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 13:48:18 -0400
Received: from authsmtp00.uchicago.edu ([128.135.249.245]:49405 "EHLO
	authsmtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbZHYRsR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2009 13:48:17 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2009 13:48:17 EDT
Received: from fritzanderson.uchicago.edu (fritzanderson.uchicago.edu [128.135.0.17])
	(authenticated bits=0)
	by authsmtp00.uchicago.edu (8.13.1/8.13.1) with ESMTP id n7PHemgY004451
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 25 Aug 2009 12:40:48 -0500
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127034>

I can't get a second machine to pull in a branch that's in my remote =20
repository. I'm confused.

The remote is a bare repository on machine_1.

In my working copy on machine_1:

machine_1$ git branch
   master
   search-controller
   use-tiles
* webservices
# The following should not be necessary, as gitk already
# identifies a remotes/origin/webservices, but just to be sporting:
machine_1$ git push origin webservices
Everything up-to-date

Branch webservices was created after the working copy on machine_2 was =
=20
cloned.

In my working copy on machine_2:

machine_2$ git pull
Password:
# Progress messages, no protests.
machine_2$ git checkout webservices
error: pathspec 'webservices' did not match any file(s) known to git.
machine_2$ git branch
* master
machine_2$

git-config shows the two repository URLs are identical, net of =20
machine_2 having to specify a user name and host. The machine_2 .git/=20
config shows a section for [branch "master"], but not for webservices. =
=20
Is that the problem? What's the approved way of adding [branch =20
"webservices"], and what do I put into it?

I've obviously forgotten something. Or never understood something =20
(there's a lot in Git not to understand). How do I get the webservices =
=20
branch onto machine_2, so I can check it out?

	=97 F
