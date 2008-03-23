From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: List all SHA1 hashes in repo
Date: Sun, 23 Mar 2008 14:59:34 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231459100.4353@racer.site>
References: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:00:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQkR-00048S-RC
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYCWN7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbYCWN7v
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:59:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:32889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750917AbYCWN7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 09:59:50 -0400
Received: (qmail invoked by alias); 23 Mar 2008 13:59:48 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp028) with SMTP; 23 Mar 2008 14:59:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hoFYAQ10hsNPhnpNlsD7+Apeo2h7vDoh+Xvc/KP
	yHLrHfB6Xxi2xe
X-X-Sender: gene099@racer.site
In-Reply-To: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77898>

Hi,

On Sun, 23 Mar 2008, Alexander Gladysh wrote:

> To help testing little Git-related tool I'm writing, I need a lot of
> pregenerated SHA1 hashes. Git repo seems to be a perfect source of
> such. Is there an easy way to extract a list of all (well, most of)
> SHA1 hashes in the repo?
> 
> The git rev-list --all gives nice list, but, as I understand, that is
> only commit objects, and there are much more of SHA1 hidden inside.

Just add --objects.

Ciao,
Dscho
