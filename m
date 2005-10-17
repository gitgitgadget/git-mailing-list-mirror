From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Strange differences in cogito on SPARC and i386
Date: Mon, 17 Oct 2005 16:06:10 -0300
Message-ID: <200510171906.j9HJ6AQr015777@laptop11.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Mon Oct 17 21:08:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERaJo-0003fo-F9
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 21:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVJQTGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVJQTGO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 15:06:14 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51106 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932267AbVJQTGN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2005 15:06:13 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9HJ6BK0000536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 17 Oct 2005 16:06:11 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9HJ6AQr015777
	for <git@vger.kernel.org>; Mon, 17 Oct 2005 16:06:11 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 17 Oct 2005 16:06:11 -0300 (CLST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 17 Oct 2005 15:20:38 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10189>

git, cogito up to date everywhere.

I updated my linux-2.6.git trees on SPARC and i386 yesterday at almost the
same time, and I then noted that on the SPARC I'd get interrupted fetches
and stuff like:

  
   [vonbrand@pincoya linux-2.6.git]$ cg-update
   Recovering from a previously interrupted fetch...
   15:04:56 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
   Getting alternates list
   progress: 10 objects, 24166 bytes
   error: Empty reply from server (curl_result = 52, http_code = 0, sha1 = 0801ec7bf4953784f0f3279c1a80258ad29094d6)
   Getting pack list
   progress: 11 objects, 24873 bytes
   error: Unable to find 0801ec7bf4953784f0f3279c1a80258ad29094d6 under http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/

Just started again each time, seems to work fine. On i386 the download goes
smoothly, no hickups. And there are /no/ updates while SPARC is working its
head off getting updates...

Then again, today on the SPARC it is getting several thousand objects (!),
while on i386 it was only a few dozen.

Some stupid pilot error? Got different mirrors between machines? Sounds
unlikely, as repeating the command (and presumably rotating between DNS
entries) makes no difference.

Just finished SPARCwise. Almost 10K objects for changes to 4 files?! Yes,
the files changed are the same on both machines.

Mistified...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

--j9HIKc4x028468.1129573238/inti.inf.utfsm.cl--
