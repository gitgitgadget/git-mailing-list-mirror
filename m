From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add tests for git log --pretty, --format and --oneline.
Date: Wed, 25 Feb 2009 04:57:41 -0500
Message-ID: <20090225095741.GB16357@coredump.intra.peff.net>
References: <7vljrvhh13.fsf@gitster.siamese.dyndns.org> <1235509597-18336-1-git-send-email-felipe.contreras@gmail.com> <7vtz6i4zah.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGYH-0003j2-Cv
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762019AbZBYJ5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762014AbZBYJ5r
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:57:47 -0500
Received: from peff.net ([208.65.91.99]:45459 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760621AbZBYJ5q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:57:46 -0500
Received: (qmail 25353 invoked by uid 107); 25 Feb 2009 09:58:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Feb 2009 04:58:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2009 04:57:41 -0500
Content-Disposition: inline
In-Reply-To: <7vtz6i4zah.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111432>

On Wed, Feb 25, 2009 at 01:54:30AM -0800, Junio C Hamano wrote:

> Because 4202 seems to be about testing the log functionality and they rely
> on correctly working format output to verify other aspects of the
> operation of "git log", I initially was not sure if this is the right
> place to add these new tests.  After looking around I didn't find any
> existing test that checks the various --pretty output formats that the new
> tests can be added, so this probably is as good a place as any.

t6006?

-Peff
