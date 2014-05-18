From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sun, 18 May 2014 01:24:23 +0000
Message-ID: <20140518012423.GA31087@debian>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <537693aee4fdd_3e4812032fcc@nysa.notmuch>
 <20140517021117.GA29866@debian>
 <5376f27b74d9f_66768eb3048f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 03:24:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlpq9-0004dS-MK
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 03:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbaERBY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 21:24:28 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:52265 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbaERBY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 21:24:27 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so6506432wgg.30
        for <git@vger.kernel.org>; Sat, 17 May 2014 18:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oX0sAcyIBDiBOpyF21XAhUsKCngXUxHVD7clUv4lNhM=;
        b=fQJcYp0fS5L/Yzu1E7O+W8PBsD1zsHrmORaubuImzSYKAHxzwwNa8zqToLuQpBxDEp
         CjDcCy5HlBoqi3kq7zFpmuvkW8LmkkIwRn+cnN9y3K9wgLdswTYXX2ssreT23wtxBi1j
         wNPe/UzxlHJEvi4/RPKrCT4XhOH1s0617FFwzgBkaRrulUnrJtRJCgnIDot+g4c/EtxP
         jxYLGP1YbaN2EaFF7mHsE/ovsO16SGxYa2PWIYF+zDMF4tZvBPUVTd/4doW4+uQJqEab
         XffU4SNrrAd1XLe30Z+bWYI/Tv+ed4L45gWrhZmI0DkUr764OPQKKFT4bgpPpmEuyzni
         aO1w==
X-Received: by 10.194.246.234 with SMTP id xz10mr553866wjc.77.1400376266008;
        Sat, 17 May 2014 18:24:26 -0700 (PDT)
Received: from debian ([2a04:1980:3100:1aac:21b:21ff:feda:4cbe])
        by mx.google.com with ESMTPSA id em5sm6556336wic.23.2014.05.17.18.24.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 17 May 2014 18:24:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5376f27b74d9f_66768eb3048f@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249496>

Felipe Contreras wrote:
> James Denholm wrote:
> > On Fri, May 16, 2014 at 05:39:42PM -0500, Felipe Contreras wrote:
> > > (...) I would venture to say you have never made a package in your
> > > life.
> > 
> > And you have, Felipe? Let us see the years of experience you surely have
> > in the field.
> 
> As a matter of fact, yes I've written many packages, for Debian, Fedora,
> ArchLinux, and others. Even Windows installers.

I'd hardly say that a few PKGBUILDs count. I've written some myself, not
hard to do.

That said, if I had realised you were going to discuss such a trivial
thing - _making_ packages rather than _maintaining_ them in a repo - I'd
have dismissed your statement as mere idiotic vitriol.

Do you honestly think that Junio has _never made a package?_ Never, on
any of the systems he's ever touched, run makepkg or debuild or
whathaveyou?

I could be wrong here, but I'm fairly sure that Junio is a *nix software
developer of some kind or another. You know, given that he's the
maintainer of git, kinda might be the case. And I really doubt that any
*nix dev, _anywhere_, could have _any_ sort of success without looking
sideways once or twice at a package builder, given that pre-release
homebrewing of expected packages is only an absolutely critical part of
testing.

Come on, man. Don't be silly.

> But that's a red herring. Even if was the worst packager in history,
> that doesn't make Junio's decision any more correct.

No, but it would render your bizarre, tantrum-like accusations as
generally baseless. I mean, I don't think anyone actually puts weight on
them anyway, but hey, never hurts to shine a spotlight on nonsense.

> > > The fact that you think packagers of git would simply package
> > > git-remote-hg/bzr as well is pretty appalling.
> > 
> > It's not an outlandish thought, in fact, I'd suggest it as probable -
> > provided that they find the projects to be stable and of high quality.
> 
> Do you want to bet?

Not a betting man. However, ignoring that for a moment, I doubt we'd be
able to agree on checks and balances for the case where
git-remote-hg/bzr were rejected due to the code being of poor quality or
unstable. So no, I won't bet, because you hold your own work and
opinions as sacrosanct and infallible.

> > You, or someone else, might have to tap them on the shoulder and play
> > nice to _ensure_ they know about them (after all, we all know that
> > packagers _never_ read READMEs, do they), but you're capable of that,
> > I'm sure.
> 
> In my experience packagers scratch their own itches, and if
> git-remote-hg/bzr are not their itch, I don't see why any amount of
> nice poking would make them package them. Some other packager would have
> to do it, not the Git packagers.

If there's a demand, Felipe, and the build process is sane, I can't see
why they wouldn't. Package maintainers are aware they provide a service
to their distributions. If you really want, poke them _with_ the
majority of the necessary work done, hand them the
PKGBUILDs/whathaveyou yourself. Pre-scratch the itch if you really feel
they won't care.
