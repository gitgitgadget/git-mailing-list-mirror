From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 00:46:54 +0200
Message-ID: <4C4778DE.9090905@web.de>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 00:47:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obi47-0006ji-W0
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 00:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758943Ab0GUWq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 18:46:57 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57557 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab0GUWq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 18:46:56 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id A1DFF164B2A04;
	Thu, 22 Jul 2010 00:46:54 +0200 (CEST)
Received: from [80.128.113.183] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #4)
	id 1Obi3y-0004ev-00; Thu, 22 Jul 2010 00:46:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/ftzYvFOt4ywqmbZE3TMU0OxCThtqCHAEi8vMD
	Gub4j1jOd+YDNLHwYl1dH2BHNnJkelVJuYRbA41G6BFN6frbV/
	gaVU0Qne9HuJLrWh/UNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151431>

Am 21.07.2010 23:09, schrieb Avery Pennarun:
> What we *really* want is a way to have git actually recurse through
> commit objects when doing *any* operation, as if they were tree
> objects.

This would not be useful for every work flow (or to put it in other
words: this is not what I *really* want ;-). And as you pointed
out, that only works when you have a single repo you are working
against (like you do in your subtree model).

But unless I got something wrong (which might very well be the
case, as I never have used subtree myself), all changes to the
subtree will only show up in that single repo, unless you actively
push them somewhere else. And that, it seems to me, is as easy to
forget as you can right now forget to push a submodules commit you
already recorded and pushed in the superproject). So am I wrong
assuming that subtree is more focused on a single repo containing
all commits which /might/ then be shared, while submodules are
about /always/ sharing code via their own repo?


> There is no good solution to the submodule problem if each submodule
> has to go in its own repo.  I've been thinking about this for years
> now, and watching lots of discussions about it on the git mailing
> list, and I just can't see any other option.  All the submodules have
> to get pushed to and fetched from the same repo by default.  Anything
> else is insane.

I have to object here. Your insanity is someone else's work flow ;-)
And I am the last one not to admit that there are some severe
usability warts still to be fixed for submodules (I put up a - not
necessarily complete - list at
http://wiki.github.com/jlehmann/git-submod-enhancements/ ). And
myself and others are actively working on them (the next bigger
thing after a new config option about when to consider a submodule
modified are recursive checkouts, so that "git submodule update"
will hopefully be almost obsolete in the near future).
