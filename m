From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: "git gc" removes ".git/refs/heads/master".
Date: Thu, 29 Jan 2009 20:55:26 +0100
Message-ID: <20090129195526.GA15475@m62s10.vlinux.de>
References: <83c97f59a5a5e59f908f3fc125d26adb@lunox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bernd Lommerzheim <bernd@lommerzheim.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 20:57:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSd0G-00049f-K5
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 20:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbZA2TzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 14:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756115AbZA2TzS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 14:55:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:45943 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756221AbZA2TzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 14:55:16 -0500
Received: (qmail invoked by alias); 29 Jan 2009 19:55:12 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp070) with SMTP; 29 Jan 2009 20:55:12 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18m8txQ/3Um0nVyPyrfWLJBpTqFStLXAZ4bB/UZFB
	vchXTlEosjqWFH
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 1F9FD181DB; Thu, 29 Jan 2009 20:55:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <83c97f59a5a5e59f908f3fc125d26adb@lunox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107724>

On Thu, Jan 29, 2009 at 08:31:17PM +0100, Bernd Lommerzheim wrote:
> Hi,
> 
> maybe I found a bug in git. When I execute "git gc" in my local repository,
> git removes the file ".git/refs/heads/master". Is this an intended behavior
> (but why?) or is that a bug?
> 

This is intential, as git gc creates .git/packed-refs in which the
contents of your master branch are stored. The packed-refs help speeding
up the listing of your branches if you have many of them (e.g. many old
historical ones).

Regards,
Peter Baumann
