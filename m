From: Junio C Hamano <gitster@pobox.com>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 21:23:09 -0700
Message-ID: <7v7imp539u.fsf@gitster.siamese.dyndns.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<Pine.LNX.4.64.0709152310380.28586@racer.site>
	<Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
	<7vwsur590q.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm>
	<7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161541330.24221@asgard.lang.hm>
	<7vk5qq3y76.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161925000.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Sep 17 06:23:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX890-0002kN-Gm
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 06:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbXIQEX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 00:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbXIQEX1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 00:23:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbXIQEX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 00:23:26 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 43DB4134D89;
	Mon, 17 Sep 2007 00:23:37 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709161925000.24221@asgard.lang.hm>
	(david@lang.hm's message of "Sun, 16 Sep 2007 19:31:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58383>

david@lang.hm writes:

>> Post-checkout trigger is something I can say I can live with
>> without looking at the actual patch, but that does not mean it
>> would be a better approach at all.
>
> we agree on this much at least :-)
>
>> I would not be able to answer the first question right now; that
>> needs a patch to prove that it can be done with a well contained
>> set of changes that results in a maintainable code.
>
> you cannot answer the question in the affirmitive, but you could say
> that any changes in that area would be completely unacceptable to you
> (and for a while it sounded like you were saying exactly that). in
> which case any effort put into preparing patches would be a waste of
> time

I tend to disagree.  It's far from a waste of time.  While, as I
said, I am skeptical that such a patch would be small impact, if
it helps people's needs, somebody will pick it up and carry
forward, even if that somebody is not me.  It can then mature
out of tree and later could be merged.  We simply do not know
unless somebody tries.  And I am quite happy that you seem to be
motivated enough to see how it goes.

On the other hand, the experiment could fail and you may end up
with a patch that is too messy to be acceptable, in which case
you might feel it a waste of time, but I do not think it is a
waste even in such a case.  We would learn what works and what
doesn't, and we can bury "keeping track of /etc" topic to rest.

I also need to rant here a bit.

Fortunately we haven't had this problem too many times on this
list, but sometimes people say "Here is my patch.  If this is
accepted I'll add documentation and tests".  I rarely reply to
such patches without sugarcoating my response, but my internal
reaction is, "Don't you, as the person who proposes that change,
believe in your patch deeply enough to be willing to perfect it,
in order to make it suitable for consumption by the general
public, whether it is included in my tree or not?  A change that
even you do not believe in yourself has very little chance of
benefitting the general public, so thanks but no thanks, I'll
pass."
