From: Jeff King <peff@peff.net>
Subject: Re: ignored files stilll listed in git ls-files
Date: Fri, 6 Mar 2009 09:31:46 -0500
Message-ID: <20090306143146.GA4001@coredump.intra.peff.net>
References: <53e35fd50903041731v1a3c10c9sbb9295f322a819ce@mail.gmail.com> <20090305090953.GB30445@coredump.intra.peff.net> <53e35fd50903060602n2573217evcd48fdf822adf972@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Shen <davidshen84@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 15:33:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfb79-0000TN-Pt
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 15:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbZCFOby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 09:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZCFOby
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 09:31:54 -0500
Received: from peff.net ([208.65.91.99]:56353 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbZCFOby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 09:31:54 -0500
Received: (qmail 8650 invoked by uid 107); 6 Mar 2009 14:31:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Mar 2009 09:31:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2009 09:31:46 -0500
Content-Disposition: inline
In-Reply-To: <53e35fd50903060602n2573217evcd48fdf822adf972@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112441>

On Fri, Mar 06, 2009 at 10:02:03PM +0800, David Shen wrote:

> But my problem is only solved on Linux. On my winodws machine, I have
> added a lot of unwanted file to my git repo, before creating
> .gitignore file. I ran 'git rm --cached myfile' to remove it from the
> index. But they still exist in 'git ls-files', because they exist in
> the history. On Linux, I can use 'git filter-branch' to remove them
> from history. But, on windows,

I think filter-branch runs under cygwin (I think it might even run on
msysgit, but just hasn't been included in a shipped version yet). You
can also filter-branch on Linux and then fetch or clone the result to
Windows.

-Peff
