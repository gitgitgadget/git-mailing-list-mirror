From: Mike Galbraith <efault@gmx.de>
Subject: Re: pulling Already up-to-date linux-2.6 repo takes ~8 minutes?
Date: Thu, 18 Oct 2007 07:54:42 +0200
Message-ID: <1192686882.9097.2.camel@Homer.simpson.net>
References: <1192678865.20353.14.camel@Homer.simpson.net>
	 <20071018045001.GA14735@spearce.org>
	 <1192684150.7390.15.camel@Homer.simpson.net>
	 <1192685971.7390.21.camel@Homer.simpson.net>
	 <20071018054834.GH14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOLS-0007qS-Ft
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbXJRFyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXJRFyr
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:54:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:50560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751833AbXJRFyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:54:46 -0400
Received: (qmail invoked by alias); 18 Oct 2007 05:54:44 -0000
Received: from p54B5BA2B.dip0.t-ipconnect.de (EHLO [192.168.178.23]) [84.181.186.43]
  by mail.gmx.net (mp003) with SMTP; 18 Oct 2007 07:54:44 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1/ZGPIUU+rZeBJ8G7W8ga6eXEU6I+KcMq//DkLqPw
	bR0esQ5bNufbZK
In-Reply-To: <20071018054834.GH14735@spearce.org>
X-Mailer: Evolution 2.8.2 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61485>

On Thu, 2007-10-18 at 01:48 -0400, Shawn O. Pearce wrote:

> Look to see if there's anything on your current master branch that
> you don't want/need anymore:
> 
> 	$ git log ..master

git trees here are meant to be absolutely virgin, so...

> If that comes up empty (no output) or you mean to discard those
> changes then you can just force create the branch and check it out:
> 
> 	$ git branch -f master
> 	$ git checkout master

Thanks again, I'm off my dangling limb.

	-Mike
