From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: determine if one commit is an ancestor of another
Date: Thu, 9 Jul 2009 19:16:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907091916090.4339@intel-tinevez-2-302>
References: <20090709171351.GA30088@cthulhu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:17:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOxEr-0003bB-6R
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 19:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbZGIRQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 13:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbZGIRQq
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 13:16:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:37250 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752671AbZGIRQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 13:16:45 -0400
Received: (qmail invoked by alias); 09 Jul 2009 17:16:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp045) with SMTP; 09 Jul 2009 19:16:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i+MB5oZniBFr7yN+X2T9CtL4bOZi3o/oex5/BM8
	IqxAeHXjlcTQ+/
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090709171351.GA30088@cthulhu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122995>

Hi,

On Thu, 9 Jul 2009, Larry D'Anna wrote:

> Is there any builtin to do this?  I'm doing it in a perl script now by 
> parsing git log --pretty=raw, but it's pretty slow for a big repository.

test $ancestor = $(git merge-base $ancestor $descendant)

Ciao,
Dscho
