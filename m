From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Dissociating a repository from its alternates
Date: Thu, 15 Feb 2007 16:39:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151638130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 16:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHii5-00007C-D4
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 16:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965748AbXBOPjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 10:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965918AbXBOPjq
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 10:39:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:36842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965748AbXBOPjq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 10:39:46 -0500
Received: (qmail invoked by alias); 15 Feb 2007 15:39:44 -0000
X-Provags-ID: V01U2FsdGVkX18WD4cpn8UW95FHCbhKj8ddIbzisos5MUMbaMZN4q
	S+Xw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39834>

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> People often start out with "clone -l -s" (or --reference) and
> later wish to dissociate the repository from its alternates.

Why not make a really dumb script which just _copies_ (or maybe 
optionally hard link) the objects from the alternate repo, and then kills 
the alternatives file? That should be easier. You always can repack after 
that.

Ciao,
Dscho
