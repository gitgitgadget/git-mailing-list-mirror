From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Intoducing the .git file (again)
Date: Sun, 17 Feb 2008 22:20:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802172219190.30505@racer.site>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:21:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQrtI-0005ee-Q0
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbYBQWVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYBQWVI
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:21:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:33439 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753867AbYBQWVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:21:07 -0500
Received: (qmail invoked by alias); 17 Feb 2008 22:21:04 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp046) with SMTP; 17 Feb 2008 23:21:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZbmwCb69ZjkR3pb2uiIV5yOZpuzibv9Fn9Ju7rP
	o4SwSEzZt4ENHI
X-X-Sender: gene099@racer.site
In-Reply-To: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74197>

Hi,

On Sun, 17 Feb 2008, Lars Hjemli wrote:

> PPS: If included, the .git file should probably be used by git-submodule 
> to clone submodule repositories into something like 
> $GIT_DIR/submodules/<name>, as that would make local submodule changes 
> more resistant to dataloss due to checkout/reset in the containing 
> repository.

I don't buy that argument.  For the moment, the submodules are 
self-contained repositories.  The superproject does not even have to have 
a single object contained in a submodule.  I'd try to keep that 
separation.

As for data loss, again, as a submodule is self-contained, the same rules 
apply to it as for any repository.

Ciao,
Dscho
