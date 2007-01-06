From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Sat, 6 Jan 2007 13:58:36 -0500
Message-ID: <20070106185836.GH4655@fieldses.org>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org> <enelha$n8g$3@sea.gmane.org> <87mz51gd7e.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 19:59:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Gkv-0001Rb-Sh
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 19:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXAFS6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 13:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbXAFS6j
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 13:58:39 -0500
Received: from mail.fieldses.org ([66.93.2.214]:55401 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbXAFS6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 13:58:39 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H3GkW-0002vh-TL; Sat, 06 Jan 2007 13:58:36 -0500
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87mz51gd7e.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36095>

On Tue, Jan 02, 2007 at 04:34:45PM -0800, Carl Worth wrote:
> And now I start getting confused. If git-checkout wants a branch, and
> git-branch says that "origin/next" is a branch, then why won't this
> work? OK, I know that something's special about origin/next, (it's a
> "remote-tracking branch" and I needed a -r option to get git-branch to
> list it for me), but nothing in the git-checkout documentation would
> lead me to expect that "git checkout origin/next" wouldn't work.

If we use the word "branches" for things that you can check out and
commit to, then "remote-tracking branches" are not actually branches.
Argh!

What would be better terminology here?

--b.
