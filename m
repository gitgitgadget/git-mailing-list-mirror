From: Simon Josefsson <simon@josefsson.org>
Subject: ANNOUNCE: git2cl
Date: Fri, 02 Mar 2007 10:03:09 +0100
Message-ID: <87mz2wrp9u.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 10:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN3fo-0003jx-10
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 10:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbXCBJD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 04:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbXCBJD2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 04:03:28 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:36900
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422742AbXCBJD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 04:03:26 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l22939Lt020984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 2 Mar 2007 10:03:12 +0100
X-Hashcash: 1:22:070302:git@vger.kernel.org::KViRz0RFsEl2dH0F:qcx
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-0.7 required=4.0 tests=AWL,BAYES_50 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41170>

Hi!  I really need proper GNU ChangeLog functionality for my projects,
so I ended up writing my own script to do this in Perl.  Below is the
README, but you can find more information at:

http://josefsson.org/git2cl/

I push my changes to:

http://repo.or.cz/w/git2cl.git

I've enabled so that the 'mob' user can apply changes, so feel free to
improve on it if you like.

/Simon

git2cl
======

This is a quick'n'dirty tool to convert git logs to GNU ChangeLog
format.

The tool expects output from 'git --pretty --numstat --summary' on
stdin.  Thus, typically you would use it as follows:

...........................................................................
jas@mocca:~/src/libtasn1$ git log --pretty --numstat --summary | ~/src/git2cl/git2cl > ChangeLog
jas@mocca:~/src/libtasn1$
...........................................................................

The output format is specified by:

link:http://www.gnu.org/prep/standards/html_node/Change-Logs.html[]

In the future, git2cl may be modified to run this command itself,
similar to how cvs2cl works.

My inspiration for writing this tool was the
link:http://www.red-bean.com/cvs2cl/[cvs2cl] tool, which I am using in
several projects.  Replacing it is a necessary condition for me to
seriously consider switching from CVS to GIT for my projects.

Currently, git2cl lacks much of the flexibility in git2cl.  Sheesh,
git2cl doesn't even have command line parameters!

The canonical home page for git2cl is:
link:http://josefsson.org/git2cl/[] and its repository can be found at
link:http://repo.or.cz/w/git2cl.git[].

Support
-------

Try talking to mailto:simon@josefsson.org[Simon Josefsson].
