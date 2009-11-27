From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 01:20:13 -0500
Message-ID: <20091127062013.GA20844@coredump.intra.peff.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 07:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDuBo-0003gS-An
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 07:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbZK0GUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 01:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZK0GUH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 01:20:07 -0500
Received: from peff.net ([208.65.91.99]:43764 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbZK0GUG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 01:20:06 -0500
Received: (qmail 24922 invoked by uid 107); 27 Nov 2009 06:24:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 01:24:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 01:20:13 -0500
Content-Disposition: inline
In-Reply-To: <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133858>

On Thu, Nov 26, 2009 at 10:56:55AM -0700, James Pickens wrote:

> On Wed, Nov 25, 2009 at 3:20 PM, Jeff King <peff@peff.net> wrote:
> > Sure, there are all those downsides. But what is the other option?
> > Making me use the command line option (or pathspec magic) every single
> > time I invoke git grep?
> 
> Yes, but only when you want non-default behavior, not every single time.

Did you miss the part of the thread where I explained that in certain
repos, I want it one way every single time, and in others, I want it the
other way?

So yes, in certain repos, it really is every single time.

> > That is a huge downside to me.
> 
> Is it *really*?  Does it also bother you that you have to tell standalone
> unix commands like diff and grep what you want them to diff or grep every
> single time you invoke them?

This is a strawman. I am not saying every command-line option should be
made into a configuration option. I am saying that some options,
including this one, would be useful as configuration options. I have
already explained several times in this thread exactly what
characteristics of this option make that so.

And please, questions like "Is it *really*?" don't add anything. Yes,
really, or I wouldn't be having this discussion. This behavior has
bitten me many times while using "git grep". I'm not making it up. Maybe
I am the only one in the world, but I don't see how it makes any sense
to argue that I am not actually annoyed by it.

> I really think that this config option wouldn't even help you, because
> you'll have to remember what that option is set to in each working repo,
> and type the right command based on the setting.  That seems worse than

No, the _point_ is that I don't have to remember the right command in
each repo. I can set it up for the workflow that matches that repository
and then issue "git grep" without remembering which type I'm in.

> If you can get the behavior you want using an alias or a script, then I
> suggest you do that.  I don't think this config option should be considered
> unless *many* people want it, and so far I count only 1.

Perhaps I am the only one who wants to use the config option per-repo.
But we have already seen support for both behaviors, which means there
are people who will be dissatisfied with either simply leaving the
default or changing the default. And I don't want to speak for Junio,
but he seemed to agree that what you most want would depend on the repo
organization (though I think he may disagree that it is important enough
to merit the hassle of a config option).

-Peff
