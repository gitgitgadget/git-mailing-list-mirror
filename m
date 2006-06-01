From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svnimport: Improved detection of merges.
Date: Thu, 1 Jun 2006 02:22:39 -0700
Message-ID: <20060601092238.GB9333@hand.yhbt.net>
References: <11490715283626-git-send-email-octo@verplant.org> <7vlkshs618.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Thu Jun 01 11:22:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FljO8-0004C3-Ae
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 11:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWFAJWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 05:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWFAJWk
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 05:22:40 -0400
Received: from hand.yhbt.net ([66.150.188.102]:32717 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932146AbWFAJWj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 05:22:39 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 494AE7DC005; Thu,  1 Jun 2006 02:22:39 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkshs618.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21108>

Junio C Hamano <junkio@cox.net> wrote:
> Florian Forster <octo@verplant.org> writes:
> 
> > The regexes detecting merges (while still relying on the commit messages,
> > though) have been improved to catch saner (and hopefully more) messages. The
> > old regex was so generic that it often matched something else and missed the
> > actual merge-message.
> 
> > Also, the regex given with the `-M' commandline-option is checked first:
> > Explicitely given regexes should be considered better than the builtin ones,
> > and should therefore be given a chance to match a message first.
> 
> The latter part sounds immensely sane.  The former I am not a
> good judge, since I do not interact with subversion repositories
> myself.  Opinions from real svn users?

Sounds sane to me, but I've not seen the patch from Florian.

I've been toying around a bit with enhanced branch/merge-tracking
support in git-svn, too.

> 
> BTW, did anybody received the latest "What's in git.git" I sent
> out about 20 minutes ago?

Nope, I haven't seen that nor Florian's patch (assuming it was sent to
the ml).  Ah, I just saw (part #2) pop up.

-- 
Eric Wong
