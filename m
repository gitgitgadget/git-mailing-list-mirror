From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 11:36:46 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705271135180.3366@xanadu.home>
References: <20070527104600.GA23554@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun May 27 17:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsKo1-0002UL-CZ
	for gcvg-git@gmane.org; Sun, 27 May 2007 17:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbXE0Pgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 11:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbXE0Pgt
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 11:36:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24809 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbXE0Pgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 11:36:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIP007MDI1AVPA0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 27 May 2007 11:36:46 -0400 (EDT)
In-reply-to: <20070527104600.GA23554@auto.tuwien.ac.at>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48562>

On Sun, 27 May 2007, Martin Koegler wrote:

> Dana How wrote:
> > (1c) Do not deltify naughty blobs.  Naughty blobs are those
> >      blobs marked "nodelta" or very large blobs.
> 
> I don't like the idea to exclude any blobs from delta by default, if
> the delta could be done.

It won't happen by default.

> If the "very large blobs" are text files with
> very few difference, they deltifiy very well.
> 
> Additionlly, how do you want to define "very large blobs"? 

This is indeed a per repository attribute that is highly dependent on 
your data set.


Nicolas
