From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-seek should not complain if run twice
Date: Mon, 16 Jan 2006 00:59:19 +0100
Message-ID: <20060115235919.GF28365@pasky.or.cz>
References: <1135054536.3815.14.camel@dv> <20060114233037.GA28365@pasky.or.cz> <20060115010335.dj4swocs000k008o@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 00:58:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyHlP-0006bg-FR
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 00:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWAOX6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 18:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWAOX6U
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 18:58:20 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33178 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751002AbWAOX6U (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 18:58:20 -0500
Received: (qmail 12432 invoked by uid 2001); 16 Jan 2006 00:59:19 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <20060115010335.dj4swocs000k008o@webmail.spamcop.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14716>

  Hello,

Dear diary, on Sun, Jan 15, 2006 at 07:03:35AM CET, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> Quoting Petr Baudis <pasky@suse.cz>:
> 
> > It seems cleaner to just make cg-seek fail with a sensible error message
> > if it's already unseeked.
> 
> I don't like this.  What if "cvs up -A" would fail if run twice?  What if
> cg-clean would fail if there was nothing to clean?  What if sync would fail if
> it didn't cause a single disk write?  Idempotent operations are easier to work
> with.  Please see http://en.wikipedia.org/wiki/Idempotent_(software)
> 
> I could make an exception for the case when the command invocation indicates
> that the user is unaware of something, and that it would endanger the user's
> data.  But it's not the case for cg-seek without arguments on non-seeked
> repository.  The intention is clear, and the knowledge of the current state of
> the repository doesn't matter, since there will be no merge or something.

  I have my reservations to this argumentation in the specific cg-seek
case, but it's very subjective, unclear, and I personally really don't
care. So let it be your way. ;-)

  Thanks for your opinion,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
