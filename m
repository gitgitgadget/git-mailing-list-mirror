From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: when is "git diff" output suitable for patch?
Date: Thu, 13 Jul 2006 17:31:16 -0400
Message-ID: <20060713213116.GK19366@fieldses.org>
References: <20060713212127.GA30770@fieldses.org> <7vhd1lurei.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 23:31:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G18mH-0007UK-TZ
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 23:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWGMVbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWGMVbS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 17:31:18 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38379 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030406AbWGMVbR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 17:31:17 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1G18mC-0008P3-GH; Thu, 13 Jul 2006 17:31:16 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd1lurei.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23854>

On Thu, Jul 13, 2006 at 02:27:33PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > I assume the -C and -M, -c, and -cc options all result in diff output
> > that can't be correctly applied by "patch" any more?  (Would a patch to
> > the git-diff-files documentation warning about this be helpful?)
> 
> May not be bad to have, except that I do not know if
> "git-diff-files" documentation is the right place to talk about
> it.

OK.

> > Someone I'm working with is having trouble applying patches that they
> > created with a simple "git diff".  The patches in question have some
> > "copy from/copy to" headers.  Should that every happen with just a plain
> > "git diff"?  Is this a bug in their version of git?  (They're on 1.2.4).
> 
> As far as I recall "git diff" never defaulted to -M.

Hm.  Is this related?:

commit 42efbf6d8a5b4902c55a2f6e96034625c056ba1f
Author: Junio C Hamano <junkio@cox.net>
Date:   Sat Mar 11 17:44:10 2006 -0800

    git-diff: -p disables rename detection.

--b.
