From: Ted Ts'o <tytso@mit.edu>
Subject: Minimum git commit abbrev length (Was Re: -tip: origin tree build
 failure (was: [GIT PULL] ext4 update) for 2.6.37)
Date: Thu, 28 Oct 2010 13:27:25 -0400
Message-ID: <20101028172725.GA6814@thunk.org>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop>
 <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <20101028171701.GA18368@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Oct 28 19:27:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBWGa-0007v8-1u
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 19:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934009Ab0J1R1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 13:27:32 -0400
Received: from thunk.org ([69.25.196.29]:37155 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933260Ab0J1R1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 13:27:30 -0400
Received: from root (helo=tytso-glaptop)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1PBWG6-0005Jo-FT; Thu, 28 Oct 2010 13:27:26 -0400
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1PBWG5-0002Rd-J4; Thu, 28 Oct 2010 13:27:25 -0400
Mail-Followup-To: Ted Ts'o <tytso@mit.edu>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20101028171701.GA18368@elte.hu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160189>

On Thu, Oct 28, 2010 at 07:17:01PM +0200, Ingo Molnar wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Yes. Except for the kernel the default git commit abbreviation is
> > borderline too short. Seven hex-chars can easily alias with a few
> > more pulls from me: git will not give aliases at the time it gives
> > a shorthand, but a month or two later the abbreviated commit may
> > no longer be unique.
> > 
> > So I suggest using --abbrev=12 or similar.
> 
> ok. A helper script i use does this:
> 
>    git log --pretty=format:"%h: %s" $@
> 
> I have added --abbrev=12. Might make sense to lengthen the %h
> default in upstream Git as well?

Maybe the right thing to do is add a git config option which allows
for a configurable minimum git commit abbreviation length?

      		   	       	      - Ted
