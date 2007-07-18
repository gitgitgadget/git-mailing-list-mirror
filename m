From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Rsync fetch?
Date: Wed, 18 Jul 2007 22:53:58 +0200
Message-ID: <20070718205358.GB29505@steel.home>
References: <Pine.LNX.4.64.0707181226020.14596@iabervon.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 22:54:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBGXd-0001zV-4R
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 22:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587AbXGRUyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 16:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbXGRUyE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 16:54:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:42668 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbXGRUyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 16:54:01 -0400
Received: from tigra.home (Fc837.f.strato-dslnet.de [195.4.200.55])
	by post.webmailer.de (mrclete mo6) (RZmta 9.1)
	with ESMTP id z00d74j6IIwqaj ; Wed, 18 Jul 2007 22:53:59 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8DDC0277BD;
	Wed, 18 Jul 2007 22:53:59 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 00D10C164; Wed, 18 Jul 2007 22:53:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707181226020.14596@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWotvlQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52897>

Daniel Barkalow, Wed, Jul 18, 2007 18:37:21 +0200:
> The only thing that's totally missing at this point from my builtin-fetch 
> is rsync. Do we still care? Any takers for actually implementing it?

Maybe pull the rsync parts from the old fetch, put them into a script
and call it? Not very simple, as it looks. Maybe not worth the effort.
