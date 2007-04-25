From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add date format --local-zone
Date: Wed, 25 Apr 2007 22:12:12 +0200
Message-ID: <20070425201212.GD30061@steel.home>
References: <1177482982542-git-send-email-junkio@cox.net> <alpine.LFD.0.98.0704250800030.9964@woody.linux-foundation.org> <alpine.LFD.0.98.0704250805440.9964@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgnqd-0003nx-9E
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993055AbXDYUMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992949AbXDYUMP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:12:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:16760 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993055AbXDYUMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:12:14 -0400
Received: from tigra.home (Fac4b.f.strato-dslnet.de [195.4.172.75])
	by post.webmailer.de (fruni mo31) (RZmta 5.6)
	with ESMTP id A015cej3PEAIPj ; Wed, 25 Apr 2007 22:12:12 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 42E48277BD;
	Wed, 25 Apr 2007 22:12:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1EEFDBDDE; Wed, 25 Apr 2007 22:12:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704250805440.9964@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFqtlg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45561>

Linus Torvalds, Wed, Apr 25, 2007 17:22:20 +0200:
> 
> Btw, when you do "--local-zone", you should drop the TZ printout too, I 
> think. It doesn't seem to make any sense to give the *wrong* timezone.
> 

The timezone is interesting to see: it is a hint as to _where_ the
commit is coming from. Obviously not reliable, it can be amusing.
