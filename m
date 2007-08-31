From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git svn dcommit not checking if up-to-date?
Date: Sat, 1 Sep 2007 00:17:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709010017250.28586@racer.site>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site>
 <20070831221814.GB31033@untitled>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 01:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRFkm-00014K-MG
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 01:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbXHaXSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 19:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbXHaXSM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 19:18:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:54923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751288AbXHaXSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 19:18:12 -0400
Received: (qmail invoked by alias); 31 Aug 2007 23:18:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 01 Sep 2007 01:18:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XfNpSuTLXyD7ab5nyV99dVU8vbGRUmWkhn2MvI9
	Nnlms4p9EGgeUo
X-X-Sender: gene099@racer.site
In-Reply-To: <20070831221814.GB31033@untitled>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57230>

Hi,

On Fri, 31 Aug 2007, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > harningt just asked about known issues of git-svn on IRC, and I 
> > remembered that I had an issue: Accidentally, I forgot to "git svn 
> > fetch" before "git svn dcommit"ing, and unfortunately, a colleague had 
> > just checked in a change, which got undone by my dcommit.
> 
> I believe this was fixed a while back in commit
> 45bf473a7bc2c40c8aea3d34a0eab7a41e77a8ff
> (Thu Nov 9 01:19:37 2006 -0800).

That is strange, since I had this issue in July or August (this year).  
And I am quite certain that I ran with pretty up-to-date git (I usually 
track "next" quite closely).

Ciao,
Dscho
