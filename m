From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Simplify calling of CR/LF conversion routines
Date: Thu, 19 Apr 2007 01:03:34 +0200
Message-ID: <20070418230334.GD2477@steel.home>
References: <20070418222827.GB2477@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 01:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeJBb-00019P-Kx
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 01:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078AbXDRXDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933083AbXDRXDg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 19:03:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:18829 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933078AbXDRXDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 19:03:36 -0400
Received: from tigra.home (Fca1e.f.strato-dslnet.de [195.4.202.30])
	by post.webmailer.de (mrclete mo15) (RZmta 5.5)
	with ESMTP id C000b1j3IMOrd9 ; Thu, 19 Apr 2007 01:03:34 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2FDB6277BD;
	Thu, 19 Apr 2007 01:03:34 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0EADABDDE; Thu, 19 Apr 2007 01:03:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070418222827.GB2477@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl6Sg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44961>

Alex Riesen, Thu, Apr 19, 2007 00:28:27 +0200:
> What is the point of having a return value if it is discarded
> afterwords anyway?
> 

Ignore this. I'll rediff against the "next" branch
