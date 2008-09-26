From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-stash.sh: don't default to refs/stash if invalid ref
	supplied
Date: Fri, 26 Sep 2008 08:25:27 -0700
Message-ID: <20080926152527.GB17584@spearce.org>
References: <rM3bh5QWZGeYnjwx4dCYZ179UgQYlxany_gu84OcX6FVMMOkKmGKWg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:27:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjFDL-0000uv-SH
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbYIZPZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYIZPZ3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:25:29 -0400
Received: from george.spearce.org ([209.20.77.23]:56410 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYIZPZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:25:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9C95138360; Fri, 26 Sep 2008 15:25:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <rM3bh5QWZGeYnjwx4dCYZ179UgQYlxany_gu84OcX6FVMMOkKmGKWg@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96868>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
>    commit da65e7c133cd316c9076fbb6b0aeee7bc42a6db8
>    Author: Brandon Casey <casey@nrlssc.navy.mil>
>    Date:   Tue Sep 23 18:57:09 2008 -0500
> 
>        git-stash.sh: don't default to refs/stash if invalid ref supplied
>     
>        <snip>
>     
>        e.g. 'git stash apply stash@{1}' would fall back to
>             'git stash apply stash@{0}'
> 
> heh, you fixed my spelling "mistake" :), but it wasn't a mistake. Originally
> I had:

Heh.  I geuss my spleling meter was working overtime yesterday?  ;-)

>     e.g. 'git stash apply stahs@{1}' would fall back to
>          'git stash apply stash@{0}'
> 
> intending to show that a simple spelling mistake could cause the wrong thing
> to be done. The example in the commit message could actually still happen if
> there was only a single stash entry. I guess I should have used 'foobar@{1}'. :)

Yea, reading it now I see why you had the typo in the message.
But yesterday it just looked like a typo to me.  Dammit.  That's
the last time I cleanup a typo before applying a patch!

;-)

-- 
Shawn.
