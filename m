From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: more than 20 commands in everyday.txt
Date: Wed, 19 Dec 2007 15:23:09 -0800 (PST)
Message-ID: <m34peep8vc.fsf@roke.D-201>
References: <20071219225618.GA7378@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J58GL-0002ji-M0
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 00:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbXLSXXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 18:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbXLSXXO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 18:23:14 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:5765 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbXLSXXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 18:23:13 -0500
Received: by mu-out-0910.google.com with SMTP id i10so4485984mue.5
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 15:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=3Tmch+dyxtexkNC+tTGibRRZsuGNfIzi1nxquJtRHw0=;
        b=MDlExJF8yCf7d2PrSz7npipbwgFztAbabR+6uUeOoJEU2LNur7l6HAlNjIa3ZlEikSRLN0EZA1AWNmKSWgxpHaiEMGqkbSmsrPjOgGaBbCyfVi0QKbO32WpWhXr8wYfUQmC449JY4aZlIMye1oyRAqs3nD4hBAArMU+2Ej+UK8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=mcP2W+53M6HFO71UQ4ATQsPhdYI5yV94/Gbi8XzB9UZ9Z8tlll8V6ygKroaXVWcOFrE9OY8PUqcp+0DAft6qQm7U8kU/ZO9T05XfUwoRjJM1jL2rlEDmmLbTLNbWl1snS+30gLoMXNYmisue6dYv8fclh1MkqEwvvZYp9i0/2qw=
Received: by 10.86.50.8 with SMTP id x8mr9437440fgx.61.1198106590931;
        Wed, 19 Dec 2007 15:23:10 -0800 (PST)
Received: from roke.D-201 ( [83.8.252.93])
        by mx.google.com with ESMTPS id e11sm11316225fga.2007.12.19.15.23.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2007 15:23:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBJNN5Zi031516;
	Thu, 20 Dec 2007 00:23:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBJNN4OS031513;
	Thu, 20 Dec 2007 00:23:04 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071219225618.GA7378@genesis.frugalware.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68954>

Miklos Vajna <vmiklos@frugalware.org> writes:

> this might seem to be a bit bikesheding, but i hope it isn't. today i
> teched git to someone who never used any scm so far. i showed him the
> "everyday with git" document, as i think it's a great start for newbies.
> actually i read it once but it was in the past, now i did it again and i
> think there are some commands listed there which is not something we use
> "every day". of course it may be only me, that's why i ask. here are the
> commands i rarely use and are in everyday.txt:
> 
> - git-prune and git-repack: usually i use git-gc only. maybe prune and
>   repack could be removed from everyday.txt?

I agree that git-repack should be removed (there is git-gc), and
git-prune should be replaced by mentioning --prune option to git-gc.
This document is for newbies, and they shouldn't need to run anything
other than git-gc.

Besides with new enough git the number of generated loose objects
should be greatly reduced: git now produces (small) packs if
possible.
 
I'm not sure if mentioning git-fsck at all, or at least this early is
a good idea for introductory tutorial. Running git-fsck should be
rare, very rare.

> - git-show-branch: what about mentioning gitk instead? i think it's much
>   more used - compared to git-show-branch

I would replace git-show-branch by git-show as command to see where
you are. and add gitk (which has now manpage) to view history.
git-show-branch output is a bit cryptic...

Perhaps we could add git-reflog / "git log -g" somewhere around?

> what do you think about this? maybe i'm wrong, but if i'm right, then i
> would provide a patch to update everyday.txt according to these
> suggestions.

I'd like this. At least the first one is unambiguous.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
