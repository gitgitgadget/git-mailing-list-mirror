From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fix git-svn for SVN 1.7
Date: Tue, 31 Jul 2012 20:01:08 +0000
Message-ID: <20120731200108.GA14462@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
 <7v1ujsl8ut.fsf@alter.siamese.dyndns.org>
 <5017AB63.6080909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:01:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwId1-00034A-PP
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab2GaUBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:01:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37451 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271Ab2GaUBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:01:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 064DB1F408;
	Tue, 31 Jul 2012 20:01:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5017AB63.6080909@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202678>

Michael G Schwern <schwern@pobox.com> wrote:
> It just doesn't matter.
> 
> Why are we arguing over which solution will be 4% better two years from now,
> or if my commits are formatted perfectly, when tremendous amounts of basic
> work to be done improving git-svn?  The code is undocumented, lacking unit
> tests, difficult to understand and riddled with bugs.

Yes it does matter.

git-svn has the problems it has because it traditionally had lower
review standards than the rest of git.  So yes, we're being more careful
nowadays about the long-term ramifications of changes.

> Either solution would be a vast improvement.  The most important thing is that
> one of them actually gets done.  If both solutions offer a huge improvement,
> do it the way the person actually writing the code wants to do it.  It'll be
> more enjoyable for them, they'll be more likely to complete the work, and more
> likely to stick around and code some more.

The self-obsoleting nature of git-svn makes it hard for anybody to stick
around.  Most of the original contributors (including myself) hardly see
an SVN repo anymore, so users/contributors forget about it and new ones
come along...

I want to make sure things stay consistent with the core parts of git,
especially if the Perl were to be replaced with a pure C version.
