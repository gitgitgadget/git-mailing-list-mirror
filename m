From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Notes on Subproject Support
Date: Sat, 28 Jan 2006 01:55:59 -0300
Message-ID: <200601280455.k0S4tx6N003251@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:05:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2tWN-0002Xj-VR
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 18:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWA1RFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 12:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWA1RFx
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 12:05:53 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51398 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751482AbWA1RFw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jan 2006 12:05:52 -0500
Received: from laptop11.inf.utfsm.cl (hefestos.usm.edu.ec [200.93.198.105])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k0SGxZ01003144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jan 2006 14:05:06 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.5) with ESMTP id k0S4tx6N003251;
	Sat, 28 Jan 2006 01:55:59 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Sun, 22 Jan 2006 17:35:14 -0800." <7v3bjfafql.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 28 Jan 2006 14:05:15 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15198>

Junio C Hamano <junkio@cox.net> wrote:
> This is still a draft/WIP, but "release early" is a good
> discipline, so...

One thing that has bugged me from the beginning of this, and which does
come out of your example: Why only project/subproject? In your example, you
have the kernel (OK(ish)) and "rest of the world", which could itself break
up and be tracking e.g. uClibc, and dhcp, and... And perhaps the kernel
itself breaks up into (local and vanilla) components.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
