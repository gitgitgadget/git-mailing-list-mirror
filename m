From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 19:04:45 -0300
Message-ID: <200701132204.l0DM4jpE010938@laptop13.inf.utfsm.cl>
References: <spearce@spearce.org>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 23:05:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5r07-0005eg-MQ
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 23:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbXAMWFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 17:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbXAMWFJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 17:05:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39907 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbXAMWFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 17:05:08 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0DM4rHE023869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 13 Jan 2007 19:04:58 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0DM4jpE010938;
	Sat, 13 Jan 2007 19:04:46 -0300
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: Message from "Shawn O. Pearce" <spearce@spearce.org> 
   of "Sat, 13 Jan 2007 16:47:42 CDT." <20070113214742.GA17887@spearce.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:04:53 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 13 Jan 2007 19:04:59 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2438/Sat Jan 13 08:34:05 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36776>

Shawn O. Pearce <spearce@spearce.org> wrote:
> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> > Please don't. It would add e.g. the .class and .o and all ~ files, and all
> > other junk you have lying around (test cases, test run output, ...). It
> > isn't /that/ much more work after creating a new file to record its
> > existence...
> 
>   echo \*.class >>.gitignore
>   echo \*.o >>.gitignore
>   git add .gitignore
> 
> doesn't work for some reason?

Because each time I build a bit of scaffolding, or have a new test output,
or... I'd have to add them to .gitignore. I'd very much prefer tracking
real contents and not junk.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
