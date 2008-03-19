From: Nicolas Pitre <nico@cam.org>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 18:56:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803191855030.2947@xanadu.home>
References: <20080318180118.GC17940@kernel.dk>
 <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org>
 <20080318181948.GH17940@kernel.dk>
 <alpine.LFD.1.00.0803191629240.2947@xanadu.home>
 <47E18540.4020908@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jens Axboe <jens.axboe@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc7EA-0008FA-HB
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941761AbYCSW4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S941753AbYCSW4X
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:56:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31300 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S941747AbYCSW4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:56:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JY000H9D2DWD921@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Mar 2008 18:56:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <47E18540.4020908@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77583>

On Wed, 19 Mar 2008, Brandon Casey wrote:

> Nicolas Pitre wrote:
> > On Tue, 18 Mar 2008, Jens Axboe wrote:
> > 
> >> But freshly pulled repo, git auto gc is enabled. And that is my main
> >> annoyance, I just don't think that type of policy should be in there.
> > 
> > Just do this once:
> > 
> > 	git config --global gc.auto 0
> > 	git config --global gc.autopacklimit 0
> 
> Is there any reason why gc.auto=0 couldn't be used to disable auto
> packing entirely?

I think that would be a good thing to do indeed.

> Said differently, are there valid use cases where one might want automatic
> repacking based on the number of packs but _not_ based on the number of
> loose objects?
> 
> If the answer is "no", then "gc.auto=0 means completely disable auto-gc"
> seems intuitive and would have protected Jens in this case.

Agreed.


Nicolas
