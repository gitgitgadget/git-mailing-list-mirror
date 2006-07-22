From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git BOF notes
Date: Sat, 22 Jul 2006 02:17:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607220212140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060719230155.GJ13776@pasky.or.cz> <20060721131824.GC32585@fieldses.org>
 <20060721144249.GO13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 22 02:17:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G45Br-0006qK-Ta
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 02:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWGVARx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 20:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWGVARw
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 20:17:52 -0400
Received: from mail.gmx.de ([213.165.64.21]:45255 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751018AbWGVARw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 20:17:52 -0400
Received: (qmail invoked by alias); 22 Jul 2006 00:17:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp025) with SMTP; 22 Jul 2006 02:17:48 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060721144249.GO13776@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24062>

Hi,

On Fri, 21 Jul 2006, Petr Baudis wrote:

> Yes, there is some blury stuff, but I think it's rather a sign that
> something is missing in the core Git porcelain. git-init-db is lowlevel
> and I think in 99% of the cases you are going to do an initial commit
> right after anyway, so you might as well just get git-init which does it
> for you (something akin cg-init ;).

Think "changed templates". And also think "setup a remote repository", 
especially "setup a remote HTTP repository". No, clone will not work if 
you are sitting behind a firewall and/or DSL router (and who does not?).

And also think "start a new repository with only a _part_ of the current 
files". There are plenty reasons -- in addition to separation of concepts 
-- not to commit straight after initializing a repository.

> I think we still tell users to use git-update-index to mark resolved 
> conflicts, [...]

I don't know, but I had the impression we'd tell them "resolve your 
conflicts, and then do git-commit -a". Which is good enough.

Ciao,
Dscho
