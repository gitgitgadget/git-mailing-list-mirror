From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading 
 mbox message
Date: Sat, 14 Feb 2009 00:16:02 -0800
Message-ID: <7v63jdxwl9.fsf@gitster.siamese.dyndns.org>
References: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
 <20090214003113.GB7769@coredump.intra.peff.net>
 <76718490902131642y62b81bfat129cfbeda7957ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Ryan Anderson <ryan@michonline.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 09:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYFjk-0008Qe-Qd
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 09:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbZBNIQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 03:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbZBNIQL
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 03:16:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbZBNIQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 03:16:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D38C92B195;
	Sat, 14 Feb 2009 03:16:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CCC182B191; Sat,
 14 Feb 2009 03:16:03 -0500 (EST)
In-Reply-To: <76718490902131642y62b81bfat129cfbeda7957ff8@mail.gmail.com>
 (Jay Soffian's message of "Fri, 13 Feb 2009 19:42:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBB522BE-FA6F-11DD-8878-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109843>

Jay Soffian <jaysoffian@gmail.com> writes:

> It goes like this:
>
> Me: Notice wart
> Me: Cut wart off (i.e. submit patch)
> Reviewer: Sorry, you didn't cut that wart off to my standards, unless
> you can do it better, I'd rather have the wart.
>
> I dunno, maybe I'm too sensitive and don't have the fortitude for
> contributing to git.

Different people have different priorities and judging criteria.

To some authors, code is the only thing that matters and they say a crappy
commit log message is Ok if the code works.  I actually do not even read
the patch if the commit log message does not clearly express what problem
the author is trying to address, because I always have other patches to
attend to, and if the author cannot formulate his thought clearly in the
commit log message, it is likely that the code doesn't, either, and even
if it does, the code speaks only about how it does what it does, and not
much about _why_ it is so, which is the most important thing down the
road.

Some people comment more on readability of the patch and format of the
code while some others let them pass and concentrate on performance and
correctness.

All of them are important, and reviewers, together with the original
author, complement each other's weakness to work toward a better system.

The first thing to learn is to tell the difference between "you didn't cut
that wart off to my standards, unless you can do it better, I'd rather
have the wart." and "you claim you have cut the wart off, but that's minor
compared to the wart you are missing here which can be cut at the same
time without too much effort; let's do so at the same time before we all
forget".

The review comments I read on this list are more often the latter, but I
can certainly understand some authors, being so excited about and fond of
his own creation, mistake it as the former.  Two tricks I learned to avoid
that trap while working on git, and especially when git was still young
and I was a contributor, was to sleep on things, and to always consider
the possibility that I _might_ be wrong.  The latter takes some practice,
and I admit I still haven't mastered it yet, but I am trying.
