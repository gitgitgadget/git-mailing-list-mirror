From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:13:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
 <200610180057.25411.jnareb@gmail.com>
 <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
 <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
 <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 21:13:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaGr8-0005Mf-EU
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWJRTNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbWJRTNS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:13:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36006 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1161269AbWJRTNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:13:16 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7C00MFOIQ3GZE0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 15:13:15 -0400 (EDT)
In-reply-to: <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29255>

On Wed, 18 Oct 2006, Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
> > By the way, originally I just wanted to index and save the pack, but
> > when trying to feed it to git-index-pack, I kept getting
> >
> > 	fatal: packfile '.git/objects/pack/pack-b2ab684daebea5b9c5a6492fa732e0d2e1799c8e.pack' has unresolved deltas
> >
> > while feeding it to git-unpack-objects works fine. Any idea what's wrong?
> 
> Yes.  You told the pipeline, with --objects-edge, to create a
> thin pack.  By definition that is _not_ indexable.

Ah true.  I missed the "thin" pack.

Any idea why we should still prevent this?  It is not like it was a 
technical limitation.


Nicolas
