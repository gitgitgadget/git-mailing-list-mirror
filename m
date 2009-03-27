From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] avoid possible overflow in delta size filtering computation
Date: Thu, 26 Mar 2009 22:23:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903262218470.18797@xanadu.home>
References: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
 <86hc1hdcj1.fsf@broadpark.no>
 <alpine.LFD.2.00.0903250936100.26337@xanadu.home>
 <86bprptvcx.fsf@broadpark.no>
 <alpine.LFD.2.00.0903251514360.26337@xanadu.home> <86y6usah1p.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri Mar 27 03:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln1lA-0007sy-Ur
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 03:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933317AbZC0CXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 22:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760183AbZC0CXs
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 22:23:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19771 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608AbZC0CXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 22:23:48 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH5007C47XMDIB0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 26 Mar 2009 22:22:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <86y6usah1p.fsf@broadpark.no>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114842>

On Thu, 26 Mar 2009, Kjetil Barvik wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Here you go.  If you want a perfectly deterministic repacking, you'll 
> > have to force the pack.threads config option to 1.
> 
>   OK, have rerun the test again with pack.config set to 1, and got the
>   exact same result(1) as above this time also!  :-)

Good.

>   Give me a hint if you want some debug info from the 2 pack/idx files.

I think there is nothing else to debug.  Having some differences between 
successive threaded repacks is expected.


Nicolas
