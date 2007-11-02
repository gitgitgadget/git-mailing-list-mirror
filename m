From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 2 Nov 2007 03:19:53 +0100
Message-ID: <20071102021953.GT18279@machine.or.cz>
References: <20071022063222.GS14735@spearce.org> <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com> <7v4pg5btis.fsf@gitster.siamese.dyndns.org> <200711012232.57286.johan@herland.net> <7v8x5hab3d.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011459490.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Geert Bosch <bosch@adacore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 03:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inm8p-0004aV-2J
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 03:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbXKBCT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 22:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbXKBCT4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 22:19:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41256 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbXKBCT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 22:19:56 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id D91A05A4A9; Fri,  2 Nov 2007 03:19:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0711011459490.3342@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63049>

On Thu, Nov 01, 2007 at 03:05:44PM -0700, Linus Torvalds wrote:
> On Thu, 1 Nov 2007, Junio C Hamano wrote:
> > 
> > "git clean" is about things that git usually do not care about
> > (i.e. things not in .gitignore, or even in .gitignore when -x is
> > given).  Everything else including "git stash" is all about what
> > git cares about (i.e. tracked paths).

BTW, it comes from Cogito. Pavel Roskin is the author of the original
Cogito script and I'm not sure if it came there from anywhere else or is
an original "invention".

> Right. I *love* "git clean". Real men have everything they care about 
> tracked by git, and thus by definition "git clean" is the safest operation 
> possible. I don't understand how anybody can call it "unsafe".

I agree! If you want to keep anything around in git-tracked tree, tell
git about it! (Either marking it as ignored or adding it to the index.)
I think I wasn't too fond of it originally but now tend to use it a lot
to keep my trees clean of temporary cruft.

> I just wish it was quiet by default - right now it takes a _loong_ time to 
> clean out your crud just because it scrolls forever talking about all 
> those girly files you don't want to keep - and that it had -x and -d on by 
> default, so that us *real* men wouldn't have to type so much.

I do not agree with either, though. Having it verbose by default makes
it at least obvious that something potentially, uh, surprising is going
on; and I _prefer_ the non-x behaviour. If I told git that it should
ignore $file, it better not touch it.

> But yeah, I guess we could make the "clean.Imagirlyman" option (or however 
> the "please-don't-hurt-me-by-default" option is spelled) the default. That 
> way I'd just feel *extra* manly for immediately disabling it, and laughing 
> at you wimps.

Yeah!

-- 
				Petr "Pasky, laughing at the wimps" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
