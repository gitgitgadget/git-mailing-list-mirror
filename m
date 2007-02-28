From: Nicolas Pitre <nico@cam.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 12:42:18 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702281234400.29426@xanadu.home>
References: <17892.64236.443170.43061@lisa.zopyra.com>
 <20070228035713.GC5597@spearce.org> <20070228044719.GA6068@spearce.org>
 <17893.40847.313519.283218@lisa.zopyra.com>
 <17893.42063.186763.291346@lisa.zopyra.com>
 <20070228155412.GC5479@spearce.org>
 <17893.43522.511785.121778@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280830030.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Bill Lear <rael@zopyra.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 19:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMTG5-0005p4-Vl
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXB1SKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXB1SK3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:10:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14307 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbXB1SK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:10:29 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE60022FP6I10G4@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Feb 2007 12:42:18 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702280830030.12485@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40982>

On Wed, 28 Feb 2007, Linus Torvalds wrote:

> One thing to do (maybe you did already) is to just verify that what you're 
> cloning looks fine:
> 
> 	cd ~/devel/project
> 	git fsck --full
> 
> just to be safe.

That won't tell anything.  git-index-pack works on a streamed pack and 
by the time it dies the pack is not complete yet and not moved to the 
final spot.


Nicolas
