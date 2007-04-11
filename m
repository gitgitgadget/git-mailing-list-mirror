From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: cvsserver bug
Date: Wed, 11 Apr 2007 21:43:27 +0200
Message-ID: <20070411194327.GA7085@planck.djpig.de>
References: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martyn Smith <martyn@catalyst.net.nz>,
	Martin Langhoff <martin@catalyst.net.nz>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 21:43:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbijN-0007vc-Ps
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 21:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbXDKTnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbXDKTnb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 15:43:31 -0400
Received: from planck.djpig.de ([85.10.192.180]:2173 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030190AbXDKTna (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 15:43:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 19D1588003;
	Wed, 11 Apr 2007 21:43:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zcXxGuSvcWTK; Wed, 11 Apr 2007 21:43:27 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id AD04F8801B; Wed, 11 Apr 2007 21:43:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44251>

On Wed, Apr 11, 2007 at 12:10:24PM -0400, Daniel Barkalow wrote:
> It seems like git-cvsserver doesn't know the CVS special case that, if the 
> client has removed the file from the working directory (but not called 
> "cvs remove"), this means to revert it to the server's version. I think 
> that the condition around line 843 needs to exclude this case, and it 
> needs to get to line 892 instead, but I can't even fake perl to fix it.

I can confirm the bug. Will look into it a bit and see whether I can
come up with a fix.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
