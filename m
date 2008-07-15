From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/4] index-pack: Track the object_entry that creates each
 base_data
Date: Mon, 14 Jul 2008 23:42:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142340030.12484@xanadu.home>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <1216001267-33235-2-git-send-email-spearce@spearce.org>
 <1216001267-33235-3-git-send-email-spearce@spearce.org>
 <1216001267-33235-4-git-send-email-spearce@spearce.org>
 <alpine.LFD.1.10.0807142249100.12484@xanadu.home>
 <20080715032008.GE1700@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:44:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIbSi-000656-V3
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756942AbYGODn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756872AbYGODn0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:43:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64523 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418AbYGODnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:43:25 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4100EMQ3MUB190@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 23:42:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080715032008.GE1700@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88515>

On Tue, 15 Jul 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Sun, 13 Jul 2008, Shawn O. Pearce wrote:
> > 
> > > If we free the data stored within a base_data we need the struct
> > > object_entry to get the data back again for use with another
> > > dependent delta.  Storing the object_entry* makes it simple to call
> > > get_data_from_pack() to recover the compressed information.
> > > 
> > > This however means we must add the missing baes object to the end
> > 
> > Typo?
> 
> Yea, Dscho also pointed it out.
> 
> Junio, if you can, please fix this typo in the commit message.
> 
> Its not really a big deal.  I have no plans on posting a replacement
> patch just for this one small typo.

No, it is not a big deal.  I do write crappy english myself.  I 
initially had some comments on the patch itself which whould have 
warranted another patch and then changed my mind.


Nicolas
