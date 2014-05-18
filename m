From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sat, 17 May 2014 21:31:41 -0500
Message-ID: <53781b8df1b63_440ee792f80@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <537693aee4fdd_3e4812032fcc@nysa.notmuch>
 <20140517021117.GA29866@debian>
 <5376f27b74d9f_66768eb3048f@nysa.notmuch>
 <20140518012423.GA31087@debian>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 04:43:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlr4L-0008WC-K0
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 04:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbaERCmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 22:42:46 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33180 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaERCmp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 22:42:45 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so4708819obc.30
        for <git@vger.kernel.org>; Sat, 17 May 2014 19:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=QJvhVGmOn+0nm9feC6uEwXYx6v8u0UFOiGBhxVKJt5U=;
        b=OJZrhlT/rmOUSqqZXNY1ncWGqKVLkfgXiN9bPbCIK+WC5RuXZpsv07IvhSClGutncw
         UlPBBjbl+Rl/aoW0q8TW6AqdIU1AfGI9sbnPEdkzqigJZQ5763e9E6WKCxdBo6f0BzWY
         5FzyvikqIRzjwMIQa0UJibBgzY9cINAqs4x5IgDOfz0skvADg8mqtq+8XpavubMLMzuu
         GfNdjmmp0VfYrmtpy+6rZ3m6KwsSxVTXmW6kS7k6H4bAXMppR6z+iXxW2FypRvhvXjOG
         Vux6ezAJ1bczve9GH6DAjImkdvpe2r3LMcM1UG0HW/WiU2vWzZJc4gDRHTCHnMTUOmbs
         KufA==
X-Received: by 10.60.74.163 with SMTP id u3mr27559427oev.2.1400380965238;
        Sat, 17 May 2014 19:42:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dg2sm23800478obb.17.2014.05.17.19.42.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 May 2014 19:42:44 -0700 (PDT)
In-Reply-To: <20140518012423.GA31087@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249497>

James Denholm wrote:
> Felipe Contreras wrote:
> > James Denholm wrote:
> > > On Fri, May 16, 2014 at 05:39:42PM -0500, Felipe Contreras wrote:
> > > > (...) I would venture to say you have never made a package in your
> > > > life.
> > > 
> > > And you have, Felipe? Let us see the years of experience you surely have
> > > in the field.
> > 
> > As a matter of fact, yes I've written many packages, for Debian, Fedora,
> > ArchLinux, and others. Even Windows installers.
> 
> I'd hardly say that a few PKGBUILDs count. I've written some myself, not
> hard to do.

Not hard, but Junio clearly hasn't done so.

> That said, if I had realised you were going to discuss such a trivial
> thing - _making_ packages rather than _maintaining_ them in a repo - I'd
> have dismissed your statement as mere idiotic vitriol.

Why would anybody write packages and not maintain them? Of course I'm
talking about maintaining packages.

> Do you honestly think that Junio has _never made a package?_ Never, on
> any of the systems he's ever touched, run makepkg or debuild or
> whathaveyou?

I didn't say _build_ a package, I said _write_ a package. And of course
I mean a significant package, that other people use, and as such needs
to have some maintenance.

> I could be wrong here, but I'm fairly sure that Junio is a *nix software
> developer of some kind or another. You know, given that he's the
> maintainer of git, kinda might be the case. And I really doubt that any
> *nix dev, _anywhere_, could have _any_ sort of success without looking
> sideways once or twice at a package builder, given that pre-release
> homebrewing of expected packages is only an absolutely critical part of
> testing.
> 
> Come on, man. Don't be silly.

You are the one being silly, looking at a package builder doesn't give
you any insight about the way packaging is done in distributions. If
Junio has or hasn't done so is totally unimportant.

You are just talking about completely irrelevant stuff, so I'm going to
ignore your points about the matter.

> > But that's a red herring. Even if was the worst packager in history,
> > that doesn't make Junio's decision any more correct.
> 
> No, but it would render your bizarre, tantrum-like accusations as
> generally baseless. I mean, I don't think anyone actually puts weight on
> them anyway, but hey, never hurts to shine a spotlight on nonsense.
> 
> > > > The fact that you think packagers of git would simply package
> > > > git-remote-hg/bzr as well is pretty appalling.
> > > 
> > > It's not an outlandish thought, in fact, I'd suggest it as probable -
> > > provided that they find the projects to be stable and of high quality.
> > 
> > Do you want to bet?
> 
> Not a betting man. However, ignoring that for a moment, I doubt we'd be
> able to agree on checks and balances for the case where
> git-remote-hg/bzr were rejected due to the code being of poor quality or
> unstable. So no, I won't bet, because you hold your own work and
> opinions as sacrosanct and infallible.

It is not poor quality or unstable, Junio said so himself when he
graduated them to the core.

I suppose you don't trust Junio's opinion either.

> > > You, or someone else, might have to tap them on the shoulder and play
> > > nice to _ensure_ they know about them (after all, we all know that
> > > packagers _never_ read READMEs, do they), but you're capable of that,
> > > I'm sure.
> > 
> > In my experience packagers scratch their own itches, and if
> > git-remote-hg/bzr are not their itch, I don't see why any amount of
> > nice poking would make them package them. Some other packager would have
> > to do it, not the Git packagers.
> 
> If there's a demand, Felipe, and the build process is sane, I can't see
> why they wouldn't.

Your failure of foresight doesn't change what will actually happen in
the future.

Moreover, your argument that follows is a straw man, I argued that the
original maintainer of the "git" package wouldn't do the "git-remote-hg"
package, you didn't address that at all.

-- 
Felipe Contreras
