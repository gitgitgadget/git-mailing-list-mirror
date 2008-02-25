From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 12:35:31 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802251233020.3167@xanadu.home>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
 <20080225030404.GL8410@spearce.org> <20080225072658.GB15761@auto.tuwien.ac.at>
 <7vwsotmqq2.fsf@gitster.siamese.dyndns.org>
 <20080225075242.GD15761@auto.tuwien.ac.at>
 <7vmyppmpko.fsf@gitster.siamese.dyndns.org>
 <20080225080653.GA20048@auto.tuwien.ac.at> <20080225081206.GO8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 18:36:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JThFK-0005Eu-2Q
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 18:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbYBYRfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 12:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYBYRfd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 12:35:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16190 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbYBYRfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 12:35:32 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWT00A4K277FWH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 25 Feb 2008 12:35:31 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080225081206.GO8410@spearce.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75037>

On Mon, 25 Feb 2008, Shawn O. Pearce wrote:

> Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > On Mon, Feb 25, 2008 at 12:02:15AM -0800, Junio C Hamano wrote:
> > > mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> > > 
> > > > What about
> > > > #define OBJ_BAD -2
> > > 
> > > You mean "#define OBJ_ANY -2"?
> > 
> > Yes.
> > 
> > Should it go into cache.h or should it stay in fsck.h?
> 
> I'd rather see this declared at the end of enum object_type, as
> essentially OBJ_MAX-1.  But Nico may have a different opinion.

Why not alias OBJ_ANY to OBJ_NONE instead?


Nicolas
