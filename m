From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix Solaris compiler warnings
Date: Fri, 16 Nov 2007 00:00:02 +0100
Message-ID: <20071115230002.GA24069@steel.home>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Nov 16 00:00:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsnhC-0007Ap-P1
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 00:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbXKOXAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 18:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXKOXAJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 18:00:09 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:23593 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbXKOXAI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 18:00:08 -0500
Received: from tigra.home (Fcbc7.f.strato-dslnet.de [195.4.203.199])
	by post.webmailer.de (klopstock mo37) (RZmta 14.0)
	with ESMTP id 404744jAFHPeIW ; Fri, 16 Nov 2007 00:00:04 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1C879277AE;
	Fri, 16 Nov 2007 00:00:03 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B216156D22; Fri, 16 Nov 2007 00:00:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsKmZA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65179>

Guido Ostkamp, Thu, Nov 15, 2007 23:19:11 +0100:
> Hello,
>
> the below patch fixes some compiler warnings returned by Solaris Workshop 
> Compilers.
>
>     CC builtin-apply.o
> "builtin-apply.c", line 686: warning: statement not reached
>     CC utf8.o
> "utf8.c", line 287: warning: statement not reached
>     CC xdiff/xdiffi.o
> "xdiff/xdiffi.c", line 261: warning: statement not reached

All these are wrong. That's a fantastically broken piece of compiler

>     CC xdiff/xutils.o
> "xdiff/xutils.c", line 236: warning: statement not reached

This one is right. Accidentally, as it seems
