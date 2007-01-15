From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: What's in git.git and announcing GIT v1.5.0-rc1
Date: Sun, 14 Jan 2007 23:21:47 -0300
Message-ID: <200701150221.l0F2LlwJ016982@laptop13.inf.utfsm.cl>
References: <lamikr@cc.jyu.fi>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2H-0000Md-0U
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:21 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8m-0003eK-9S
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXAOCV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 21:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbXAOCV5
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 21:21:57 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45436 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbXAOCVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 21:21:55 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0F2LnfW019277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 14 Jan 2007 23:21:50 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0F2LlwJ016982;
	Sun, 14 Jan 2007 23:21:48 -0300
To: lamikr@cc.jyu.fi
In-Reply-To: Message from lamikr <lamikr@cc.jyu.fi> 
   of "Mon, 15 Jan 2007 01:36:09 +0200." <45AABE69.1070505@cc.jyu.fi> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:10:29 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 14 Jan 2007 23:21:50 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2441/Sun Jan 14 14:18:02 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36873>

lamikr <lamikr@cc.jyu.fi> wrote:
> Junio C Hamano wrote:
> > The tip of 'master' branch is tagged as v1.5.0-rc1; this means a
> > few things:
> >   
> Hi
> 
> Would it make sense to add something like this to the announcements as
> it is not very easy to find references to the git-repository itself from
> the net.
> 
>    You can get the git repository-itself by using a following commands
> 
>            git-clone git://git.kernel.org/pub/scm/git/git.git git_repo
> 
>    After that you can switch to tagged version <v1.5.0-rc1> or sources
> from the repository by using command
> 
>           git-checkout -f v1.5.0-rc1 master
> 
>    Alternatively you can download the tar packed version of sources from
>       
>           http://www.kernel.org/pub/software/scm/git/

Be careful, this gives you a old-fashioned repository, the repositories
created by 1.5.0-rc are different, and 1.4.4.4 doesn't grok them:

   * refusing to create funny ref 'remotes/origin/*' locally
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
