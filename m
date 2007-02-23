From: Pavel Roskin <proski@gnu.org>
Subject: Re: RFC: script to add another remote
Date: Fri, 23 Feb 2007 03:24:32 -0500
Message-ID: <1172219072.20390.17.camel@dv>
References: <1172182595.20817.26.camel@dv>
	 <7v8xepde5g.fsf@assigned-by-dhcp.cox.net> <1172218468.20390.15.camel@dv>
	 <7vbqjl9td1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 09:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKVjM-0001yO-Lv
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 09:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbXBWIYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 03:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbXBWIYh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 03:24:37 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:46810 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbXBWIYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 03:24:36 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HKVho-0000zH-PM
	for git@vger.kernel.org; Fri, 23 Feb 2007 03:23:04 -0500
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HKVjF-0000Dg-2B; Fri, 23 Feb 2007 03:24:33 -0500
In-Reply-To: <7vbqjl9td1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.9.91 (2.9.91-3.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40425>

On Fri, 2007-02-23 at 00:21 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > It looks like git-clone should be extended to support cloning of a
> > repository on top of the existing one.
> 
> Actually git-remote was done during a previous discussion on the
> same subject, with a goal to make it possible to rewrite
> git-clone (after giving the "where is the HEAD" logic to
> git-remote, perhaps) in terms of git-init and git-remote.
> 
> So probably the next step would be to refactor some logic and
> functionality out of git-clone, move them to git-remote, and
> reimplement git-clone in terms of git-remote.  Implementation of
> "--more" option would become much simpler (or, almost free)
> after that is done.

Oh, I see.  Thanks for the explanation.

-- 
Regards,
Pavel Roskin
