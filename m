From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Why do we need [PATCH]?
Date: Fri, 16 Dec 2005 22:42:31 +0100
Message-ID: <20051216214231.GA2903@mars.ravnborg.org>
References: <20051216210145.GA25311@mars.ravnborg.org> <7vpsnwenqy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 22:43:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnNKb-0004S6-08
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVLPVle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVLPVle
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:41:34 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:14371 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932486AbVLPVld
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:41:33 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id E948747FE77;
	Fri, 16 Dec 2005 22:41:32 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 487726AC32D; Fri, 16 Dec 2005 22:42:31 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsnwenqy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13758>

On Fri, Dec 16, 2005 at 01:27:33PM -0800, Junio C Hamano wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > I looked at the source and found the -k option, but adding [PATCH]
> > should not be default behaviour so this is not the correct solution.
> 
> The "correct" solution depends on where you come from.  That
> extra [PATCH] is a carryover from BK days, I was told by Linus,
> to make e-mailed things stand out --- I've never used BK but I
> am guessing that things were not as obvious as our commit
> messages, perhaps?
You can a typical bk commit here:
http://linus.bkbits.net:8080/linux-2.5/cset@1.2243?nav=index.html|ChangeSet@-9M

And here it made much more sense sine the author/comitter info are
less structured. Also we do nto have the Signed-off-by: stuff back then.

> We have "Author/Committer" distinction so
> the [PATCH] marker is redundant.
> 
> The rewrite, "git-am" does not bother with adding [PATCH], but
> the original "git-applymbox", being everyday Linus' tool, was
> left as it was, not to disrupt the workflow of Linus.

Thanks, I had forgotten the git-am rewrite.
I will use that in the future - if I remember.

	Sam
