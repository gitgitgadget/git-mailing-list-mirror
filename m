From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: rebasing merges
Date: Mon, 22 Sep 2008 23:19:27 -0500
Organization: Exigence
Message-ID: <20080922231927.ef18f420.stephen@exigencecorp.com>
References: <20080922155749.c8070681.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 06:20:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhzOG-0002tk-Qr
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 06:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbYIWETe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 00:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbYIWETd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 00:19:33 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:40489 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYIWETd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 00:19:33 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id D7A3B5B1EA9
	for <git@vger.kernel.org>; Tue, 23 Sep 2008 00:19:29 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 8D0955B1E94
	for <git@vger.kernel.org>; Tue, 23 Sep 2008 00:19:29 -0400 (EDT)
In-Reply-To: <20080922155749.c8070681.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96521>


> [1] seems to solve this with some fairly complex cherry-picking and
> ancestry manipulation that, admittedly, I don't quite understand, but
> it seems like it might be able to bring along a merge's multiple
> parents information throughout the rebase and maintain the merge as a
> single, non-flattened merge commit.

Hm. Sorry for the noise about that Mercurial link--mostly talking to
myself now, but I've discovered `git rebase -i -p` does exactly what I
want (I think).

Is there a reason the "preserve merge" option in the
git-rebase--interactive isn't also in the non-interactive git-rebase
that is invoked by a git pull --rebase?

I noticed the t3400.sh test explicitly tests for the flattening
behavior, but I can't tell if that is because it's testing for
explicitly desired behavior or if the "linear-izing" is something
that is up for debate (or a command line/config option).

Would it be foolish for me to work on something like this? I can
probably hold my own at copy/pasting around in the shell scripts.

Thanks,
Stephen
