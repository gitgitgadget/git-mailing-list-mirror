From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: deprecate using "" as boolean value false.
Date: Mon, 11 Feb 2008 00:21:26 -0800
Message-ID: <7vskzzaoop.fsf@gitster.siamese.dyndns.org>
References: <20080211082216.e9212310.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 09:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOTvk-0007Jb-Gi
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 09:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbYBKIVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 03:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYBKIVt
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 03:21:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYBKIVt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 03:21:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A97C74F82;
	Mon, 11 Feb 2008 03:21:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C334EFF;
	Mon, 11 Feb 2008 03:21:34 -0500 (EST)
In-Reply-To: <20080211082216.e9212310.chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 11 Feb 2008 08:22:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73482>

Why do you call this a "fix", when the only effect of it is
breaking people's existing setups?  Wouldn't a set of proper
fixes to the config parsing callback functions solve all the
issues without having any downsides?

I think you are wasting both of our times.  You could be doing
the real fix instead.  Or I could be spending time on it,
instead of repeating to you how mistaken this approach is.

So far I've seen and queued only two usable fixes since that
[Janitor] request.  Maybe I should have ignored all this
discussion in this thread and spent my time on doing the
Janitorial work.  The reason I joined the thread was that I
hoped that I could save people like _you_ from wasting _your_
time in the discussion, instead of making better use of it by
doing audits and fixes.

Grrr.
