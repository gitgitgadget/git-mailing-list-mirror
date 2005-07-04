From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Last mile for 1.0 again
Date: Mon, 4 Jul 2005 17:40:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507041635350.30848-100000@iabervon.org>
References: <7v4qbhfxad.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 04 23:43:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpYiY-0000IQ-L5
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 23:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVGDVmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 17:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGDVmt
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 17:42:49 -0400
Received: from iabervon.org ([66.92.72.58]:50693 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261692AbVGDVmi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 17:42:38 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpYgI-0007Ta-00; Mon, 4 Jul 2005 17:40:46 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qbhfxad.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 29 Jun 2005, Junio C Hamano wrote:

>  - Blame/Annotate.  Does anybody have a fast and correct one

How about an option to git-rev-list to take a path, and (1) exclude any
branch where the version at that path ends up ignored in a merge and
(2) not list any revision where the version at that path is identical to a
parent?

This should give you the list of all commits which are directly
responsible for the present state of the file, which can then be formatted
as desired.

	-Daniel
*This .sig left intentionally blank*
