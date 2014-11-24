From: Daniel Hagerty <hag@linnaean.org>
Subject: Re: git merge a b when a == b but neither == o is always a successful merge?
Date: Mon, 24 Nov 2014 14:36:02 -0500
Message-ID: <21619.34978.293406.32338@perdition.linnaean.org>
References: <21610.16623.746985.383838@perdition.linnaean.org>
	<20141117205304.GA15880@peff.net>
	<21610.29903.366230.851787@perdition.linnaean.org>
	<20141121181539.GC26650@peff.net>
	<xmqqwq6oz8sv.fsf@gitster.dls.corp.google.com>
Reply-To: Daniel Hagerty <hag@linnaean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 20:36:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XszQf-0004ao-HY
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 20:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbaKXTgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 14:36:05 -0500
Received: from perdition.linnaean.org ([173.166.106.33]:54696 "EHLO
	perdition.linnaean.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaKXTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 14:36:04 -0500
Received: by perdition.linnaean.org (Postfix, from userid 31013)
	id 56647FE8; Mon, 24 Nov 2014 14:36:02 -0500 (EST)
In-Reply-To: <xmqqwq6oz8sv.fsf@gitster.dls.corp.google.com>
X-Mailer: VM 7.19 under Emacs 23.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260140>

 > I agree that the approach taken here is a sensible way to implement
 > the design, _if_ the design and the problem it tries to solve makes
 > sense.  I am not sure about that yet myself, though.

    This is a "first things first".

    What aspect of the problem to be solved is in question?

    From here, it seems obvious that there is textual data where the
 supression of sha1 identical files as non-conflicting isn't always
 proper.  I'm somewhat doubtful that the workflow design is really the
 problem -- I either have to remove a required feature of the broader
 design, or I have to move the problem somewhere else that isn't as
 well suited to handle it.  git seems the right tool for the job, but
 for the parameterization of merge.

    I'd be happy for some route that doesn't involve changing upstream
git, but it doesn't sound like that exists.

    Thanks!
