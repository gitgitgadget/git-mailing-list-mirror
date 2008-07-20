From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Mon, 21 Jul 2008 01:39:56 +0200
Message-ID: <20080720233956.GH10151@machine.or.cz>
References: <1216592735-23789-1-git-send-email-code@istique.net> <20080720230846.GH32184@machine.or.cz> <7vy73w16nj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve =?iso-8859-2?Q?Fr=E9cinaux?= <code@istique.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 01:41:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKiWW-0001RO-4a
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 01:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbYGTXj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 19:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbYGTXj7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:39:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44336 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbYGTXj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:39:58 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B5722393B32D; Mon, 21 Jul 2008 01:39:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy73w16nj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89267>

On Sun, Jul 20, 2008 at 04:24:00PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > I think that ls-tree simply shouldn't auto-fill its pathspec based on
> > current prefix in case no pathspec was supplied. Patch to follow.
> 
> Have you dug the list archive from mid-to-late December 2005 that prompted
> the current behaviour (and introduction of --full-name)?  I haven't.  A
> change to always do the --full-name can only be justified by doing so and
> rehashing the issues.
> 
> On the other hand, "fix" is welcome.

You are right, now that I understand the issue better, there's no good
fix for this except perhaps introducing --no-prefix, which is not my
itch to scratch. Here's my original wording improvement:

	Note that if you are within a subdirectory of your working copy,
	'git ls-tree' will automatically prepend the subdirectory prefix
	to the specified paths, and assume the prefix specified in case
	no paths were given - no matter what the tree object is! Thus,
	within a subdirectory, 'git ls-tree' behaves as expected only
	when run on a root tree object.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
