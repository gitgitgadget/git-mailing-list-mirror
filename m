From: picca@synchrotron-soleil.fr
Subject: problem with git-cvsimport
Date: Mon, 2 Oct 2006 11:15:34 +0200
Organization: Synchrotron-soleil.fr
Message-ID: <20061002111534.eaadb330.picca@synchrotron-soleil.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 02 11:15:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUJtk-0005qn-4Z
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 11:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWJBJPh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 05:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWJBJPh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 05:15:37 -0400
Received: from dns.synchrotron-soleil.fr ([195.221.0.3]:8654 "EHLO
	sucette.synchrotron-soleil.fr") by vger.kernel.org with ESMTP
	id S1750952AbWJBJPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 05:15:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id F10987C4BA
	for <git@vger.kernel.org>; Mon,  2 Oct 2006 11:15:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from sucette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (sucette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yp1vsJ007Tmh for <git@vger.kernel.org>;
	Mon,  2 Oct 2006 11:15:33 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id A2B8E7C4B6
	for <git@vger.kernel.org>; Mon,  2 Oct 2006 11:15:33 +0200 (CEST)
Received: from localhost.localdomain ([195.221.5.120]) by venusbis.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 2 Oct 2006 11:16:08 +0200
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-OriginalArrivalTime: 02 Oct 2006 09:16:08.0995 (UTC) FILETIME=[65914F30:01C6E603]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28222>

Hello

I tryed to import this sourceforge project with git-cvsimport
The command was:

git-cvsimport -v -d :pserver:anonymous@tango-cs.cvs.sourceforge.net:/cvsroot/tango-cs -C tango.git tango

unfortunetly the command stop with this error:

skip patchset 3713: 1159522283 before 1159522323
skip patchset 3714: 1159522323 before 1159522323
DONE.
fatal: Needed a single revision
fatal: Needed a single revision
Usage: /usr/bin/git-merge [-n] [--no-commit] [--squash] [-s <strategy>]... <merg
e-message> <head> <remote>+
Could not merge origin into the current branch.

I am using the debian testing git-core version aka 1.4.1.1

Why ?


Have a nice day.
