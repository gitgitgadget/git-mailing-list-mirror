From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Documentation/tutorial: misc updates
Date: Wed, 03 Jan 2007 21:09:43 -0300
Message-ID: <200701040009.l0409hQV008867@laptop13.inf.utfsm.cl>
References: <jnareb@gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 02:17:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2HE1-0004fv-SU
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 02:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbXADBQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 20:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbXADBQz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 20:16:55 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55686 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932218AbXADBQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 20:16:54 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l041GROv009587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jan 2007 22:16:49 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0409hQV008867;
	Wed, 3 Jan 2007 21:09:44 -0300
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: Message from Jakub Narebski <jnareb@gmail.com> 
   of "Wed, 03 Jan 2007 15:07:41 BST." <engd5e$8fr$1@sea.gmane.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 03 Jan 2007 22:16:50 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35900>

Jakub Narebski <jnareb@gmail.com> wrote:
> Horst H. von Brand wrote:
> 
> >> +------------------------------------------------
> >> +$ git branch -d experimental
> >> +------------------------------------------------
> >> +
> >> +This command ensures that the changes in the experimental branch are
> >> +already in the current branch.
> >> +

> > Huh? This deletes the branch, it doesn't ensure changes have been saved.

> It ensures that the branch we want to delete is in lineage of
> current branch (otherwise we would have to use -D).

I know. But it doesn't "ensure" anything, the /user/ has to ensure
beforehand that there are no outstanding changes for it to succeed. Fine
distinction, I know. But better be extra clear.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
