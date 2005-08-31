From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Reorganize read-tree
Date: Tue, 30 Aug 2005 23:28:00 -0700
Message-ID: <7voe7ehb7z.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 08:28:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAM4t-00016W-MT
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 08:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVHaG2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 02:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVHaG2E
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 02:28:04 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:38539 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932395AbVHaG2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 02:28:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050831062801.VBDN9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 Aug 2005 02:28:01 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508302317380.23242@iabervon.org> (Daniel
	Barkalow's message of "Tue, 30 Aug 2005 23:48:27 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7971>

Dan, I really really *REALLY* wanted to try this out in "pu"
branch and even was about to rig some torture chamber for
testing before applying the patch, but you got the shiny blue
bat X-<.

I've checked with both marc and gmane [*], and believe the
problem is not on my end.  The MUA seems to have stripped all
the trailing whitespaces, so you do not have a single SP on
empty context lines, and lack excess trailing whitespace on line
41 of object.h (object_list_insert declaration), for example.

A patch to SubmittingPatches, MUA specific help section for
users of Pine 4.63 would be very much appreciated.

[References]

http://marc.theaimsgroup.com/?l=git&m=112545993929060&q=raw
http://www.mail-archive.com/git@vger.kernel.org/msg03590.html
