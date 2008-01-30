From: picca <picca@synchrotron-soleil.Fr>
Subject: Problem with cvsimport
Date: Wed, 30 Jan 2008 11:53:08 +0100
Organization: Soleil
Message-ID: <20080130115308.760d6e20@synchrotron-soleil.Fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 11:54:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKAZu-0002JS-25
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 11:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbYA3KxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 05:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbYA3KxW
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 05:53:22 -0500
Received: from raclette.synchrotron-soleil.fr ([195.221.0.6]:33828 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758666AbYA3KxO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jan 2008 05:53:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 1301A3003C
	for <git@vger.kernel.org>; Wed, 30 Jan 2008 11:38:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oh8NfUWWpUm5 for <git@vger.kernel.org>;
	Wed, 30 Jan 2008 11:38:17 +0100 (CET)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 5CB97300E3
	for <git@vger.kernel.org>; Wed, 30 Jan 2008 11:38:17 +0100 (CET)
Received: from localhost.localdomain ([195.221.5.120]) by venusbis.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 30 Jan 2008 11:54:08 +0100
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.12.5; i486-pc-linux-gnu)
X-OriginalArrivalTime: 30 Jan 2008 10:54:08.0031 (UTC) FILETIME=[7017C2F0:01C8632E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72054>

Hello


When I try to import a project into git with the cvsimport tool, it
works fine most of the time. I obtain a clean repository without all
thoses CVS directories.

But sometimes during the import the cvs server hang and i need to do
Ctrl+C the restart the command.
cvsimport skip the already downloaded patchset but at the end I obtain
this message

---
Generating pack...
Done counting 1534 objects.
Deltifying 1534 objects...
 100% (1534/1534) done
Writing 1534 objects...
 100% (1534/1534) done
Total 1534 (delta 1160), reused 0 (delta 0)
Pack pack-8fb4f1c25c831ba29c7bd53989cb1b445b60bc07 created.
Removing unused objects 100%...
Done.
DONE.
fatal: Needed a single revision
Can merge only exactly one commit into empty head
Could not merge origin into the current branch.
---

So to resume:
* In one shoot no problem at the end cvsimport checkout the
right head.
* multiple shoot impossible to merge origin into the current branch.

How this problem can be solved ?

Thanks

Frederic
