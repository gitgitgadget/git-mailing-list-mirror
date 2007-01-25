From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: git-1.5.0.rc2: "git pull -t" complains
Date: Wed, 24 Jan 2007 22:37:27 -0300
Message-ID: <200701250137.l0P1bRYm020504@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 02:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9tYY-0001OH-Lq
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 02:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbXAYBhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 20:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbXAYBhd
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 20:37:33 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38651 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965114AbXAYBhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 20:37:32 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0P1bSjl004992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 24 Jan 2007 22:37:28 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0P1bRYm020504
	for <git@vger.kernel.org>; Wed, 24 Jan 2007 22:37:27 -0300
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
Content-ID: <20502.1169689047.1@laptop13.inf.utfsm.cl>
X-Greylist: Delayed for 77:50:53 by milter-greylist-3.0 (inti.inf.utfsm.cl [0.0.0.0]); Wed, 24 Jan 2007 22:37:29 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.7, clamav-milter version 0.88.7 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37701>

I've got a repo here which is missing oldish tags, so I:

   $ git pull -t
   Warning: No merge candidate found because value of config option
	    "branch.master.merge" does not match any remote branch fetched.
   No changes.

Both "git pull --help" and git-pull(1) say this should work.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
