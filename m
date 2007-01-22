From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: modifying commit's author
Date: Mon, 22 Jan 2007 16:02:01 -0500
Message-ID: <20070122210201.GA6614@fieldses.org>
References: <20070122203734.GB23187@fieldses.org> <7v8xfuss84.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 22:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H96J4-0002ln-Sx
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 22:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbXAVVCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 16:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbXAVVCF
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 16:02:05 -0500
Received: from mail.fieldses.org ([66.93.2.214]:53114 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932633AbXAVVCE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 16:02:04 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H96Ij-0001un-PA; Mon, 22 Jan 2007 16:02:01 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xfuss84.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37453>

On Mon, Jan 22, 2007 at 12:48:27PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > If I got the author wrong on a commit, is there a quick way to fix it
> > (e.g. by passing the right arguments or environment variables to commit
> > --amend)?
> 
> I usually do "format-patch -$n; reset --hard HEAD~$n; edit
> 00??-*.patch; am 00??-*.patch" myself when I got into that
> situation to rebuild the branch, and haven't personally felt
> need for an option to --amend, but it might make sense to teach
> git-commit --amend to allow --author option to override it; I
> think it currently ignores --author when given without erroring
> out.

That might be nice, but actually the git-am trick is more convenient
than I'd realized; thanks for the tip.

--b.
