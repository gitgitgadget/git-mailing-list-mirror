From: Nicolas Pitre <nico@cam.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 13:18:10 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702281315480.29426@xanadu.home>
References: <17892.64236.443170.43061@lisa.zopyra.com>
 <20070228035713.GC5597@spearce.org> <20070228044719.GA6068@spearce.org>
 <17893.40847.313519.283218@lisa.zopyra.com>
 <17893.42063.186763.291346@lisa.zopyra.com>
 <20070228155412.GC5479@spearce.org>
 <17893.43522.511785.121778@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280830030.12485@woody.linux-foundation.org>
 <17893.44936.525606.74693@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280843030.12485@woody.linux-foundation.org>
 <17893.45903.748382.298137@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280910330.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Bill Lear <rael@zopyra.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 19:22:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMTRm-00029Z-Ty
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXB1SW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbXB1SWZ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:22:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53207 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbXB1SWY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:22:24 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE6001WAQUA8GA4@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Feb 2007 13:18:10 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702280910330.12485@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40984>

On Wed, 28 Feb 2007, Linus Torvalds wrote:

> Well, if the return value was 0, it wasn't as odd any more, and the reason 
> seems to be a file truncate error. Shawn seems to be on that one.
> 
> (The "return 305 when asked for 207" seemed like a kernel bug, which was 
> why I got really interested ;)

I wouldn't dismiss a kernel bug just yet.

Bill already said the same operation, when not performed over NFS, works 
just fine.

He also mentioned that version 1.4.4, which uses mmap() instead of 
pread(), works also fine even over NFS.


Nicolas
