From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking branch for a rebase
Date: Wed, 09 Sep 2009 23:42:16 -0700
Message-ID: <7vzl93cncn.fsf@alter.siamese.dyndns.org>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
 <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
 <20090907084324.GB17997@coredump.intra.peff.net>
 <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
 <20090909104550.GA20108@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 08:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MldMf-0004u0-U4
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 08:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbZIJGmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 02:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbZIJGmb
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 02:42:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbZIJGmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 02:42:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ABCC2D055;
	Thu, 10 Sep 2009 02:42:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8S2cdATKkc2BTyZLT5bxW9jHeCQ=; b=WThf1a
	KM0q8RbWcb+v9GmHg9+eYQoNkjbg5k39JWFrkrjpNo7SOu94EJ/nbEDlKnjY5bVI
	7kggFEO6Y8ju2GI3GowAqR20W/19OJP3jYiu/ttyZckdcndZy0IsopiKapKwtVIr
	5Q/uZGkwABiyr+oOu/sRKpR890pRo5S/IJqMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NCR7I6EH+9PHD9uxKUk6k3fOspaBCIAc
	UCLRFNWhEc0TYahYDVFUi4WEM+wRfKycGXCqc6CH4EGoox8oIhknZxJmrZ+ZVZxv
	FLmav92idBe4S4afJRdu5rPma3vv7xoigsdcjlxZV6Hpcbb2EW7pMFoAgPyUnZML
	GXnOGI7o5f8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E35D2D054;
	Thu, 10 Sep 2009 02:42:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F33AD2D049; Thu, 10 Sep
 2009 02:42:17 -0400 (EDT)
In-Reply-To: <20090909104550.GA20108@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 9 Sep 2009 06\:45\:50 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 19A50796-9DD5-11DE-9AFC-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128097>

Jeff King <peff@peff.net> writes:

> I wonder if it is worth adding @{upstream} now, which is fairly safe,
> letting it cook for a while, and then adding a "%" alias later after the
> concept has proved itself (and people say "I like this feature, but it
> really is too much to type").

That's a sane suggestion, I think.  We can always have a descriptive
longhand (e.g. "branch@{upstream}") and later add a shorthand for often
used ones (e.g. "branch^up", "branch/.up" --- the former is possible
because it cannot be upth parent of the commit at the tip of the branch,
and the latter is possible because component of hierarchical refname
cannot begin with a dot).

I find a prefix % not descriptive enough (besides being ugly); if it were
"^branch", as some people said, it would probably have matched its meaning
"up", but that notation is already taken for "uninteresting".  If we are
going to use funny symbol as a notation to invoke magic, I think it is
easier for new people if we limit the number of symbols used.  We already
have ^n, ^{type} and ~n magic, all of which operate on objects and peel
them in three different ways.

Then there currently is only one kind of magic that works on refs and it
is spelled as ref@{magic}.  Let's try not to introduce more notation
before it is absolutely necessary.

When I say there is only one kind of magic notation for refs, I am
primarily talking about the end-user perception.  @{time}, @{number} and
@{-number} all do their magic using the reflog, but that is about _how_
they do what they do.  End-user perception begins with _what_ they do, and
at that level, the magic consistently works on refs and different genie is
summoned depending on what is inside {}.

The @{upstream} thing won't be using reflog to do its job, but that is
about _how_ it is implemented, and the end users don't care.

What is more important is _what_ it does.  Given a ref, the @{} magic
notation finds something that is related to the ref.  @{time} and
@{number} finds what the ref itself used to point at. @{-number}
(applicable only to HEAD ref) finds the ref it used to point at.  And
@{upstream} will find another ref that it merges from (or rebases onto).
