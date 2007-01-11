From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: git master (2a3a3) build failure
Date: Thu, 11 Jan 2007 11:13:13 -0300
Message-ID: <200701111413.l0BEDDJv024060@laptop13.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Thu Jan 11 15:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H50gA-0004I0-L6
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 15:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbXAKONQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 09:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbXAKONQ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 09:13:16 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46478 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030378AbXAKONP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 09:13:15 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0BEDDtl006905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 11 Jan 2007 11:13:13 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0BEDDJv024060
	for <git@vger.kernel.org>; Thu, 11 Jan 2007 11:13:13 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 11 Jan 2007 11:13:13 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2436/Thu Jan 11 08:48:19 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36593>

I'm getting:

  install: cannot stat `git-init.1': No such file or directory
  make[1]: *** [install] Error 1

In Documentation/git-init.txt just includes git-init-db.txt, asciidoc
creates a git-init.xml, and from this xmlto generates git-init-db.1 (the
XML says the refentrytitle is git-init-db).

Fedora rawhide, asciidoc-7.0.2-3.fc6, xmlto-0.0.18-13.1


Is git-init-db going away for git-init?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
