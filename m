From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fsck: report missing author/commit line in a commit
 as an error
Date: Sun, 20 Jan 2008 19:20:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801201918260.5731@racer.site>
References: <12008555922208-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGfjh-0001Ju-03
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 20:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbYATTVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 14:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbYATTVK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 14:21:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:57548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754936AbYATTVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 14:21:09 -0500
Received: (qmail invoked by alias); 20 Jan 2008 19:21:07 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp043) with SMTP; 20 Jan 2008 20:21:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YJ51Gnl9Y3wsnD9EqbPt1FPSr0NZPtwWgg8l0rc
	7qGf2CjErDdl3j
X-X-Sender: gene099@racer.site
In-Reply-To: <12008555922208-git-send-email-mkoegler@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71185>

Hi,

On Sun, 20 Jan 2008, Martin Koegler wrote:

> +	if (!commit->date)
> +		return objerror(&commit->object, "invalid author/commiter line in %s",

s/commiter/committer/

It makes me wonder, though, if that's correct.  AFAICT it is the committer 
date, and the rest of the line _might_ be just fine.

Why not be less intrusive and just change the printf() into a return 
objerror(), like the commit message suggests?

Ciao,
Dscho
