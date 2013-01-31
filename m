From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 17:33:05 -0500
Message-ID: <20130131223305.GB21729@sigill.intra.peff.net>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12hH-0003ff-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964Ab3AaWdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:33:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54971 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326Ab3AaWdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:33:08 -0500
Received: (qmail 15580 invoked by uid 107); 31 Jan 2013 22:34:32 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 17:34:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 17:33:05 -0500
Content-Disposition: inline
In-Reply-To: <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215178>

On Thu, Jan 31, 2013 at 09:59:50PM +0000, John Keeping wrote:

> When looking up a topic via "git help <topic>", git-help prepends "git-"
> to topics that are the names of commands (either builtin or found on the
> path) and "git" (no hyphen) to any other topic name.
> 
> "git-remote-helpers" is not the name of a command, so "git help
> remote-helpers" looks for "gitremote-helpers" and does not find it.
> 
> Fix this by renaming "git-remote-helpers.txt" to
> "gitremote-helpers.txt".

Maybe it is just me, but the fact that accessing the manpage is now:

  man gitremote-helpers

feels weird to me. I know it technically follows our syntactic rules,
but having the lack of dash be significant between "git" and "remote",
but then having a dash later makes it hard on the eyes.

Would it make more sense to just call it "gitremotehelpers", and then
access it as:

  git help remotehelpers

or

  man gitremotehelpers

?

That has it its own ugliness (two words run together), but at least my
version of man will accept arbitrary capitalization, allowing:

  git help remoteHelpers

and

  man gitremoteHelpers

I dunno.

-Peff
