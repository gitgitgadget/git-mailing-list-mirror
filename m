From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Wed, 06 Jun 2007 23:05:55 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706062301210.12885@xanadu.home>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
 <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 05:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw8KC-0007jl-HU
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 05:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbXFGDGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 23:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbXFGDF7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 23:05:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29918 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbXFGDF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 23:05:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJ800BMOWLVFJ70@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Jun 2007 23:05:55 -0400 (EDT)
In-reply-to: <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49345>

On Wed, 6 Jun 2007, Dana How wrote:

> On 6/6/07, Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> > This is a quick hack at generational repacking.  The idea is that you
> > successively do larger repack runs as the number of packs accumulates.
> > 
> This patch complicates git-repack.sh quite a bit and
> I'm unclear on what _problem_ you're addressing.
> The recent LRU preferred pack patch
> reduces much of the value in keeping a repository tidy
> ("tidy" == "few pack files").
[...]

For the record... I didn't comment on this patch because I couldn't 
form 
a clear opinion about it.

But until its usefulness can be demonstrated I should side with Dana 
here.


Nicolas
