From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git push mirror mode
Date: Thu, 8 Nov 2007 12:49:16 +0000
Message-ID: <20071108124916.GI9736@shadowen.org>
References: <20071108121136.GG9736@shadowen.org> <Pine.LNX.4.64.0711081218090.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 13:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6p4-000082-Il
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbXKHMtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXKHMtJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:49:09 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2492 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbXKHMtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:49:08 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1Iq6ol-00035A-Fw; Thu, 08 Nov 2007 12:49:07 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711081218090.4362@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64011>

On Thu, Nov 08, 2007 at 12:19:18PM +0000, Johannes Schindelin wrote:

> P.S.: Without tests I am opposed to inclusion.  This _definitely_ needs 
> some tests.

This is very much 'pu' material right now.  I've used it for a day
keeping some kernel repos in sync on a couple of test boxes.  Hardly
extensive testing.

Yes some tests would be advisable.  However I am no expert in the git
test system, so I am not going to be able to do that in short order.
What little time I had to work on this this morning was wasted by some
SarBox madness here (but that is another story).  In the spirit of
making progress on what is a useful feature I pulled Junio's original
change forward, fixed up my patch to expose it the the user and gave it
some testing.

Whats there does seem to work and has a prima-facie use case.  Hopefully
someone can provide the nessary tests before I can.

-apw
