From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Avoid excessive rewrites in merge-recursive
Date: Thu, 26 Apr 2007 00:13:41 +0200
Message-ID: <20070425221341.GH30061@steel.home>
References: <20070425200659.GA30061@steel.home> <7vodlcup9e.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgpkB-0007FQ-7K
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 00:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161816AbXDYWNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 18:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161809AbXDYWNo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 18:13:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:31441 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161775AbXDYWNn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 18:13:43 -0400
Received: from tigra.home (Fac4b.f.strato-dslnet.de [195.4.172.75])
	by post.webmailer.de (fruni mo44) (RZmta 5.6)
	with ESMTP id E0160fj3PFWaRo ; Thu, 26 Apr 2007 00:13:41 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id AA014277BD;
	Thu, 26 Apr 2007 00:13:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A60F1BDDE; Thu, 26 Apr 2007 00:13:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vodlcup9e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFqtlg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45586>

Junio C Hamano, Wed, Apr 25, 2007 23:18:21 +0200:
> 
> > Just as you may have thought merge-recursive cannot get any uglier
> > someone comes and does just this: puts another level of indentation.
> 
> It really was painful for me the last time I touched the file,
> so I share that feeling.  The complexity of this program is
> getting out of hand.
> 
> Probably we would want a refactoring before doing something like
> this.
> 

I want. I just can't afford something like this lately.
I'm even saving on "am"s and "not"s! :)
