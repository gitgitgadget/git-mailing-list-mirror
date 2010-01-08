From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: base85: Two tiny fixes
Date: Fri, 8 Jan 2010 14:02:02 +0100
Organization: SUSE Labs
Message-ID: <201001081402.02476.agruen@suse.de>
References: <201001071558.30065.agruen@suse.de> <alpine.LFD.2.00.1001071253400.21025@xanadu.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 14:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTEWI-0001Pp-2W
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 14:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345Ab0AHNEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 08:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239Ab0AHNEp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 08:04:45 -0500
Received: from cantor2.suse.de ([195.135.220.15]:53525 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab0AHNEp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 08:04:45 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 37C2A8765C;
	Fri,  8 Jan 2010 14:04:44 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; i686; ; )
In-Reply-To: <alpine.LFD.2.00.1001071253400.21025@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136431>

On Thursday 07 January 2010 18:58:01 Nicolas Pitre wrote:
> ACK.  Please post them to this list.

Okay, done.

> On Thu, 7 Jan 2010, Andreas Gruenbacher wrote:
> > There is another little oddity in the way the de85 table is set up: 0 
> > indicates an invalid entry; to avoid this from clashing with a valid entry, 
> > valid entries are incremented by one and decremented again while decoding.  
> > This leads to slightly worse code than using a negative number to indicate 
> > invalid values (and avoiding to increment/decrement).
> 
> You can make a patch to modify that as well if you wish.

Nah, it's not worth the noise.

> And in that case don't forget to make de85 explicitly signed as a char is
> unsigned by default on some platforms.

I would have forgotten this; thanks for pointing it out!

Thanks,
Andreas
