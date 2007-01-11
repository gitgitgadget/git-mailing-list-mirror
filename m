From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [BUG] OSX ends with "install: git-init.1: No such file or directory"
Date: Thu, 11 Jan 2007 14:28:32 -0300
Message-ID: <200701111728.l0BHSWu1031430@laptop13.inf.utfsm.cl>
References: <ae@op5.se>
Cc: Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 18:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H53k4-0008RE-D7
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 18:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbXAKR33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 12:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbXAKR33
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 12:29:29 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51236 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbXAKR32 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 12:29:28 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0BHSYtW023237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jan 2007 14:28:34 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0BHSWu1031430;
	Thu, 11 Jan 2007 14:28:32 -0300
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: Message from Andreas Ericsson <ae@op5.se> 
   of "Thu, 11 Jan 2007 10:57:31 BST." <45A60A0B.5000001@op5.se> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 11 Jan 2007 14:28:34 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2436/Thu Jan 11 08:48:19 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36598>

Andreas Ericsson <ae@op5.se> wrote:
> Junio C Hamano wrote:
> > merlyn@stonehenge.com (Randal L. Schwartz) writes:

[...]

> >> That's not good. Making git-init-db when it wants git-init.

> > Not good.  I am _very_ tempted to do this.
> > [Creates a stub manpage, saying git-init is a silly synonym for
> >  git-init-db]

> Perhaps, but "git init-db" does a lot more than just initialise the
> object database (such as setting default config-variables, installing
> template hooks...). "git init" is actually a more sensible name now
> adays.

Changing the name of a command is a delicate matter... sounds sensible, but
then make it git-init is new name in 1.5.0 (or right now) with a link to
the older one (and squeak about the name change when called as
git-init-db), and git-init-db is gone by 2.0.0
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
