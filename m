From: "Greg Lee" <glee@casabyte.com>
Subject: Problem with git bisect between 2.6.15 and 2.6.16
Date: Mon, 27 Mar 2006 19:00:25 -0500
Message-ID: <0e7301c651fa$9e0fd770$a100a8c0@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Mar 28 02:02:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO1fS-00047p-G7
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 02:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWC1AC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 19:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWC1AC2
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 19:02:28 -0500
Received: from mail.vtacs.com ([207.42.84.219]:62380 "EHLO mail.vtacs.com")
	by vger.kernel.org with ESMTP id S932122AbWC1AC2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 19:02:28 -0500
Received: from GregDesktop (e242.vtacs.com [207.42.84.242])
	by mail.vtacs.com (8.13.6/8.13.3) with ESMTP id k2S02NUd006308
	for <git@vger.kernel.org>; Mon, 27 Mar 2006 19:02:26 -0500
To: <git@vger.kernel.org>
X-Mailer: Microsoft Office Outlook 11
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcZR+p3PP48FSqIeQ+WsHauvIUeF6A==
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18090>

I get the following when I try to git bisect between 2.6.15 and 2.6.16:
 
[root@Fedora-test tmp]# git clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-git
[root@Fedora-test linux-git]# git bisect start
[root@Fedora-test linux-git]# cd linux-git
[root@Fedora-test linux-git]# git bisect good v2.6.16
[root@Fedora-test linux-git]# git bisect bad v2.6.15
dab47a31f42a23d2b374e1cd7d0b797e8e08b23d was both good and bad

What is the proper method to do a bisect between 2.6.15 and 2.6.16?

Greg
