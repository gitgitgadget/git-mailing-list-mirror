From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: fix legacy cvs client and branch rev issues
Date: Sun, 17 Jun 2007 19:20:41 +0200
Message-ID: <20070617172041.GF1828@planck.djpig.de>
References: <11820198064114-git-send-email-djk@tobit.co.uk> <20070617081959.GD1828@planck.djpig.de> <4674FA9B.10806@tobit.co.uk> <20070617103744.GE1828@planck.djpig.de> <46756707.5020805@tobit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dirk Koopman <djk@tobit.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 17 19:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzyQj-0008Lp-Kr
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 19:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbXFQRUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 13:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbXFQRUs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 13:20:48 -0400
Received: from planck.djpig.de ([85.10.192.180]:3423 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005AbXFQRUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 13:20:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 1BF9788102;
	Sun, 17 Jun 2007 19:20:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rvF70tgSPNTz; Sun, 17 Jun 2007 19:20:41 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id CBBF688105; Sun, 17 Jun 2007 19:20:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46756707.5020805@tobit.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50360>

On Sun, Jun 17, 2007 at 05:53:27PM +0100, Dirk Koopman wrote:
> Frank Lichtenheld wrote:
> >Summary: You're (ab)using cvsserver in very interesting ways that are not
> >really beeing thought of in the current design/implementation. There'll
> >be dragons ;)
> >
> 
> Hmm... I think that is becoming clear. The trouble is that I am not at 
> all certain that what I am doing is particularly unusual. After all, 
> using git, the whole point is that working on branches or the main line 
> should easy and cheap!

Sure, it is a know limitation of cvsserver. But it is not trivially
to remove. Patches welcome ;)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
