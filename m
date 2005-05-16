From: Junio C Hamano <junkio@cox.net>
Subject: Re: rev-list/tree committer/author information.
Date: Mon, 16 May 2005 16:17:18 -0700
Message-ID: <7vekc6n4ld.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505161747290.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 17 01:21:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXorv-0003ba-9D
	for gcvg-git@gmane.org; Tue, 17 May 2005 01:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVEPXSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 19:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVEPXSs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 19:18:48 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7808 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261986AbVEPXRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 19:17:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516231717.XNQK12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 19:17:17 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505161747290.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Mon, 16 May 2005 18:35:17 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> Perhaps have a struct object field for the unpacked data,...
DB> ..., and the parse wouldn't duplicate the work.

Absolutely.  That is what I wanted to see ever since I started
looking at "struct object" derivatives.

