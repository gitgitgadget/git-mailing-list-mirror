From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename detection: Avoid repeated filespec population
Date: Wed, 21 Jan 2009 08:32:11 -0500
Message-ID: <20090121133211.GA20360@coredump.intra.peff.net>
References: <20090120155957.GA23237@atjola.homenet> <20090120212723.GA10967@coredump.intra.peff.net> <20090121125619.GA523@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 14:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPdDA-0008JU-2f
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 14:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbZAUNcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 08:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756299AbZAUNcO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 08:32:14 -0500
Received: from peff.net ([208.65.91.99]:34990 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbZAUNcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 08:32:14 -0500
Received: (qmail 14438 invoked by uid 107); 21 Jan 2009 13:32:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 08:32:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 08:32:11 -0500
Content-Disposition: inline
In-Reply-To: <20090121125619.GA523@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106604>

On Wed, Jan 21, 2009 at 01:56:19PM +0100, Bj=C3=B6rn Steinbrink wrote:

> Another possible solution would be to free the blob data only after t=
he
> loop in diffcore_rename has finished, but that's obviously quite bad =
WRT
> memory consumption.  :-)

Yeah, and it doesn't have the (admittedly smaller, but still there)
optimization of not loading the blob data at all if we will never need
to.

> Anyway, too late, yesterday's attempts 6 to 10 at writing a better
> commit message didn't work out either, and Junio has applied the patc=
h
> by now.

I think that's fine. My message was more about convincing myself that
your change was the right thing (and hopefully helped convince others,
too).

-Peff
