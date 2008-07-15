From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional
 caching
Date: Tue, 15 Jul 2008 03:28:07 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807150326050.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <4876B223.4070707@gmail.com> <200807150114.44402.jnareb@gmail.com> <487BE7C4.2050207@gmail.com> <200807150252.52604.jnareb@gmail.com> <487BFA67.3020304@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 03:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIZLq-0002v9-F6
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 03:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178AbYGOB2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 21:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbYGOB2L
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 21:28:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:41067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757116AbYGOB2K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 21:28:10 -0400
Received: (qmail invoked by alias); 15 Jul 2008 01:28:08 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp019) with SMTP; 15 Jul 2008 03:28:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fQdENJ4UfkejC8djRQn4+4JvqSual/enVf+Y6Je
	9mCsYf0QrAXCPz
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <487BFA67.3020304@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88493>

Hi,

On Tue, 15 Jul 2008, Lea Wiemann wrote:

> Jakub Narebski wrote:
> > On Tue, 15 July 2008, Lea Wiemann wrote:
> >> # Transient cache entries (like get_sha1('HEAD')) are automatically
> >> # invalidated when an mtime [...] changes.
> > 
> > Nice idea... for project pages.  I'm not so sure about projects_list 
> > page, if wouldn't be better to have expire time for *this* page.  You 
> > would have/have to stat a lot of files/directories to detect changes.
> 
> It doesn't seem to be too much of a performance issue (it takes ~500ms
> to generate the project list on kernel.org), and project lists aren't
> requested often enough to be a good optimization target.

Wasn't the main page (i.e. the projects list) the reason why kernel.org 
has its own little caching mechanism in the first place?

And did Pasky not report recently that repo.or.cz got substantially less 
loaded with some caching of its own?

warthog?  Pasky?

Ciao,
Dscho
