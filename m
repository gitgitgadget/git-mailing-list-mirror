From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 19:31:54 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231930280.4353@racer.site>
References: <47E69044.3000207@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 19:32:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdUzx-0000QP-HK
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 19:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbYCWSb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 14:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYCWSb4
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 14:31:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:51229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750951AbYCWSbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 14:31:55 -0400
Received: (qmail invoked by alias); 23 Mar 2008 18:31:53 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp011) with SMTP; 23 Mar 2008 19:31:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UJsMujB9Ugq3Sp0fEK07H6w1DanD6vOUV+F56UX
	dTgPU6//IyNmAw
X-X-Sender: gene099@racer.site
In-Reply-To: <47E69044.3000207@zytor.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77937>

Hi,

On Sun, 23 Mar 2008, H. Peter Anvin wrote:

> 1. The ability to clone into the current directory
> 
>    cg-clone had a -c option, which allowed cloning into the current
>    directory.  This is particularly useful, since I keep my common
>    dot files in a git repository, so all I need to do to set up a new
>    machine is to clone that git repository over my empty home directory.
> 
>    Native git doesn't have any equivalent, other than:
> 
>    git clone -n .... tmp
>    mv tmp/.git .
>    rm -rf tmp
>    git checkout HEAD

Well, it has:

	$ git init
	$ git remote add -f origin <url>
	$ git checkout -b master origin/master

If you really want to track /etc with Git, you can do that easily, and you 
can easily take the flak for a not-so-popular workflow.

Ciao,
Dscho
