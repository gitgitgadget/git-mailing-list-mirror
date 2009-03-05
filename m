From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/2] improve missing repository error message
Date: Thu, 5 Mar 2009 05:36:59 -0500
Message-ID: <20090305103659.GA17196@coredump.intra.peff.net>
References: <20090303184106.GH14365@spearce.org> <20090304083229.GA31798@coredump.intra.peff.net> <20090304185742.GI14365@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAyO-0000Nh-3F
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbZCEKhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbZCEKhJ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:37:09 -0500
Received: from peff.net ([208.65.91.99]:57270 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbZCEKhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:37:08 -0500
Received: (qmail 29826 invoked by uid 107); 5 Mar 2009 10:37:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 05:37:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 05:36:59 -0500
Content-Disposition: inline
In-Reply-To: <20090304185742.GI14365@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112290>

On Wed, Mar 04, 2009 at 10:57:42AM -0800, Shawn O. Pearce wrote:

> > > IMHO, maybe we also should change the error message that receive-pack
> > > produces when the path its given isn't a Git repository.  Its really
> > > not very human friendly to say "unable to chdir or not a git archive".
> > > Hell, we don't even call them archives, we call them repositories.
> 
> I really mean to write this patch myself, I haven't done much for
> git lately.  But I got sidetracked yesterday and forgot.  Thank you
> for doing it for me.

I think you are OK coasting on past glory for a while longer:

  $ git shortlog -ns | egrep -im2 'jeff|shawn'
  1313  Shawn O. Pearce
   305  Jeff King

:)

> > Perhaps this should match the local "Not a git repository: %s". I prefer
> > this text, but maybe there is value in consistency.
> 
> FWIW I also prefer the text you used in the patch...

I don't know if it is worth changing the _local_ one to match this,
then. I seem to recall some discussion about that message recently.
Personally I find the "Not a git repository (or any of the parent
directories)" wording to be quite awkward.

-Peff
