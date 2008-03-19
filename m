From: Nicolas Pitre <nico@cam.org>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 16:37:29 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803191629240.2947@xanadu.home>
References: <20080318180118.GC17940@kernel.dk>
 <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org>
 <20080318181948.GH17940@kernel.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:49:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5Ds-000683-VZ
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934312AbYCSUhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761016AbYCSUhe
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:37:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25582 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934311AbYCSUhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:37:31 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXZ007ZCVYHF771@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Mar 2008 16:37:29 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080318181948.GH17940@kernel.dk>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77542>

On Tue, 18 Mar 2008, Jens Axboe wrote:

> But freshly pulled repo, git auto gc is enabled. And that is my main
> annoyance, I just don't think that type of policy should be in there.

Just do this once:

	git config --global gc.auto 0
	git config --global gc.autopacklimit 0

and be happy.

> Print the warning, include info on how to run git gc or even how to turn
> it on automatically. But I'll bet you that most users will NOT want auto
> gc. Ever.

Unfortunately, the harshest complaints about this whole issue were the 
opposite.


Nicolas
