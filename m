From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Clean way to disable pager
Date: Sun, 19 Aug 2007 11:52:06 -0700
Message-ID: <7vodh3bbmx.fsf@gitster.siamese.dyndns.org>
References: <vpq1wdz307k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 19 20:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMptD-0001Hg-8d
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 20:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbXHSSwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 14:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbXHSSwM
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 14:52:12 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbXHSSwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 14:52:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2604B12468A;
	Sun, 19 Aug 2007 14:52:30 -0400 (EDT)
In-Reply-To: <vpq1wdz307k.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sun,
	19 Aug 2007 19:26:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56137>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I think that deserves an less-hacky, and documented way. I'd suggest a
> --no-pager, or --dont-paginate, that would do the opposite of -p as a
> global option for git.

I think that is a good thing to do.

> From 2148c2564ca6480feaec9a9d091259032257918d Mon Sep 17 00:00:00 2001
> From: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date: Sun, 19 Aug 2007 19:24:36 +0200
> Subject: [PATCH] Add and document a global --no-pager option for git.
>
> To keep the change small, this is done by setting GIT_PAGER to "cat". I'd
> prefer not using global/environment variables for that, but it would
> require a complete refactoring of options handling in git.

And I do not necessarily think this GIT_PAGER thing is a bad way
to do so either.  It may end up spawning other commands (perhaps
via alias) and the use of environment is probably the way with
the least impact and complexity.

Please resend an applyable patch with a sign-off (and acked-by
as you have seen).
