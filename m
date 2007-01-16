From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Mon, 15 Jan 2007 21:34:12 -0300
Message-ID: <200701160034.l0G0YC5J005016@laptop13.inf.utfsm.cl>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx> <E5A7E6A8-45FF-4A7A-A31E-DFEBAD48DF1C@silverinsanity.com> <200701131815.27481.alan@chandlerfamily.org.uk> <8E585186-FC3F-473B-BA1F-91CFEF1A63F4@silverinsanity.com> <20070113203456.GA17648@spearce.org> <Pine.LNX.4.63.0701141340020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070114224204.GA10888@spearce.org> <7v4pqtf699.fsf@assigned-by-dhcp.cox.net> <20070115011217.GA11240@spearce.org> <Pine.LNX.4.64.0701151727310.20138@iabervon.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 01:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6cI8-00021S-Rf
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 01:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbXAPAex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 19:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbXAPAex
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 19:34:53 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52375 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbXAPAex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 19:34:53 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0G0YJ7a015969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jan 2007 21:34:19 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0G0YC5J005016;
	Mon, 15 Jan 2007 21:34:12 -0300
To: Daniel Barkalow <barkalow@iabervon.org>
In-reply-to: <Pine.LNX.4.64.0701151727310.20138@iabervon.org>
Comments: In-reply-to Daniel Barkalow <barkalow@iabervon.org>
   message dated "Mon, 15 Jan 2007 17:46:05 -0500."
X-Mailer: MH-E 7.4.2; nmh 1.2; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:06:56 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 15 Jan 2007 21:34:20 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2454/Mon Jan 15 18:46:25 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36903>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> An config option to prohibit committing with untracked files should be 
> easy to add.

Right. And that will annoy the heck out of people who have random litter
left behind, so their fingers will go "git clean; git commit -a" and then
"OOoops!!!". If they can't read the commit message template in the first
place, or train their fingers to "git add" new files immediately...

>              If your workflow is such that incorrect commits are sometimes 
> generated given either policy, the system should ask you which you mean.

Leave it alone. At least it will work the same always. Consistency is good.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
