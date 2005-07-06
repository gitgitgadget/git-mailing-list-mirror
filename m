From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: BUG: cg-clone accepts '_' in git_ssh: URI's, but cg-push does not.
Date: Wed, 06 Jul 2005 12:58:07 -0400
Message-ID: <200507061658.j66Gw7Me014155@laptop11.inf.utfsm.cl>
References: <john.ellson@comcast.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 19:03:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqDId-0008VE-Vp
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 19:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVGFRCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGFRBW
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 13:01:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30852 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262336AbVGFQ6M (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 12:58:12 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j66Gw7hp002039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Jul 2005 12:58:07 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j66Gw7Me014155;
	Wed, 6 Jul 2005 12:58:07 -0400
To: John Ellson <john.ellson@comcast.net>
In-Reply-To: Message from John Ellson <john.ellson@comcast.net> 
   of "Tue, 05 Jul 2005 23:08:55 -0400." <pan.2005.07.06.03.08.55.724181@comcast.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 06 Jul 2005 12:58:07 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

John Ellson <john.ellson@comcast.net> wrote:
> BUG: cg-clone accepts '_' in git+ssh: URI's, but cg-push does not.

Right. '_' is illegal in domain names...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
