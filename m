From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 26 Nov 2007 14:11:17 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711261358410.9605@xanadu.home>
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
 <alpine.LFD.0.99999.0711252324360.9605@xanadu.home>
 <fie23u$5tc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwjMq-0005AJ-0S
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbXKZTLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbXKZTLU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:11:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10155 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbXKZTLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:11:19 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS400505NYT7KC0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 14:11:17 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <fie23u$5tc$1@ger.gmane.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66091>


[ I get really really annoyed when your replies to me aren't directly 
  addressed to me, Jakub.  Told you so repeatedly in the past as well.
  Why are you the only one on this list apparently not able to use a 
  proper email setup? ]

On Mon, 26 Nov 2007, Jakub Narebski wrote:

> Nicolas Pitre wrote:
> 
> > Some stuff gets rebased because it has to be refined before it is 
> > merged in a more stable and more "official" repository.  Working on 
> > top of a rebased branch could be much easier if there was a 
> > dedicated command to perform the local rebase of one's work after a 
> > fetch, just like the pull command does a merge after a fetch, at 
> > which point both work flows would be almost equivalent wrt ease of 
> > use.
> 
> There was idea of 'rebase' merge strategy (which was in some form
> implemented once under another name: check archives if you want).
> And there is an idea of --rebase switch git git-pull.
> 
> What is left is the implementation ;-)

I thought that had been implemented already.  But in fact I had forgot 
about it altogether.

It shouldn't be much complicated than:

	git fetch ${remote} && \
	git rebase --onto ${remote} ${remote}"@{1}" ${local}

given that ${remote} did actually change during the fetch.


Nicolas
