From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 18 May 2007 23:53:12 +0200
Message-ID: <20070518215312.GB10475@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163061588-git-send-email-skimo@liacs.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri May 18 23:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAO2-0006MD-PO
	for gcvg-git@gmane.org; Fri, 18 May 2007 23:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbXERVxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 17:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbXERVxQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 17:53:16 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:11307 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbXERVxP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 17:53:15 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (klopstock mo55) (RZmta 6.5)
	with ESMTP id G04791j4IKQlAh ; Fri, 18 May 2007 23:53:13 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 98A88277BD;
	Fri, 18 May 2007 23:53:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 23539D195; Fri, 18 May 2007 23:53:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11795163061588-git-send-email-skimo@liacs.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47659>

skimo@liacs.nl, Fri, May 18, 2007 21:24:56 +0200:
> 
> This option currently has no effect.
> 

Can we have this option (and corresponding support in the following
patches, of course) first? It is enough to have subprojects working
locally, and people can start using them immediately: anyone can clone
the subprojects manually if he wishes so.

Cloning of subprojects is still unclear, and frankly I'm not sure it
should be done at all. Not even with an option which is off by
default.
