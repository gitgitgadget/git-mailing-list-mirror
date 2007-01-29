From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Mon, 29 Jan 2007 01:39:02 -0500
Message-ID: <20070129063902.GK12125@fieldses.org>
References: <20070127062826.GE14205@fieldses.org> <20070128002246.GA10179@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 29 07:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBQAd-0003NE-SP
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 07:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933214AbXA2GjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 01:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933241AbXA2GjG
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 01:39:06 -0500
Received: from mail.fieldses.org ([66.93.2.214]:54291 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933214AbXA2GjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 01:39:05 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HBQAQ-0005eD-OW
	for git@vger.kernel.org; Mon, 29 Jan 2007 01:39:02 -0500
Content-Disposition: inline
In-Reply-To: <20070128002246.GA10179@moooo.ath.cx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38065>

On Sun, Jan 28, 2007 at 01:22:46AM +0100, Matthias Lederhofer wrote:
> ---
> There are some other places where direct editing of .git/config is
> suggested.  I'd rather tell the user to use repo-config and add a note
> that repo-config saves the configuration to .git/config (or
> ~/.gitconfig with --global) which can be edited by hand too.
> cat .git/config to show the remote configuration can be replaced by
> git-repo-config -l | grep '^remote\.'
> ---

Based on the followup I think what makes sense is to continue with some
mixture of the two approaches--mainly editing the configuration file
directly, but providing frequent references to the
git-repo-config/git-config manpage so people know where to find the
details.

I've added a few more references to the manpage, along with a few other
updates, including an initial import of Linus's discussion of dangling
objects, and brief dicussions of reflogs, fsck, and pruning:

	git://linux-nfs.org/~bfields/git.git master
	http://www.fieldses.org/~bfields/git-user-manual.html

--b.
