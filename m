From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Some cleanups
Date: Thu, 25 Jan 2007 09:50:06 -0300
Message-ID: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 13:50:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA43n-0007U9-R2
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 13:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbXAYMuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 07:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXAYMuW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 07:50:22 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37835 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965284AbXAYMuV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 07:50:21 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0PCoAFI029536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jan 2007 09:50:10 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0PCo89m011511;
	Thu, 25 Jan 2007 09:50:08 -0300
Received: (from vonbrand@localhost)
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8/Submit) id l0PCo7xL011510;
	Thu, 25 Jan 2007 09:50:07 -0300
X-Mailer: git-send-email 1.5.0.rc2
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [0.0.0.0]); Thu, 25 Jan 2007 09:50:10 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2488/Thu Jan 25 06:57:17 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37719>

The official name of the hash function is SHA-1. I tried to make the usage
more consistent in the documentation, the comments and the messages (it
was variously sha1, SHA1, etc). Also some comment reformatting while I was
at it. The resulting git passes all tests.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
