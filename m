From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Wed, 04 May 2005 10:54:47 -0400
Message-ID: <200505041454.j44Eslpg004032@laptop11.inf.utfsm.cl>
References: <hpa@zytor.com>
Cc: Petr Baudis <pasky@ucw.cz>, Chris Wright <chrisw@osdl.org>,
	Mark Allen <mrallen1@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 16:50:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTLBB-0004Vf-LS
	for gcvg-git@gmane.org; Wed, 04 May 2005 16:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEDOzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 10:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVEDOzH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 10:55:07 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:54713 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261863AbVEDOzA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 10:55:00 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j44EqgOB012436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 May 2005 10:52:42 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j44EsmOR004035;
	Wed, 4 May 2005 10:54:48 -0400
Received: from laptop11.inf.utfsm.cl (vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.4/8.13.4/Submit) with ESMTP id j44Eslpg004032;
	Wed, 4 May 2005 10:54:47 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: Message from "H. Peter Anvin" <hpa@zytor.com> 
   of "Wed, 04 May 2005 07:38:53 MST." <4278DE7D.3000005@zytor.com> 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 04 May 2005 10:52:42 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> said:
> Petr Baudis wrote:
> > I wouldn't accept this neither. If git.spec is already version
> > controlled, it should be up-to-date in the version control. Therefore,
> > you need to update it at the time of release, not at the time of
> > generating the tarball.

> What I usually do is to have a *.spec.in file, and have my release 
> script generate the *.spec file.  I usually have a "version" file 
> checked into the SCM from which all version information derives, 
> including what to put in the *.spec file as well as what to name the 
> subdirectory.

Right. Note that this is /not/ autoconfiguring .spec from .spec.in, you are
"just" automating the process I do by hand.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
