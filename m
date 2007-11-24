From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 24 Nov 2007 10:47:56 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711241042011.9605@xanadu.home>
References: <7vmytycykt.fsf@gitster.siamese.dyndns.org>
 <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org>
 <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
 <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
 <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <20071123103003.GB6754@sigill.intra.peff.net>
 <Pine.LNX.4.64.0711231319220.27959@racer.site>
 <20071124113814.GA17861@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 24 16:48:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvxEz-0000KF-1R
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 16:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbXKXPr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 10:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXKXPr6
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 10:47:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61581 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXKXPr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 10:47:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS0003I3P7WC390@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Nov 2007 10:47:57 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071124113814.GA17861@sigill.intra.peff.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65954>

On Sat, 24 Nov 2007, Jeff King wrote:

> On Fri, Nov 23, 2007 at 01:23:44PM +0000, Johannes Schindelin wrote:
> 
> > Maybe we could change the (non-fast forward) message into (non-fast 
> > forward; need to pull?).
> 
> Not unreasonable, although I think our line length is getting a bit
> long.  Rejected refs would look something like (actually they say
> "[rejected]" but the text is column-aligned with the X's):
> 
>  ! XXXXXXX...XXXXXXX ref_name -> ref_name (non-fast forward; need to pull?)
> 
> There's 58 characters of text not including the two ref_names, leaving
> about 11 characters for each ref name. The name of this topic,
> jk/send-pack, would overflow an 80-character terminal:
> 
>  ! [rejected]        jk/send-pack -> jk/send-pack (non-fast forward; need to pull?)

I personally think this is a bad idea, especially after all the efforts 
that has been put into making those lines not to wrap.

Yet the message itself is not totally accurate either, since "need to 
pull" might have to be "need to force" in some cases.

I think that would be better to append a single line at the end of the 
display with a clue about what "non fast forward" means.


Nicolas
