From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Wed, 23 Nov 2005 09:14:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511230913360.13959@g5.osdl.org>
References: <20051117230723.GD26122@nowhere.earth>
 <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth>
 <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de>
 <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051120073244.GA7902@kiste.smurf.noris.de> <17283.57854.256145.253465@cargo.ozlabs.ibm.com>
 <20051123072738.GI20960@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 18:16:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeyCz-0005CX-6u
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 18:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVKWROe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 12:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVKWROe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 12:14:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751140AbVKWROd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 12:14:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jANHE5nO029813
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Nov 2005 09:14:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jANHE451012565;
	Wed, 23 Nov 2005 09:14:04 -0800
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051123072738.GI20960@kiste.smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12637>



On Wed, 23 Nov 2005, Matthias Urlichs wrote:

> Hi,
> 
> Paul Mackerras:
> > However, I was unable to get current gitk to exhibit the problem, even
> > with Thomas Gleixner's enormous history.git repository.  Do you have a
> > specific example (repository and commit ID) where you see the problem
> > occur?
> > 
> I've seen it in the past ... hmmm ... testing ... and it seems to
> majickally have fixed itself.

I saw it all the time before adding the "arrows" logic. 

With the arrows, the graph never gets so complex that you'd see it.

		Linus
