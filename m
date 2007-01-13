From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 18:41:32 -0300
Message-ID: <200701132141.l0DLfWkG010141@laptop13.inf.utfsm.cl>
References: <alan@chandlerfamily.org.uk>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 22:42:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5qdR-0000PV-0w
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 22:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbXAMVlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 16:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422802AbXAMVlo
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 16:41:44 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39340 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422801AbXAMVlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 16:41:44 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0DLfcAV022577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 13 Jan 2007 18:41:41 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0DLfWkG010141;
	Sat, 13 Jan 2007 18:41:35 -0300
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: Message from Alan Chandler <alan@chandlerfamily.org.uk> 
   of "Sat, 13 Jan 2007 18:15:27 -0000." <200701131815.27481.alan@chandlerfamily.org.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:20:09 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 13 Jan 2007 18:41:42 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2438/Sat Jan 13 08:34:05 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36773>

Alan Chandler <alan@chandlerfamily.org.uk> wrote:

[...]

> My (albeit limited) experience with using git is at home coding a java 
> application for my web site using eclipse.  During the application 
> development when I am initially coding the application, or when I am 
> doing a major update that adds new pages to my site then I have to 
> remember to git add files.  My immediate instinct is do do commands of 
> the form
> 
> git add 
> Javasource/uk/org/chandlerfamily/appname/tapestry/pages/subdir/xxx.java
> 
> and
> git add Webcontent/subdir/xxx.html
> 
> which even with bash completion is a pain to enter.
> 
> (although that is probably harder than it needs to be - can't I just do 
> git add . ?)

That's different...

> I don't know whether we have had the debate here - if we have done it 
> would have been in the very very early days, but subject to 
> the .gitignore rules what would be the implications of a git commit -a 
> that automatically adds any files within the directory (and 
> subdirectories) in which it is issued.

Please don't. It would add e.g. the .class and .o and all ~ files, and all
other junk you have lying around (test cases, test run output, ...). It
isn't /that/ much more work after creating a new file to record its
existence...

> I am (at the moment - but I am good at changing my mind) in the side of 
> giit add for both adding new paths and updating content.  This is 
> purely  pragmatic - don't have to remember which one I am trying to do.

Me too. It's just a bit weird to use it to register the fact that a file is
gone.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
