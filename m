From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (Aug 2009, #04; Sun, 23)
Date: Sun, 23 Aug 2009 21:26:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908232117460.6044@xanadu.home>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 03:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfOKg-00088U-ME
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 03:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbZHXB0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 21:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZHXB0l
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 21:26:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37603 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbZHXB0k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 21:26:40 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOU00BTVWTNEQ90@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 23 Aug 2009 21:15:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v1vn2qb29.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126898>

On Sun, 23 Aug 2009, Junio C Hamano wrote:

> * lt/block-sha1 (2009-08-17) 4 commits
>   (merged to 'next' on 2009-08-18 at 67a1ce8)
>  + remove ARM and Mozilla SHA1 implementations
>  + block-sha1: guard gcc extensions with __GNUC__
>  + make sure byte swapping is optimal for git
>  + block-sha1: make the size member first in the context struct
> 
> Finishing touches ;-)  There were a few Solaris portability patches
> floated around that I didn't pick up, waiting for them to finalize.

Those would be described better as Solaris _optimization_ patches.  The 
code is already fully portable as it is, except not necessarily optimal 
in some cases.


Nicolas
