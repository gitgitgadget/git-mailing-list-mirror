From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Nov 2007 23:29:56 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711252324360.9605@xanadu.home>
References: <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
 <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <20071123103003.GB6754@sigill.intra.peff.net>
 <Pine.LNX.4.64.0711231319220.27959@racer.site>
 <20071124113814.GA17861@sigill.intra.peff.net>
 <alpine.LFD.0.99999.0711241042011.9605@xanadu.home>
 <7vtznbqx2w.fsf@gitster.siamese.dyndns.org>
 <20071125215128.GC23820@fieldses.org>
 <alpine.LFD.0.99999.0711252029020.9605@xanadu.home>
 <20071126041521.GA21120@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:30:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwVc0-000756-Pz
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 05:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbXKZE36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 23:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbXKZE36
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 23:29:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32593 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbXKZE35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 23:29:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS300HJ2J5WY4F0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 25 Nov 2007 23:29:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071126041521.GA21120@fieldses.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66042>

On Mon, 26 Nov 2007, J. Bruce Fields wrote:

> I do find that trying to work on top of a constantly rebased branch is
> annoying no matter how I do it.  So I sometimes wonder if we shouldn't
> instead be finding ways to avoid the practice.

I don't think it can't be avoided in many cases.  Some stuff gets 
rebased because it has to be refined before it is merged in a more 
stable and more "official" repository.  Working on top of a rebased 
branch could be much easier if there was a dedicated command to perform 
the local rebase of one's work after a fetch, just like the pull command 
does a merge after a fetch, at which point both work flows would be 
almost equivalent wrt ease of use.


Nicolas
