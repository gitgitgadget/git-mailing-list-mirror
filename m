From: picca <picca@synchrotron-soleil.Fr>
Subject: newby question about merge.
Date: Tue, 15 May 2007 11:38:20 +0200
Organization: Soleil
Message-ID: <20070515113820.2621c8d5@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 11:59:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hntof-0000Pi-1p
	for gcvg-git@gmane.org; Tue, 15 May 2007 11:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbXEOJ7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 05:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759438AbXEOJ7b
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 05:59:31 -0400
Received: from dns2.synchrotron-soleil.fr ([195.221.0.6]:55023 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754713AbXEOJ7a convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 05:59:30 -0400
X-Greylist: delayed 1267 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 May 2007 05:59:30 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id DC157783EB
	for <git@vger.kernel.org>; Tue, 15 May 2007 11:38:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9GmOhWVWIncZ for <git@vger.kernel.org>;
	Tue, 15 May 2007 11:38:19 +0200 (CEST)
Received: from venus.synchrotron-soleil.fr (venus.synchrotron-soleil.fr [195.221.0.131])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id DD90178367
	for <git@vger.kernel.org>; Tue, 15 May 2007 11:38:19 +0200 (CEST)
Received: from lune1.synchrotron-soleil.fr ([195.221.0.153]) by venus.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 15 May 2007 11:38:21 +0200
Received: from localhost.localdomain ([195.221.5.120]) by lune1.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 15 May 2007 11:39:57 +0200
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-OriginalArrivalTime: 15 May 2007 09:39:57.0663 (UTC) FILETIME=[00107EF0:01C796D5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47332>

Hello I am using git to deal with debian packages.
So i have two Branches the "upstream" one with the different version of
the programm I am packaging.

exemple with two tags

scigraphica/2.1.0
scigraphica/0.8.0

I have another branch the master one which is the upstream + the debian
directory.

So I do a merge like this
"git merge upstream ." when I am on the master branch to work on the ne=
w
package.

Everything is fine until git merge the configure scripts. (autotools)
there is conflict with the configure file of the 0.8.0 version during
the last merge.

My question is how can I keep the upstream version of the configure
file instread of the one in the working directory.

I read about the stage(1:2:3) but I do not know how if it is related to
my problem.

Thanks in advance.

=46r=C3=A9d=C3=A9ric
