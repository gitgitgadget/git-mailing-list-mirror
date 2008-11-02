From: Jeff King <peff@peff.net>
Subject: Re: git reset --hard w/o touching every file
Date: Sat, 1 Nov 2008 23:33:13 -0400
Message-ID: <20081102033313.GB4936@coredump.intra.peff.net>
References: <gegn38$lku$1@ger.gmane.org> <20081101110529.GC3819@artemis.corp> <geicn8$ss8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 04:34:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwTjf-0008Fn-8M
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 04:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYKBDdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 23:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYKBDdQ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 23:33:16 -0400
Received: from peff.net ([208.65.91.99]:3696 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbYKBDdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 23:33:15 -0400
Received: (qmail 22165 invoked by uid 111); 2 Nov 2008 03:33:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Nov 2008 23:33:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Nov 2008 23:33:13 -0400
Content-Disposition: inline
In-Reply-To: <geicn8$ss8$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99802>

On Sat, Nov 01, 2008 at 04:03:50PM -0400, Edward Z. Yang wrote:

> Pierre Habouzit wrote:
> > git checkout HEAD -- <list of the files>
> 
> What if I do not know a priori which files *do* need to be updated? Is
> there a command that I can get this information from? Also, I may not

Sorry, I don't quite understand. You want to check out some subset of
files, but you don't know which subset?

Try "git status" or "git diff" to look at which files have changes?

Or maybe we didn't understand your original question.

> necessarily be checking out HEAD.

Doing

  git checkout v1.5 -- <list of files>

or using any other ref will work just fine.

-Peff
