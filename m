From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Scribblings for a cogito/git tutorial
Date: Mon, 17 Oct 2005 12:04:54 -0300
Message-ID: <200510171504.j9HF4stb006164@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Oct 17 17:05:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERWYg-0005SX-Ju
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 17:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVJQPFr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVJQPFr
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 11:05:47 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59621 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751386AbVJQPFq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2005 11:05:46 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9HF4t3O010544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Oct 2005 12:04:56 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9HF4stb006164;
	Mon, 17 Oct 2005 12:04:54 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Content-ID: <6162.1129561494.1@laptop11.inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 17 Oct 2005 12:04:56 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10185>

I've also been asked around here for a cogito+git tutorial, to that end
I've made up a script that simulates several developers interacting.
Hacking around is simulated by patching, ed(1) scripts (merges don't turn
out the same diff every time), and plain copying new files in. I've set up
a GPG key with an empty passphrase (comment is "Experimental") to have
signed tags, etc. in a convenient manner. The idea is to create interesting
histories (for browsing) and show off the commands in a compact way. If
only there was a convenient way to run a strech of the (bash) script, look
at the results, and then resume...

Comments, suggestions, patches are welcome! 

Repository of the script and supporting files is at
<http://pincoya.inf.utfsm.cl/Script.git>
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
