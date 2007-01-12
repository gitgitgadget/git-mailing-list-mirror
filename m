From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: 1.5.0.rc1.g4494: Can't use a bare GIT_DIR to add
Date: Fri, 12 Jan 2007 12:45:22 -0300
Message-ID: <200701121545.l0CFjMC1017088@laptop13.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Jan 12 16:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Oat-00071c-VA
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 16:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbXALPpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 10:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbXALPpZ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 10:45:25 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55694 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932120AbXALPpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 10:45:25 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0CFjNWE001841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 12 Jan 2007 12:45:23 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0CFjMC1017088
	for <git@vger.kernel.org>; Fri, 12 Jan 2007 12:45:22 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 12 Jan 2007 12:45:23 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2437/Thu Jan 11 20:59:09 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36680>

I tried this:
  
  mkdir xyz
  cd xyz
  git --git-dir=../xyz.git   
     # Initialized empty Git repository in ../xyz.git/
  echo Junk > file-a
  git --git-dir=../xyz.git add .
     # fatal: add cannot be used in a bare git directory

I expected that "GIT_DIR is bare, over there, stuff is here" works the same
as "GIT_DIR is .git, right here among stuff".
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
