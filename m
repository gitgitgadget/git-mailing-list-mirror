From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: Use mozilla-sha1 copyright and license
 information
Date: Mon, 24 Aug 2009 09:45:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908240923360.6044@xanadu.home>
References: <20090824120756.GA17146@ulrik-ibook>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 15:45:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfZrb-0001lg-MC
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 15:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbZHXNpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 09:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbZHXNpZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 09:45:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48696 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbZHXNpY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 09:45:24 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOV004UBVJALGB0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Aug 2009 09:45:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090824120756.GA17146@ulrik-ibook>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126924>

On Mon, 24 Aug 2009, Ulrik Sverdrup wrote:

> block-sha1 needs an independent copyright and license header, in the
> case that the original mozilla SHA-1 implementation is removed from
> the tree.

The Mozilla SHA1 is already removed from the tree in "next", and 
block-sha1/sha1.c header modified accordingly.

As there is nothing remaining from the Mozilla SHA1 code, I don't think 
copying that Mozilla License block verbatim is appropriate.  As Linus 
has put it himself, the Mozilla SHA1 code was more inspirational than 
anything else.

And even if some license claim could be made, the MPL section was 
deleted anyway (as explicitly allowed), meaning that only the GPL (by 
vertu of being included in a GPL project) would then apply.

A question was recently sent to all contributors (see the mail 
archive) to determine if they 
would agree 
to a relicensing of that code to make wider license compatibility.  
George Spelvin even rewrote that code as well with the goal of 
putting his version in the public domain.  No definitive conclusion 
emerged so far though.

Therefore I don't think this patch is appropriate.


Nicolas
