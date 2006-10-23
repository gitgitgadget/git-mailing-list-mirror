From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: prune/prune-packed
Date: Sun, 22 Oct 2006 20:53:36 -0400
Message-ID: <20061023005336.GA12932@fieldses.org>
References: <20061022035919.GA4420@fieldses.org> <7vy7r954k7.fsf@assigned-by-dhcp.cox.net> <20061022231422.GA9375@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 02:53:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbo4S-0004bC-Ug
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 02:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWJWAxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWJWAxi
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 20:53:38 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47783 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751016AbWJWAxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 20:53:37 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1Gbo4O-000444-Ju; Sun, 22 Oct 2006 20:53:36 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29810>

Junio C Hamano <junkio@cox.net> writes:
> I am considering the following to address irritation some people
> (including me, actually) are experiencing with this change when
> viewing a small (or no) diff.  Any objections?

So for me, if I run

	less -FRS file

where "file" is less than a page, I see nothing happen whatsoever.

At a guess, maybe it's clearing the screen, displaying the file, the
restoring, all before I see anything happen?

--b.
