From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: git rev-parse --verify HEAD: fatal: Needed a single revision
Date: Fri, 01 Aug 2008 11:29:04 +0200
Message-ID: <g6ul10$rr9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 11:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOqxl-00015b-Ks
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 11:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443AbYHAJ3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2008 05:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbYHAJ3T
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 05:29:19 -0400
Received: from main.gmane.org ([80.91.229.2]:43995 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756443AbYHAJ3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 05:29:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KOqwk-00059J-6D
	for git@vger.kernel.org; Fri, 01 Aug 2008 09:29:14 +0000
Received: from chello089076022019.chello.pl ([89.76.22.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 09:29:14 +0000
Received: from arekm by chello089076022019.chello.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 09:29:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chello089076022019.chello.pl
User-Agent: KNode/0.10.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91046>


Hello,

I'm trying to git cvsimport a cvs repository. Process ends with:
DONE.
fatal: Needed a single revision
Can merge only exactly one commit into empty head
Could not merge origin into the current branch.

The fatal comes from:
$ git rev-parse --verify HEAD
fatal: Needed a single revision


What is the problem here and how to fix it?



How to reproduce:
get http://carme.pld-linux.org/~arekm/rpm5.tar.bz2
unpack
cd rpm5
git cvsimport -v -d :pserver:anonymous@rpm5.org:/cvs rpm


I'm using:
$ git --version
git version 1.5.6.4

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
