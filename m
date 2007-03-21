From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Tue, 20 Mar 2007 22:54:26 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703202243530.18328@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <200703181929.58278.robin.rosenberg.lists@dewire.com>
 <45FE8D1E.6040408@sinister.cz>
 <200703200735.41234.robin.rosenberg.lists@dewire.com>
 <45FFA5CB.1060700@sinister.cz>
 <Pine.LNX.4.64.0703201922160.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: David Brodsky <trekie@sinister.cz>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 03:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTqy6-00010C-SN
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 03:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbXCUCy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 22:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbXCUCy2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 22:54:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14227 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbXCUCy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 22:54:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF800HFJG2Q8ZD0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Mar 2007 22:54:26 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703201922160.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42775>

On Tue, 20 Mar 2007, Linus Torvalds wrote:

> 
> 
> On Tue, 20 Mar 2007, David Brodsky wrote:
> > 
> > And (hopefully) permanent http://steamer.kajka.koleje.cuni.cz/Eclipse
> 
> Ok, thanks, downloaded. Although the pack-file is just 1.7GB for me, not 
> 3.7 like somebody said.

There is a 1.3GB garbage pack_sETUPg file in eclipse.git/objects/ laying 
there, probably resulting from an interrupted index-pack, making the 
repository needlessly bigger.  It can be safely deleted.

We probably should make git-prune get rid of those automatically.


Nicolas
