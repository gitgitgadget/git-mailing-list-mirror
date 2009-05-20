From: Nicolas Pitre <nico@cam.org>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 14:25:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905201421440.3906@xanadu.home>
References: <4A136C40.6020808@workspacewhiz.com>
 <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
 <20090520032139.GB10212@coredump.intra.peff.net>
 <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
 <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
 <alpine.LFD.2.00.0905200853010.3906@xanadu.home>
 <20090520141709.GO30527@spearce.org> <7vab57zmd8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0905201406280.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 20:26:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6qV8-00024V-0y
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 20:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729AbZETSZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 14:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbZETSZd
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 14:25:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18482 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbZETSZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 14:25:28 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KJY008H7GI87082@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 May 2009 14:25:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0905201406280.3906@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119628>

On Wed, 20 May 2009, Nicolas Pitre wrote:

> On Wed, 20 May 2009, Junio C Hamano wrote:
> 
> >  (3) What should happen when you cannot write the index out as a tree?  I
> >      think it is easier to make mistakes during a conflicted merge
> >      resolution than during a straight linear development of your own, and
> >      one of the cases that would benefit most would be that you have
> >      resolved a path to your satisfaction but then later you screw up
> >      while resolving some other paths, losing an earlier resolution.
> 
> This one is tricky.  Maybe storing two reflog entries corresponding to 
> the unresolved stages?

BTW, what happens if one tries to 'git stash' an unresolved index?  So 
far this trash reflog and git stash have quite in common, and stashing 
an unresolved index certainly has value too.


Nicolas
