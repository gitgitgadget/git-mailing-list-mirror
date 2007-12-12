From: Florian Weimer <fweimer@bfk.de>
Subject: What to do if git-cvsimport/cvsps hangs?
Date: Wed, 12 Dec 2007 10:30:39 +0100
Message-ID: <824peojm4g.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 10:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2OCs-0007YG-2O
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbXLLJsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 04:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755738AbXLLJsY
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:48:24 -0500
Received: from mx01.bfk.de ([193.227.124.2]:48341 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbXLLJsX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 04:48:23 -0500
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2007 04:48:23 EST
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	id 1J2NvL-0005V0-Cn
	for git@vger.kernel.org; Wed, 12 Dec 2007 10:30:39 +0100
Received: from fweimer by bfk.de with local id 1J2NvL-0003vG-Bi
	for git@vger.kernel.org; Wed, 12 Dec 2007 10:30:39 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68025>

This is probably more of a cvsps question than a GIT question, but
AFAICT, the cvsps upstream is mostly inactive these days.

I tried to import the PostgreSQL repository, using

  git-cvsimport  -d :pserver:anoncvs@anoncvs.postgresql.org:/projects/c=
vsroot -k -C pgsql pgsql

However, after a bit of activity, git-cvsimport hangs at the following
line

  cvs rlog: Logging pgsql/src/win32

strace doesn't show any system call activtiy in the cvsps process
(which consumes 100% CPU).  cvsps is Debian's 2.1-2 version.

Is there some kind of replacement for cvsps which works more reliably?

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
