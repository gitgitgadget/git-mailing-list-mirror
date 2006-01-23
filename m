From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 00:38:29 -0800
Message-ID: <7voe23z6d6.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601222104120.25300@iabervon.org>
	<7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
	<7v64ob1omh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 23 09:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0xDf-0007xW-Cu
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 09:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWAWIib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 03:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWAWIib
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 03:38:31 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60818 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751434AbWAWIib (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 03:38:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060123083539.HWRS20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 Jan 2006 03:35:39 -0500
To: git@vger.kernel.org
In-Reply-To: <7v64ob1omh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 22 Jan 2006 21:48:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15082>

Junio C Hamano <junkio@cox.net> writes:

> BTW, let's digress a bit.

Ugh.  Serious typo.

> I think recording "commit" in the tree objects is in line with
> the logical organization described in README: "blob" and "tree"
> represent a state, and have *nothing* to do with how we came
> about to that state.  The historyh is described in "commit"
> objects.  The bound commit approach keeps that property.

Obviously, I think "*NOT* recording commit in tree objects" is
in line with "blobs and trees are about states, commits give
them their points in history".
