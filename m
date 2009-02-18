From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Wed, 18 Feb 2009 01:41:21 -0500
Message-ID: <20090218064121.GA16611@coredump.intra.peff.net>
References: <200902142056.42198.trast@student.ethz.ch> <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org> <200902151711.45099.trast@student.ethz.ch> <20090215181818.GA2291@coredump.intra.peff.net> <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com> <20090217163413.GB31297@sigill.intra.peff.net> <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com> <20090217202731.GA16586@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 07:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZg9C-0000ZO-Jo
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 07:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbZBRGlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 01:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbZBRGlY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 01:41:24 -0500
Received: from peff.net ([208.65.91.99]:40905 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbZBRGlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 01:41:23 -0500
Received: (qmail 11511 invoked by uid 107); 18 Feb 2009 06:41:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 01:41:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 01:41:21 -0500
Content-Disposition: inline
In-Reply-To: <20090217202731.GA16586@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110509>

On Tue, Feb 17, 2009 at 03:27:31PM -0500, Jeff King wrote:

> But this is just unproductive complaining to do it on the git list (I'm
> just amazed at how frequently it is segfaulting). I'll go file some
> Debian bug reports.

The maintainer was very responsive, fixing my bugs in about an hour
after they were reported.

I can now get as far as t3404, which seems to have problems due to
rebase-interactive using parentheses, "-a", and "-o" with "test". I'm
not sure how much time it is worth spending on this; I'm not sure anyone
actually uses a shell as featureless as posh in real life (though I
suppose it could eventually become the Debian shell).

-Peff
