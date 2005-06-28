From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 13:04:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506281251380.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506280903510.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 19:00:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnJQZ-0002zq-IK
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 18:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVF1RGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 13:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVF1RGN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 13:06:13 -0400
Received: from iabervon.org ([66.92.72.58]:33285 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262159AbVF1RGH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 13:06:07 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DnJVT-0008Ul-00; Tue, 28 Jun 2005 13:04:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506280903510.19755@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Jun 2005, Linus Torvalds wrote:

> I'll also fix up git-pack-file to be able to pack tag objects (and the
> unpacking to understand them), so that any valid object can be packed. 
> Right now it only handles the objects that git-rev-list knows about.

Actually, the ideal thing would be to move the packing code into an object
file that git-ssh-push can include; that way it can write directly to the
socket instead of going through disk, and it can also go from getting the
remote end's list of common ancestors to having a pack to send without
needing to exec a script.

	-Daniel
*This .sig left intentionally blank*
