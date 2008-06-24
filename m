From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/3] implement some resilience against pack corruptions
Date: Mon, 23 Jun 2008 22:20:21 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806232219020.2979@xanadu.home>
References: <alpine.LFD.1.10.0806232122180.2979@xanadu.home>
 <20080624013331.GR11793@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy9n-0007UV-7D
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbYFXCUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYFXCUX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:20:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34718 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYFXCUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:20:22 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Y008LA3TXF5D0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Jun 2008 22:20:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080624013331.GR11793@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85982>

On Mon, 23 Jun 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > We should be able to fall back to loose objects or alternative packs when
> > a pack becomes corrupted.  This is especially true when an object exists
> > in one pack only as a delta but its base object is corrupted.  Currently
> > there is no way to retrieve the former object even if the later is
> > available in another pack or loose.
> 
> Dang, nice timing Nico.  We were bitten by something like this at
> day-job a couple of weeks back.  Adding this sort of support went
> onto my internal todo-list.  I'm glad you beat me to it.  :)
>  
> > Yes I've been bitten by the corruption described above...
> 
> But sorry to hear about this.

Well, this is fixed now.  So the theory worked.  ;-)


Nicolas
