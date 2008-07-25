From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git reset musings
Date: Fri, 25 Jul 2008 19:04:33 +0200
Message-ID: <20080725170433.GD27172@leksak.fem-net>
References: <bd6139dc0807241151p177bb8eey6ff0fbd0a5d9008@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jul 25 19:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQjf-00089e-Jv
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 19:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbYGYREo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 13:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYGYREn
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 13:04:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:52565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751319AbYGYREn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 13:04:43 -0400
Received: (qmail invoked by alias); 25 Jul 2008 17:04:41 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp025) with SMTP; 25 Jul 2008 19:04:41 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/AGwBtXK7Ai4kQgJ66QVIT4/eTP637WsLq3gvQWY
	603j9YhBAVF/dt
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMQiX-0001dg-Pz; Fri, 25 Jul 2008 19:04:33 +0200
Content-Disposition: inline
In-Reply-To: <bd6139dc0807241151p177bb8eey6ff0fbd0a5d9008@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90072>

Hi,

Sverre Rabbelier wrote:
> Heya,
> 
> After doing "git reset" you always get a whole bunch of lines saying
> "foo: locally modified". Now I have a "OMG?!" reaction to that every
> so often, where for a brief moment I think something went wrong. A bit
> silly surely, but I suspect that some other users (especially those
> new to git) have had similar reactions. Maybe it would be worth
> letting the user know what's going on? E.g., before suddenly spitting
> out an un-asked-for status report, let the user know that a status
> report is following? Why not just do a 'git status' instead of this
> we-hacked-up-a-quick-status-listing thing?

This is no "quick status listing hack", it is a
"We've just refreshed the index regarding this entry, so we
 should output that this file in the working tree is different
 from the index now."

So you would use the REFRESH_QUIET flag and invoke git-status at the
end of git-reset?
Hmmm, I don't know if this is good.

Isn't typing "git status" the standard reaction to the "OMG?! What's
going here?" feeling?
And after you've first experienced this, it's something you know. There
will not be a second "OMG?!" :)

And "locally modified" seems to be less ambiguous than "needs update".

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
