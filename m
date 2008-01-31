From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 02:38:37 -0800
Message-ID: <7vbq72cmaa.fsf@gitster.siamese.dyndns.org>
References: <47A1948F.6080308@viscovery.net>
	<20080131100625.GB25546@coredump.intra.peff.net>
	<20080131102716.GC25546@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:39:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWpJ-0006lo-Ag
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbYAaKiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933209AbYAaKiw
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:38:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676AbYAaKiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:38:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA79D3C35;
	Thu, 31 Jan 2008 05:38:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 58E1D3C32;
	Thu, 31 Jan 2008 05:38:44 -0500 (EST)
In-Reply-To: <20080131102716.GC25546@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 31 Jan 2008 05:27:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72122>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 31, 2008 at 05:06:25AM -0500, Jeff King wrote:
>
>> But getting back to your point: yes, I agree it is a little ugly.
>> Rewriting find_unique_abbrev would be necessary for fixing it, and I'm
>> not sure it is worth the trouble.
>
> Actually, it looks like we already handle a similar case: the null sha1,
> so the change isn't that big (and the null sha1 case folds nicely into
> the "missing" case).

Heh, "Make sure to abbreviate something that does not match" ---
I forgot about that trick I did looooooooong time ago ;-).

I like the idea.  Does it not break anything?
