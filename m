From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Really *do* nothing in while loop
Date: Sun, 8 May 2005 17:16:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505081713070.30848-100000@iabervon.org>
References: <7vy8ap4e8l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Tokarev <mjt@tls.msk.ru>, jdow <jdow@earthlink.net>,
	James Purser <purserj@ksit.dynalias.com>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 23:11:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUt2v-0006T3-N7
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVEHVRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVEHVRs
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:17:48 -0400
Received: from iabervon.org ([66.92.72.58]:10245 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261685AbVEHVRq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 17:17:46 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DUt8P-0004lW-00; Sun, 8 May 2005 17:16:21 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8ap4e8l.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 8 May 2005, Junio C Hamano wrote:

> >>>>> "MT" == Michael Tokarev <mjt@tls.msk.ru> writes:
> 
> MT> As I already said, deflate() in this case does only ONE iteration.
> MT> stream.avail_in is NOT changed in the loop (except of the deflate()
> MT> itself, where it will be set to 0 - provided out buffer have enouth
> MT> room)....
> 
> Just a stupid question, but what happens when we do not have
> enough room in the buffer?

We must have enough room; we sized the buffer with deflateBound to fit the
worst case.

	-Daniel
*This .sig left intentionally blank*


