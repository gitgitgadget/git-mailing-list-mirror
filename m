From: Scott Lamb <slamb@slamb.org>
Subject: Re: git-cvsimport newbie question
Date: Wed, 11 Jul 2007 08:45:48 -0700
Message-ID: <4694FB2C.4070505@slamb.org>
References: <469484AA.7040701@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 17:46:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8eOi-0006SF-0V
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 17:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754AbXGKPqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 11:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756651AbXGKPqL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 11:46:11 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:44217 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755561AbXGKPqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 11:46:10 -0400
Received: from spiff.local (ppp-71-139-183-188.dsl.snfc21.pacbell.net [71.139.183.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id A631B980D0
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 08:46:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <469484AA.7040701@slamb.org>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52172>

Scott Lamb wrote:
> But from the manpage, it appears I'm reverting to a much older way of
> doing things. Maybe I should be giving the newer way a shot? Was this
> "-r" way meant to be used with cloning the mirrored repository? If so,
> what's the workflow there? maybe I should reset racoon2.git's "master"
> branch to the beginning of time (to avoid confusion), update head to
> point to remotes/wide/master (so simple "git clone" and "git pull"
> commands get CVS HEAD), and then update remote.origin.fetch on each
> cloned repository to pull in other branches as needed? But even after
> doing that, "git remote show origin" on a cloned repository still won't
> give me the list of branches I want. So this seems doesn't seem as good
> as the old way.
> 
> Is there any way to make a repository cloned from a new-style
> cvsimported one show the list of branches? It looks like I can't have a
> remote in one repository refer to a remote in another repository - it
> wants a direct reference. Most things seem to ignore origin's remotes,
> at least unless I explicitly name one like "git pull origin
> refs/remotes/wide/master".

Hmm...I just saw in a git-svn howto [1] this text:

    [FIXME] This is all very important information for people setting
    up central tracking servers. This needs expansion, probably its own
    section. Talk about tracking server symlink tricks
    (eg refs/heads/svn -> ../remotes and
    refs/ttags/svn -> ../remotes/tags)

Maybe I want to be doing something similar with git-cvsimport? I'm sure
there's *some* reason way to take advantage of the my named remote; I
just haven't figured out what it is yet. Could someone please fill in
details on this text?

Best regards,
Scott


[1] - http://utsl.gen.nz/talks/git-svn/intro.html
