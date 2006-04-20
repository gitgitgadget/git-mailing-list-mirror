From: Nicolas Pitre <nico@cam.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 13:54:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604201352330.2215@localhost.localdomain>
References: <20060420133640.GA31198@spearce.org>
 <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org>
 <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org>
 <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
 <20060420173131.GF31738@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 19:54:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWdMe-0007xv-LE
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 19:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWDTRyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWDTRyp
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 13:54:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37776 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751190AbWDTRyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 13:54:45 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY100B4K8F80840@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Apr 2006 13:54:44 -0400 (EDT)
In-reply-to: <20060420173131.GF31738@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18985>

On Thu, 20 Apr 2006, Shawn Pearce wrote:

> I just spent some time bisecting this issue and it looks like the
> following change by Junio may be the culprit:
> 
>   commit 1d6b38cc76c348e2477506ca9759fc241e3d0d46
>   Author: Junio C Hamano <junkio@cox.net>
>   Date:   Wed Feb 22 22:10:24 2006 -0800
>   
>       pack-objects: use full pathname to help hashing with "thin" pack.
>       
>       This uses the same hashing algorithm to the "preferred base
>       tree" objects and the incoming pathnames, to group the same
>       files from different revs together, while spreading files with
>       the same basename in different directories.
>       
>       Signed-off-by: Junio C Hamano <junkio@cox.net>
>   
>   :100644 100644 af3bdf5d358b8a47ed23bcb7e9721e956eb59d60 3a16b7e4ce25ec05c64817dfd92dd9d517ab9dd3 M      pack-objects.c

Hmmm... This one is for Junio to fix I'd say.  Not sure what it does.


Nicolas
