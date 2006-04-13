From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 12:18:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604131216500.14565@g5.osdl.org>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ld2uyv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604131138080.14565@g5.osdl.org>
 <7vwtdt1f10.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 21:18:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU7Ki-00007F-4X
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 21:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWDMTST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWDMTST
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 15:18:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932456AbWDMTSS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 15:18:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3DJIBtH027672
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Apr 2006 12:18:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3DJIALE027841;
	Thu, 13 Apr 2006 12:18:11 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtdt1f10.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18668>



On Thu, 13 Apr 2006, Junio C Hamano wrote:
> 
> Yes that happens to be the case _now_.  I just did not want to
> worry about future breakage, in case if Davide ever wants to
> change how mb[] is prepared for whatever reason.

I'd be worried if we depended on an external version of xdiff, but as it 
is, we'd see all changes to our local xdiff implementation, so...

It's not like either of the statements
 - we always get whole lines
 - the first memory block is always non-empty
is really very controversial ;)

		Linus
