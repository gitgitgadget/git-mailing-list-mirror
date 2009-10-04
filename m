From: Jeff King <peff@peff.net>
Subject: Re: Interim maintainer tree
Date: Sun, 4 Oct 2009 02:41:29 -0400
Message-ID: <20091004064129.GB7076@coredump.intra.peff.net>
References: <20090925160504.GW14660@spearce.org>
 <7viqevu1zt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 09:05:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuLA8-0007tG-Gd
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 09:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbZJDGmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 02:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbZJDGmQ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 02:42:16 -0400
Received: from peff.net ([208.65.91.99]:38200 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbZJDGmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 02:42:16 -0400
Received: (qmail 8923 invoked by uid 107); 4 Oct 2009 06:45:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 04 Oct 2009 02:45:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2009 02:41:29 -0400
Content-Disposition: inline
In-Reply-To: <7viqevu1zt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129509>

On Sat, Oct 03, 2009 at 11:06:30PM -0700, Junio C Hamano wrote:

> Thanks, both.
> 
> I've fetched, but haven't fully examined "log ..spearce/*" nor "log ..peff/*"
> yet.
> 
> I noticed that some topics in 'pu' have been rebased (not complaining, but
> just making sure I am not hallucinating).
> 
> Do you have preferences/suggestions as to how to proceed?  Should I just
> take the tips over at this point, or do you have some more patches you
> were polishing but haven't pushed out that I should wait for?

For my stuff, I think you can just take over my tips. I was just
collecting and polishing topics, while Shawn was doing integration. For
topics I have, please use my versions rather than applying from the
list; many of them have extra fixes squashed in, acked-by's collected
from the list, etc.

Here's a brief status report on what's in my tree:

  proposed-master
    One-off patches that I think should go straight to master.

  ef/mscv-noreturn
    This is the latest round and I think should be ready for at least
    'next' (maybe even 'master' as it is really about the build and not
    about functionality).

  ef/msys-imap
    This is from an RFC which has generated some comments. He should be
    posting another round soon. 'pu' at best.

  fc/mutt-alias
    Latest round that addressed comments. Ready for 'next' if not
    'master'.

  jn/gitweb-patch
    After some comments with Jakub, I think the code is right but he
    promised a re-roll with more in the commit message.

  mr/gitweb-snapshot
    This is probably the pu rewind you saw. He posted a v5 of his
    series. I didn't look at it closely, but Jakub ack'd it.

  tf/doc-pt-br
    Minor translation update, ack'd by somebody who can read it. :)
    Ready for 'master'.

There are a few patches floating on the list that I haven't picked up or
looked too closely at yet. Just so we don't drop anything, they are:

  - curl http auth tweak:
    http://article.gmane.org/gmane.comp.version-control.git/129455
    The author said he didn't really test it, and I haven't set up http
    auth to test it with, but probably somebody should do so before
    applying. :)

  - a new rev-cache from Nick

  - silence gcc warning:
    http://article.gmane.org/gmane.comp.version-control.git/129485
    The warning is overly cautious, I think, but it is a dubious enough
    construct that it is probably worth fixing.

  - enable openssl on msvc
    http://article.gmane.org/gmane.comp.version-control.msysgit/7238
    This goes on top of ef/msys-imap, but I think that will be getting a
    re-roll.

-Peff
