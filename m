From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: That new progress meter
Date: Sat, 3 Nov 2007 17:09:50 +0100
Message-ID: <20071103160950.GB3175@steel.home>
References: <Pine.LNX.4.64.0711021836000.4362@racer.site> <20071103120953.GC13417@artemis.corp> <alpine.LFD.0.9999.0711031042390.21255@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 17:10:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoLZa-0001xU-8i
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 17:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbXKCQJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 12:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754595AbXKCQJy
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 12:09:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:29908 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbXKCQJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 12:09:53 -0400
Received: from tigra.home (Fc897.f.strato-dslnet.de [195.4.200.151])
	by post.webmailer.de (mrclete mo33) (RZmta 14.0)
	with ESMTP id c01b90jA3EM3kz ; Sat, 3 Nov 2007 17:09:51 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C408E277AE;
	Sat,  3 Nov 2007 17:09:50 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 42A5956D22; Sat,  3 Nov 2007 17:09:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711031042390.21255@xanadu.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a6ls=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63288>

Nicolas Pitre, Sat, Nov 03, 2007 15:53:25 +0100:
> The other solution is to make the remote object summary line a bit 
> longer, but this will be effective only when remote servers are 
> upgraded.  Might that be good enough?

How about keeping track of the length of the last lines the remote end
sent (recv_sideband in sideband.c)? So that we always know how much
spaces to add to clear up to the end of line.
