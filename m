From: Sean <seanlkml@sympatico.ca>
Subject: Re: confusion over the new branch and merge config
Date: Thu, 21 Dec 2006 18:21:02 -0500
Message-ID: <20061221182102.906ad046.seanlkml@sympatico.ca>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 00:21:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxXDq-0006ZV-Jr
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 00:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423128AbWLUXVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 18:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423125AbWLUXVG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 18:21:06 -0500
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:15764 "EHLO
	BAYC1-PASMTP05.CEZ.ICE" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423129AbWLUXVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 18:21:05 -0500
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP05.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 21 Dec 2006 15:21:03 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GxWHb-0007j8-Sr; Thu, 21 Dec 2006 17:20:59 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Dec 2006 23:21:03.0880 (UTC) FILETIME=[AF1EE080:01C72556]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35092>

On Thu, 21 Dec 2006 15:01:21 -0800
Junio C Hamano <junkio@cox.net> wrote:

> No, the message says "any REMOTE branch" -- refs/heads/next is
> what it is called at the remote, and that is how the value is
> expected to be spelled; I think somebody added an example to
> config.txt recently to stress this.  The above error messasge
> obviously was not clear enough.  Rewording appreciated.

This seems inconsistent and confusing.  When working with the
local repository, git-branch doesn't list that as "refs/heads/next"
it just lists "next".  Why all of a sudden when trying to fetch
it from a remote repo must a user know about "refs/heads"?

This seems like an internal detail slipping into the user interface.
But maybe i'm wrong, when would it ever be anything other than
"refs/heads/<branch>"?  If it's _always_ "refs/heads", couldn't that
prefix just be assumed if not provided by the user?

Sean
