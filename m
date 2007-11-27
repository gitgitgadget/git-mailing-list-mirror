From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 09:29:21 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
 <Pine.LNX.4.64.0711271109130.27959@racer.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_q51Tbf/zG2kVoDZcertsfw)"
Cc: =?ISO-2022-JP?Q?=1B$B$i$$$7$J$J$3=1B=28J?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1RX-0003EE-Oy
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbXK0O3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 09:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbXK0O3X
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:29:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43625 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbXK0O3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:29:22 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS6005TC5KXGZ90@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Nov 2007 09:29:22 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0711271109130.27959@racer.site>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66216>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_q51Tbf/zG2kVoDZcertsfw)
Content-type: TEXT/PLAIN; charset=ISO-2022-JP
Content-transfer-encoding: 7BIT

On Tue, 27 Nov 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 27 Nov 2007, しらいしななこ wrote:
> 
> > Was it coded poorly, buggy or were there some other issues?
> 
> It is very well possible that it was coded poorly ;-)
> 
> The main reason, I believe, was that some old-timers who know the 
> implications said that it would encourage a wrong workflow.  One thing 
> that could go possibly wrong, for example, is to rebase commits that you 
> already published.

Being much more involved in the maintenance of a published Git tree 
lately, I must disagree with the "wrong workflow" statement.  Until the 
stuff I maintain is finally merged upstream, I have to constantly 
amend/replace/fold/split random commits in my repo to follow the review 
cycles involved.  yet I have to publish the result to let others base 
their work on top of my latest tree.  A fetch+rebase is the only option 
for those following my tree, and I made it clear that they have to 
rebase after a fetch because I constantly rebase commits that I have 
already published myself.

And in this case, constant rebasing is a perfectly fine work flow to me. 
Otherwise I might just use Git as a glorified tarball downloader and use 
quilt on top, but this is somehow not as appealing.


Nicolas

--Boundary_(ID_q51Tbf/zG2kVoDZcertsfw)--
