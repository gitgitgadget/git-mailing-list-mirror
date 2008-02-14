From: Sergei Organov <osv@javad.com>
Subject: git clone through http bug?
Date: Thu, 14 Feb 2008 20:27:22 +0300
Message-ID: <873arvv479.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 18:28:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhsT-0005nI-9b
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbYBNR1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbYBNR1b
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:27:31 -0500
Received: from javad.com ([216.122.176.236]:3608 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbYBNR1b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:27:31 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m1EHRSd67508
	for <git@vger.kernel.org>; Thu, 14 Feb 2008 17:27:29 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JPhrm-0000fO-7R
	for git@vger.kernel.org; Thu, 14 Feb 2008 20:27:22 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73896>

Hello,

I've just cloned the public repo (it's rather small):

$ git clone http://ydirson.free.fr/soft/git/cvsps.git

and it has created cvsps/.git, but no working copy. When I examine the
contents, I also notice that while the file .git/HEAD has:

ref: refs/heads/master

there is no .git/refs/heads/master file (the directory .git/refs/heads
is empty).

Now, if I first clone the original repository as --bare, and then make a
usual local clone from it, the local clone looks file:

$ git clone --bare http://ydirson.free.fr/soft/git/cvsps.git
$ git clone cvsps.git cvsps.cloned

Is it a problem with clone over http, a problem with the repository, or
it's me who does something wrong?

-- Sergei.
