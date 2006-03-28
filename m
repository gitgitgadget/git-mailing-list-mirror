From: "Greg Lee" <glee@casabyte.com>
Subject: RE: Problem with git bisect between 2.6.15 and 2.6.16
Date: Mon, 27 Mar 2006 19:16:40 -0500
Message-ID: <0e7e01c651fc$e30a2860$a100a8c0@casabyte.com>
References: <BAYC1-PASMTP036F0DBE8F7101BCAD5470AED30@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Mar 28 02:18:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO1v6-0006QD-5T
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 02:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWC1ASp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 19:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWC1ASp
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 19:18:45 -0500
Received: from mail.vtacs.com ([207.42.84.219]:21421 "EHLO mail.vtacs.com")
	by vger.kernel.org with ESMTP id S932085AbWC1ASo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 19:18:44 -0500
Received: from GregDesktop (e242.vtacs.com [207.42.84.242])
	by mail.vtacs.com (8.13.6/8.13.3) with ESMTP id k2S0IbvS006535;
	Mon, 27 Mar 2006 19:18:41 -0500
To: "'sean'" <seanlkml@sympatico.ca>, <git@vger.kernel.org>
X-Mailer: Microsoft Office Outlook 11
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <BAYC1-PASMTP036F0DBE8F7101BCAD5470AED30@CEZ.ICE>
Thread-Index: AcZR+9d0DlvtZ9b4QGi5bOHAVDiaigAAGdyQ
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18094>

> You need to do the bisect start after you cd into the linux-git 
> directory.

Sorry, cut and paste error, I did the cd before the bisect:

[root@Fedora-test git]# git clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-git-fresh
[root@Fedora-test git]# cd linux-git-fresh/
[root@Fedora-test linux-git-fresh]# git bisect start
[root@Fedora-test linux-git-fresh]# git bisect bad v2.6.15
[root@Fedora-test linux-git-fresh]# git bisect good v2.6.16
dab47a31f42a23d2b374e1cd7d0b797e8e08b23d was both good and bad

> Also, it appears you have the good and bad reversed,
> presumably the newer (v2.6.16) is bad, and the older (v.2.6.15)
> is good.

No, the problem was fixed in 2.6.16 and I'm trying to figure out what fixed it so that I
can back-port the fix into a previous kernel version, so 2.6.16 is good and 2.6.15 is bad.

Greg
