From: Pavel Roskin <proski@gnu.org>
Subject: Re: RFC: script to add another remote
Date: Fri, 23 Feb 2007 03:14:28 -0500
Message-ID: <1172218468.20390.15.camel@dv>
References: <1172182595.20817.26.camel@dv>
	 <7v8xepde5g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 09:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKVZe-0006Kp-EX
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 09:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbXBWIOf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 03:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbXBWIOf
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 03:14:35 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:35809 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbXBWIOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 03:14:34 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HKVY6-0007x3-W5
	for git@vger.kernel.org; Fri, 23 Feb 2007 03:13:03 -0500
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HKVZU-0005Rv-Jf; Fri, 23 Feb 2007 03:14:28 -0500
In-Reply-To: <7v8xepde5g.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.9.91 (2.9.91-3.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40423>

On Thu, 2007-02-22 at 14:24 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > It's interesting that git-clone-more can be used instead of git-clone.
> > I can use it e.g. to check out git in an empty directory:
> >
> > git-init
> > git-clone-more git://www.kernel.org/pub/scm/git/git.git git
> 
> Isn't that what "git remote" is about?

I don't understand your question.  "git remote" doesn't provide this
functionality by itself.  "git remote" is used by git-clone-more.  I
wish I were missing the obvious, but just mentioning "git remote" to me
doesn't seem to help.

I see that the manual for "git-remote" includes an example repeating
some parts of git-clone-more.  That's another evidence that the
functionality provided by git-clone-more is needed.

It looks like git-clone should be extended to support cloning of a
repository on top of the existing one.

-- 
Regards,
Pavel Roskin
