From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 21:06:44 -0800
Message-ID: <7vprw7y6mz.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	<7v3at42avd.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	<7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
	<7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
	<20080112045231.GB5211@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 06:07:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDYaj-0004aF-0d
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 06:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbYALFHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 00:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbYALFHF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 00:07:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbYALFHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 00:07:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D7D43B9;
	Sat, 12 Jan 2008 00:06:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 79AD643B8;
	Sat, 12 Jan 2008 00:06:53 -0500 (EST)
In-Reply-To: <20080112045231.GB5211@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 11 Jan 2008 23:52:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70265>

Jeff King <peff@peff.net> writes:

> This is obviously not 1.5.4 material, so I haven't given it that much
> thought either. But perhaps Stephen's "author message" should simply
> trigger any time the author is pulled from gecos? I suppose that would
> annoy people who use this feature all the time, but they can silence the
> "warning" with a simple git-config.

Well, we could certainly do that.

But I am not entirely happy with the idea of having to make the
default silly and inconvenient, only because otherwise new
people who did not even bother to read and follow the VERY FIRST
subsection of the tutorial that tells them that the first thing
to do is to use user.name and user.email would not notice their
problems, and experts know enough to squelch that broken
default.  Middle level people (and newbies will quickly become
one of them) will be inconvenienced even though they followed
the tutorial's instruction, until they find the configuration
variable to turn that silly AUTHOR output off.
