From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile for 1.0 again
Date: Mon, 04 Jul 2005 14:45:10 -0700
Message-ID: <7vvf3qgs9l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0507041635350.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 04 23:45:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpYl1-0000c2-G9
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 23:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVGDVpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 17:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGDVpW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 17:45:22 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49094 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261706AbVGDVpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 17:45:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050704214512.UFMB17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 4 Jul 2005 17:45:12 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507041635350.30848-100000@iabervon.org> (Daniel Barkalow's message of "Mon, 4 Jul 2005 17:40:46 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> On Wed, 29 Jun 2005, Junio C Hamano wrote:
>> - Blame/Annotate.  Does anybody have a fast and correct one

DB> How about an option to git-rev-list to take a path, and (1) exclude any
DB> branch where the version at that path ends up ignored in a merge and
DB> (2) not list any revision where the version at that path is identical to a
DB> parent?

DB> This should give you the list of all commits which are directly
DB> responsible for the present state of the file, which can then be formatted
DB> as desired.

Sounds close enough if you do not care about copies and
complete rewrites.
