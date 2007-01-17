From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Wed, 17 Jan 2007 17:17:18 -0300
Message-ID: <200701172017.l0HKHIA8032440@laptop13.inf.utfsm.cl>
References: <17437.1168911089@lotus.CS.Berkeley.EDU> <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net> <200701171629.l0HGTCE3019292@laptop13.inf.utfsm.cl> <7vk5zlsglk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701171804260.26185@reaper.quantumfyre.co.uk>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 21:17:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7HE3-0006ah-NH
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 21:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbXAQURg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 15:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbXAQURg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 15:17:36 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57628 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932734AbXAQURg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 15:17:36 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0HKHKat029676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jan 2007 17:17:20 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0HKHIA8032440;
	Wed, 17 Jan 2007 17:17:19 -0300
To: Julian Phillips <julian@quantumfyre.co.uk>
In-reply-to: <Pine.LNX.4.64.0701171804260.26185@reaper.quantumfyre.co.uk>
Comments: In-reply-to Julian Phillips <julian@quantumfyre.co.uk>
   message dated "Wed, 17 Jan 2007 18:07:20 -0000."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 17 Jan 2007 17:17:20 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2460/Wed Jan 17 14:26:31 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37036>

Julian Phillips <julian@quantumfyre.co.uk> wrote:

[...]

> printf is a bash builtin ... not sure about other shells.

It's a builtin in zsh and in ksh, and /not/ in tcsh here (Fedora rawhide)

zsh-4.2.6-3.fc7
ksh-20060214-1.1
tcsh-6.14-13

It might be special configuration, but as they are mentioned in the manpages
I'd guess not.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
