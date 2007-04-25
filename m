From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Convert t6022 to use git-merge instead of git-pull
Date: Thu, 26 Apr 2007 00:12:04 +0200
Message-ID: <20070425221204.GG30061@steel.home>
References: <20070425200718.GB30061@steel.home> <7vzm4wupew.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgpig-0006cV-RF
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 00:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbXDYWMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 18:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbXDYWMI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 18:12:08 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:57653 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbXDYWMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 18:12:07 -0400
Received: from tigra.home (Fac4b.f.strato-dslnet.de [195.4.172.75])
	by post.webmailer.de (mrclete mo31) (RZmta 5.6)
	with ESMTP id A0357bj3PHPN4e ; Thu, 26 Apr 2007 00:12:04 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id AF614277BD;
	Thu, 26 Apr 2007 00:12:04 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 24B23BDDE; Thu, 26 Apr 2007 00:12:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzm4wupew.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFqtlg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45585>

Junio C Hamano, Wed, Apr 25, 2007 23:15:03 +0200:
> Is this really necessary?
> 
> I would rather want to leave some tests use "git merge" while
> some others use "git pull ." to catch breakage of either form.
> 

No, of course not. I think the last patch should apply anyway.
I didn't realize these were the last uses of the old git-pull
syntax
