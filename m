From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: rfe: bisecting with a tristate
Date: Tue, 24 Jul 2007 19:07:56 +0200
Message-ID: <200707241907.57857.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0707241459460.18990@fbirervta.pbzchgretzou.qr> <20070724094017.d14688e5.seanlkml@sympatico.ca> <Pine.LNX.4.64.0707241447200.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>,
	Jan Engelhardt <jengelh@computergmbh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 19:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDNqU-0006Ur-SV
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 19:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbXGXRGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 13:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbXGXRGr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 13:06:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12167 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbXGXRGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 13:06:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 312538026F9;
	Tue, 24 Jul 2007 18:59:30 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29281-08; Tue, 24 Jul 2007 18:59:29 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C1C5280019B;
	Tue, 24 Jul 2007 18:59:29 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0707241447200.14781@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53614>

tisdag 24 juli 2007 skrev Johannes Schindelin:
> Hi,
> 
> On Tue, 24 Jul 2007, Sean wrote:
> 
> > > git bisect start
> > > git bisect bad v2.6.23-rc1
> > > # bad: [f695baf2df9e0413d3521661070103711545207a] Linux 2.6.23-rc1
> > > git bisect good v2.6.22
> > > # good: [098fd16f00005f665d3baa7e682d8cb3d7c0fe6f] Linux 2.6.22
> > > 
> > > Then 1f1c2881f673671539b25686df463518d69c4649 will be the next commit 
> > > git bisect hands out. Now let's assume this commit would not compile. 
> > > What would the user do? git-bisect good or git-bisect bad?
> > 
> > Check out the section "Avoiding to test a commit" in the git-bisect
> > man page; it addresses this issue.  Basically you just use git-reset
> > to pick a different nearby commit to compile, and then continue with
> > git bisect good/bad.
> 
> But a "git bisect dunno" would be handy.

Why? Not doing anything is enough, just select a new commit. Going back can be done by
git reset, but forward (towards original HEAD) requires more thinking so a git bisect forward [n]
would help there.

-- robin
