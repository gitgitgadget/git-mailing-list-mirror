From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] allow OFS_DELTA objects during a push
Date: Fri, 01 May 2009 20:24:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905012021070.6741@xanadu.home>
References: <20090415182754.GF23644@curie-int>
 <alpine.LFD.2.00.0904151443030.6741@xanadu.home>
 <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0905011616130.6741@xanadu.home>
 <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 02 02:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M033N-000123-Ii
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 02:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbZEBAYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 20:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbZEBAYz
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 20:24:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36466 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZEBAYy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 20:24:54 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIZ00GOHQHAJB70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 01 May 2009 20:24:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v4ow4v0xl.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118112>

On Fri, 1 May 2009, Junio C Hamano wrote:

> Thanks.
> 
> The code looks correct, I am reasonably sure updated server-client
> combination would work fine, and use of the capability mechanism means
> other combinations like old pusher and new receiver, and/or new pusher and
> old receiver, should be also Ok.
> 
> I see Shawn did the same to jgit.
> 
> But I'd like to queue this in 'next', and make it official after 1.6.3
> happens.
> 
> I just do not want to repeat silly mistakes, this close to the final,
> similar to the "github needs to get stuck forever at 1.6.1" we made with
> 40c155f (push: prepare sender to receive extended ref information from the
> receiver, 2008-09-09); it was done as a good change after a discussion
> among Shawn, Daniel and I.

No problem.  Since this is fixing something that actually never worked 
before, it is therefore not what I would call a critical fix.


Nicolas
