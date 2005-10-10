From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: Notes and questions while reading the documentation
Date: Mon, 10 Oct 2005 23:22:35 +0200
Message-ID: <1128979355.7097.33.camel@localhost>
References: <1128549966.11363.29.camel@localhost>
	 <7v1x2zfsp2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 23:26:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP57d-0006sP-MX
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVJJVXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVJJVXq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:23:46 -0400
Received: from a15181680.alturo-server.de ([217.160.108.75]:34505 "EHLO
	a15181680.alturo-server.de") by vger.kernel.org with ESMTP
	id S1751254AbVJJVXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 17:23:46 -0400
Received: from p54a21cce.dip0.t-ipconnect.de ([84.162.28.206] helo=localhost)
	by a15181680.alturo-server.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.52)
	id 1EP57Q-000615-AB; Mon, 10 Oct 2005 23:23:36 +0200
Received: from chris by localhost with local (Exim 4.52)
	id 1EP56R-000267-Mh; Mon, 10 Oct 2005 23:22:35 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x2zfsp2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9938>

Sorry for being slow.

On Wed, 2005-10-05 at 16:30 -0700, Junio C Hamano wrote:
> Christian Meder <chris@absolutegiganten.org> writes:
> 
> > * a lot of the manpages include something like "v0.1, June 2005" in the
> > header; these versions tags are pretty obscure to interpret, timestamp
> > when last edited ? version of the manpage ? version of git when the
> > manpage was included ? maturity the author assigned to the content ?
> > If these tags don't follow some sane schema they should be removed.
> 
> I think the original intent was the last modification datestamp
> and the version of the documentation, but I agree it should be
> removed.  I do not think they show on the HTML version, nor man
> pages, although I have to admit that I haven't looked at
> generated manpages for some time.

Ok. I've done a patch to remove them in a separate email.

> > * the usage of git, Git and GIT isn't consistent in the documentation.
> > I'd vote for only using git.
> 
> Sounds sane.  What would we do if we need to start sentences with it?

I prepared a patch which changes all usages to git even at the beginning
of sentences.  

> > * git-clone says that http transport is not supported yet I used it to
> > clone the git repo from kernel.org yesterday. Should the documentation
> > get updated ?
> 
> Thanks for noticing.  Yes, now HTTP can handle both of the
> trickier setups (packed, and alternates); credit goes to Daniel.

I noted it down for my second sweep.

> > * the manpage synopsises aren't consistent wrt command naming; it's "git
> > commit" but "git-branch"; I guess all the manpages should reference
> > their commands as "git-x" and not "git x"
> 
> Agreed.
> 

Ok. Patch in separate email.


				Christian

-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)
