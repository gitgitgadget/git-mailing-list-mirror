From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Sanity check of git-commit patch, was Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Tue, 09 Aug 2005 22:20:23 -0400
Message-ID: <200508100220.j7A2KNWb005040@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 14:48:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2pzk-00055H-Bo
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 14:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVHJMrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 08:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVHJMrO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 08:47:14 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48851 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965086AbVHJMrN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 08:47:13 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j7ACjXSG008347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Aug 2005 08:45:38 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j7A2KNWb005040;
	Tue, 9 Aug 2005 22:20:23 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Tue, 09 Aug 2005 10:00:39 MST." <7vd5onvydk.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 10 Aug 2005 08:45:38 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> True.  My bad old habit.
> >
> > An elegant method to do that:
> >
> > case --some-long-option in "$1"*) ..; esac
> 
> You are almost correct, but you need to realize that I generate
> that long "case -s|--s|--so|--som|..." chain using a script that
> takes all potential option names as its arguments, and makes
> case arms that contain only unambiguous ones, so that I can
> handle --some-long-option and --some-other-long-option sensibly.

My head spins....

Isn't it easier to just use getopt(1)?

> Also you forgot to grok --some-option-with-args=* in your
> version ;-).

Please stop! I'm dizzy already!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
