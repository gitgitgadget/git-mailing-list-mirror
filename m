From: Nicolas Pitre <nico@cam.org>
Subject: Re: [JGIT PATCH 2/1] Honor repack.usedeltabaseoffset when fetching
 packs
Date: Fri, 01 May 2009 19:19:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905011916130.6741@xanadu.home>
References: <1241215224-29374-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 02 01:19:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M021J-0006RW-R8
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 01:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761982AbZEAXTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 19:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZEAXTM
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 19:19:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39512 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbZEAXTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 19:19:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIZ009CZNFRGSF0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 01 May 2009 19:19:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1241215224-29374-1-git-send-email-spearce@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118107>

On Fri, 1 May 2009, Shawn O. Pearce wrote:

> If the local receiving repository has disabled the use of delta base
> offset, for example to retain compatibility with older versions of
> Git that predate OFS_DELTA, we shouldn't ask for ofs-delta support
> when we obtain a pack from the remote server.

Good point.  I doubt it actually matters in practice or we would have 
heard about some complaints by now.  But for consistency sake I should 
produce a similar patch for C git as well.


Nicolas
