From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: 1.5.0.rc1.gf4b6c: git-cvsimport: Some nits
Date: Mon, 15 Jan 2007 15:42:01 -0300
Message-ID: <200701151842.l0FIg1nT023520@laptop13.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Mon Jan 15 21:13:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6WmW-00016b-0z
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 19:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbXAOSmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 13:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXAOSmE
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 13:42:04 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42334 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbXAOSmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 13:42:03 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0FIg1Q3021890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 15:42:01 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0FIg1nT023520
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 15:42:01 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 15 Jan 2007 15:42:01 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2451/Mon Jan 15 07:27:30 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36876>

Running cvsimport with bogus arguments gives an usage message including -a,
which is gone (at least the latest man page doesn't mention it anymore).

Besides, running git-cvsimport in something that isn't a repo gives the
(useless) error message:

  CVSROOT needs to be set at /home/vonbrand/bin/git-cvsimport line 105.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
