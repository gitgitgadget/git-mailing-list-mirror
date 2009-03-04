From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH 1/2] improve missing repository error message
Date: Wed, 4 Mar 2009 10:57:42 -0800
Message-ID: <20090304185742.GI14365@spearce.org>
References: <20090303184106.GH14365@spearce.org> <20090304083229.GA31798@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 19:59:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LewJF-0006Z1-Gg
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 19:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461AbZCDS5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 13:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756983AbZCDS5p
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 13:57:45 -0500
Received: from george.spearce.org ([209.20.77.23]:33635 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461AbZCDS5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 13:57:44 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 38D0638211; Wed,  4 Mar 2009 18:57:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090304083229.GA31798@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112235>

Jeff King <peff@peff.net> wrote:
> Certain remote commands, when asked to do something in a
> particular directory that was not actually a git repository,
> would say "unable to chdir or not a git archive". The
> "chdir" bit is an unnecessary detail, and the term "git
> archive" is much less common these days than "git repository".
> 
> So let's switch them all to:
> 
>   fatal: '%s' does not appear to be a git repository
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> On Tue, Mar 03, 2009 at 10:41:06AM -0800, Shawn O. Pearce wrote:
> 
> > IMHO, maybe we also should change the error message that receive-pack
> > produces when the path its given isn't a Git repository.  Its really
> > not very human friendly to say "unable to chdir or not a git archive".
> > Hell, we don't even call them archives, we call them repositories.

I really mean to write this patch myself, I haven't done much for
git lately.  But I got sidetracked yesterday and forgot.  Thank you
for doing it for me.

> Perhaps this should match the local "Not a git repository: %s". I prefer
> this text, but maybe there is value in consistency.

FWIW I also prefer the text you used in the patch...

-- 
Shawn.
