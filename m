From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sun, 05 Aug 2007 18:23:42 +0200
Message-ID: <85bqdm6jch.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804092933.aaec6d52.seanlkml@sympatico.ca>
	<85ejijgzzg.fsf@lola.goethe.zz>
	<20070805100532.GG12507@coredump.intra.peff.net>
	<85172807-B7EB-47DD-813E-FAF5894E1190@zib.de>
	<20070805110200.GA18083@coredump.intra.peff.net>
	<85tzre8b4w.fsf@lola.goethe.zz>
	<20070805115208.GA19734@coredump.intra.peff.net>
	<85fy2y89kb.fsf@lola.goethe.zz> <20070805154801.GD28263@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 05 18:39:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHj8b-0006HV-FL
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 18:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbXHEQjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 12:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbXHEQjM
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 12:39:12 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:40403 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbXHEQjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 12:39:11 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IHjAr-0003jj-O3; Sun, 05 Aug 2007 12:41:49 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id ABEDB1C3D500; Sun,  5 Aug 2007 18:23:42 +0200 (CEST)
In-Reply-To: <20070805154801.GD28263@thunk.org> (Theodore Tso's message of "Sun\, 5 Aug 2007 11\:48\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55039>

Theodore Tso <tytso@mit.edu> writes:

> To use a GNU emacs example, consider M-x customize, which is this
> huge, very fancy, *very* complex hierarchical mechanism with a
> pointy-clicky interface for setting options.  Most emacs experts
> wouldn't use it, preferring to open code raw emacs-lisp settings in
> their .emacs.el.  If you ask an old-time emacs user how to set up
> some specific feature setting via M-x customize, they might look at
> you blankly, because it's not an interface they use much, if at all.

Well, let me throw you back one of your questions: do you have any
statistics backing this up?

As to anecdotal evidence: I am an old-time Emacs user, and I pretty
much use customize _exclusively_ since it generally leaves me with a
_working_ configuration even when the DOC string might be sub-optimal
or misleading or hard to understand, and it makes sure that, say,
everything to make a global minor mode _active_ (like loading some
file, or calling some initialization functions) is done at the right
point of time.

If "old-time Emacs users" would not use customize, why would pretty
much _every_ package come with _working_ defcustoms?  Who writes and
_tests_ those defcustoms if not the "old-time Emacs users"?

> A similar thing can be said of "git branch"; once you are familiar
> with how git works at a conceptual level, it can often be
> faster/easier to just hack the .git/config file directly, instead of
> using "git branch" to set up things the way you want.  And I'm
> pretty sure there are ways to set up the config file when you edit
> it by hand that you can't set up via "git branch".

Sure.  But we don't want to _require_ this sort of special knowledge
before one can even hope to do some basic task.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
