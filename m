From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: use realloc instead of xrealloc
Date: Tue, 29 May 2007 16:51:07 -0700
Message-ID: <7v1wgz5gus.fsf@assigned-by-dhcp.cox.net>
References: <1180465715346-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed May 30 01:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtBTI-0003U4-B1
	for gcvg-git@gmane.org; Wed, 30 May 2007 01:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbXE2XvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 19:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbXE2XvK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 19:51:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57163 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXE2XvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 19:51:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070529235107.ZVBU12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 29 May 2007 19:51:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5Br71X00G1kojtg0000000; Tue, 29 May 2007 19:51:07 -0400
In-Reply-To: <1180465715346-git-send-email-mkoegler@auto.tuwien.ac.at> (Martin
	Koegler's message of "Tue, 29 May 2007 21:08:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48716>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Commit 83572c1a914d3f7a8dd66d954c11bbc665b7b923 changed many
> realloc to xrealloc. This change was made in diff-delta.c too,
> although the code can handle an out of memory failure.
>
> This patch reverts this change in diff-delta.c.

Wasn't there a discussion around this exact issue when the
original patch was applied?
