From: Nicolas Pitre <nico@cam.org>
Subject: Re: [BUG?] Fail to pull from kernel.org: pack has bad object
Date: Mon, 20 Oct 2008 09:59:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810200955250.26244@xanadu.home>
References: <200810201010.29173.johan@herland.net>
 <200810201026.57306.trast@student.ethz.ch>
 <20081020121533.GA2177@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 21:23:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrvKA-00065Z-BY
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbYJTOAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 10:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYJTOAV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 10:00:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23196 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYJTOAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 10:00:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9100DFOIUO2NO0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 20 Oct 2008 09:59:12 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081020121533.GA2177@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98694>

On Mon, 20 Oct 2008, Jeff King wrote:

> I am getting it, too, but I remembered to save my repo. :) The 'next'
> branch is broken, but master works fine. The bisect points to
> 
>   commit 9441b61dc5c3f1f984114ec8bd470dc20c55dfe0
>   Author: Nicolas Pitre <nico@cam.org>
>   Date:   Fri Oct 17 15:57:57 2008 -0400
> 
>       index-pack: rationalize delta resolution code

Dammit... I'm growing a habit of breaking things lately.

> but I don't have time to look further right now (there is a small child
> who apparently thinks coloring with crayons is more interesting than
> bisecting bugs).
> 
> I can make my broken repo available if need be (though given the number
> of us seeing the problem, I doubt it is hard to reproduce).

It certainly is... to me at least.

When index-pack dies like that, a temporary (and incomplete) pack file 
is left in .git/objects/pack/ with tmp in the file name.  I'd need only 
that to reproduce the issue.


Nicolas
