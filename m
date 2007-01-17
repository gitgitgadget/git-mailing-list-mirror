From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Wed, 17 Jan 2007 13:29:12 -0300
Message-ID: <200701171629.l0HGTCE3019292@laptop13.inf.utfsm.cl>
References: <17437.1168911089@lotus.CS.Berkeley.EDU> <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 17:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7DfD-0002Ev-8G
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 17:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbXAQQ3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbXAQQ3Y
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 11:29:24 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49575 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572AbXAQQ3X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 11:29:23 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0HGTDwC010350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jan 2007 13:29:13 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0HGTCE3019292;
	Wed, 17 Jan 2007 13:29:12 -0300
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
Comments: In-reply-to Junio C Hamano <junkio@cox.net>
   message dated "Mon, 15 Jan 2007 18:46:46 -0800."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 17 Jan 2007 13:29:13 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2459/Tue Jan 16 19:03:34 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37012>

Junio C Hamano <junkio@cox.net> wrote:
> Jason Riedy <ejr@EECS.Berkeley.EDU> writes:
> > Not all echos know -n.  This was causing a test failure in
> > t5401-update-hooks.sh, but not t3800-mktag.sh for some reason.
> 
> We have done this already so it might be too late to raise this
> question, but does everybody have printf?

Here (Fedora rawhide) /usr/bin/printf is part of coreutils.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
