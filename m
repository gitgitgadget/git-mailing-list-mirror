From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Sat, 31 Jan 2009 02:25:36 -0500
Message-ID: <20090131072536.GE3033@coredump.intra.peff.net>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com> <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com> <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com> <20090130194727.GA31927@coredump.intra.peff.net> <51419b2c0901301221n45cde1abw7a57a13bfa74b34@mail.gmail.com> <20090130202917.GA3370@coredump.intra.peff.net> <51419b2c0901301455h32775947rfc4483fd5a5b6c2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 08:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTAFs-0005bi-47
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 08:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbZAaHZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 02:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZAaHZj
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 02:25:39 -0500
Received: from peff.net ([208.65.91.99]:43026 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbZAaHZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 02:25:38 -0500
Received: (qmail 10544 invoked by uid 107); 31 Jan 2009 07:25:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 02:25:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 02:25:36 -0500
Content-Disposition: inline
In-Reply-To: <51419b2c0901301455h32775947rfc4483fd5a5b6c2a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107912>

On Fri, Jan 30, 2009 at 03:55:28PM -0700, Elijah Newren wrote:

> > So you would have to read color.diff yourself and then decide whether to
> > add --color.
> 
> It looks like I can also set the environment variable GIT_PAGER_IN_USE
> to achieve the same effects (and I don't even need to do so for most
> commands, such as diff, just those whose output I'm parsing and
> possibly tweaking).

Ah, right. I forgot about that. Yes, setting GIT_PAGER_IN_USE should
work, I think.

-Peff
