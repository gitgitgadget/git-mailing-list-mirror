From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Git::Repo API and gitweb caching
Date: Fri, 11 Jul 2008 03:21:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807110317390.3279@eeepc-johanness>
References: <4876B223.4070707@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 03:22:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH7L3-0004t1-Gd
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 03:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759442AbYGKBVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 21:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759416AbYGKBVQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 21:21:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:58239 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759387AbYGKBVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 21:21:16 -0400
Received: (qmail invoked by alias); 11 Jul 2008 01:21:14 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp029) with SMTP; 11 Jul 2008 03:21:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lVHwJcdqltIBSbdGuLa7dQ4CxkGh7lmbYQJJiWT
	ZRJPQubYFLs289
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4876B223.4070707@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88072>

Hi,

On Fri, 11 Jul 2008, Lea Wiemann wrote:

> Patch (3) basically makes two large changes in one patch, but it was 
> pretty hard to separate them during development.  I could try to split 
> them up after the fact, but it would take at least an hour or two, since 
> the changes that introduce caching are spread all over the code.  I 
> don't think that having separate commits ([a] use Git::Repo API, [b] add 
> caching) brings enough benefit to justify the effort.
> 
> There are some other changes in (3) as well, but they fell out as part 
> of the refactoring, so I didn't separate them either -- same thing.

FWIW there are a few reasons why splitting up (3) might be the thing you 
really want to do, even if it takes an hour or two:

- it makes reviewing much easier,
- it makes subsequent revisions of the patches easier to review,
- it make it easier to cherry-pick changes, should not all be equally 
  liked,
- it makes finding bugs much easier (both spotting during review and 
  bisecting), and
- it is good for documentation purposes, should someone read the commit 
  log.

Now, after weighing the benefit (especially in terms of hours spared 
others) against the downsides, you might want to reconsider your stance.

Ciao,
Dscho
