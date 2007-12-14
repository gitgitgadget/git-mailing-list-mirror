From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Fri, 14 Dec 2007 08:14:42 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712140807280.8467@xanadu.home>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
 <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
 <7vir31x38p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 14:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3ANe-0007lo-O8
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 14:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765689AbXLNNOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 08:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759459AbXLNNOo
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 08:14:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58113 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452AbXLNNOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 08:14:43 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT100DZ0JGI2A60@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Dec 2007 08:14:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vir31x38p.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68301>

On Thu, 13 Dec 2007, Junio C Hamano wrote:

> Thanks.
> 
> Deprecating versions before 1.5.2 (May 20 2007) feels a bit too quick,
> but seven month is almost an eternity in git timescale, and by now
> anything older than 1.5.2 can safely be called prehistoric.  Will apply.

Well, index version 1 is not gone.  It's only the version used by 
default that will change, which can be overriden with a config variable.

And even if that wasn't done, then any old Git version can just blow 
away the new index and recreate it.  So it is not like if you actually 
needed a recent version of Git to convert the repo back to the old 
format.

And all this will be effective in 1.5.5 which is still a few months 
ahead.


Nicolas
