From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 11:47:07 -0800
Message-ID: <7vabloizt0.fsf@gitster.siamese.dyndns.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
 <20080225183413.GA15131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:48:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjJU-0003vO-CE
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624AbYBYTrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756200AbYBYTrY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:47:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913AbYBYTrX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:47:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9795C2F28;
	Mon, 25 Feb 2008 14:47:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A3C892F23; Mon, 25 Feb 2008 14:47:14 -0500 (EST)
In-Reply-To: <20080225183413.GA15131@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Feb 2008 13:34:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75055>

Jeff King <peff@peff.net> writes:

> There was some discussion about this a while back for the kernel. Some
> relevant points that I recall:
>
>   - there's more than _one_ maintainer for the repo; in fact, who you
>     email depends on what part of the code you are touching
>
>   - this information could be shipped as part of the repo (i.e., under
>     version control like the rest of the project, as it changes with the
>     project)
>
>   - this information can potentially be inferred from git shortlog
>     and/or blame; this addresses the problem of data becoming stale
>
> See this thread:
>
>   http://mid.gmane.org/1187110824.32555.76.camel@localhost

That matches my recollection, but I think the most important
point to take home from these points are that you cannot blindly
say that the tool can figure it out and do that for you.  We
could probably have an automated way to scan shortlog and
whatnot and offer suggestions, but the final determination of
the recipient addresses needs to be done by the end user.

Which in short means README or Documentation/SubmittingPatches
would be the most appropriate place for that information.
