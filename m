From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git commit error on initial (the very first) commit
Date: Sun, 29 Jan 2006 16:51:57 -0500
Message-ID: <20060129215157.GB12394@fieldses.org>
References: <200601292026.54893.arvidjaar@mail.ru> <20060129181625.GA5540@fieldses.org> <7v1wyqivx1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 22:52:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3KSs-00042R-My
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 22:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWA2VwD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 16:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWA2VwD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 16:52:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:4064 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1751185AbWA2VwC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 16:52:02 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F3KSj-0004xY-LC; Sun, 29 Jan 2006 16:51:57 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wyqivx1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15246>

On Sun, Jan 29, 2006 at 01:08:58PM -0800, Junio C Hamano wrote:
> In a freshly created repository, "git add ." would register
> everything to the index file, and a "git commit" with or without
> "-a" that immediately follows "git add ." would commit what is
> in the index.  Use of "-a" would not make a difference here.

Aie, you're right of course, thanks.--b.
