From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] configurable advice messages
Date: Wed, 9 Sep 2009 07:26:24 -0400
Message-ID: <20090909112623.GA30765@coredump.intra.peff.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
 <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
 <20090906072322.GA29949@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 13:26:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlLJr-0007aC-BE
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 13:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZIIL00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 07:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbZIIL00
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 07:26:26 -0400
Received: from peff.net ([208.65.91.99]:35252 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbZIIL0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 07:26:25 -0400
Received: (qmail 27928 invoked by uid 107); 9 Sep 2009 11:26:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Sep 2009 07:26:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 07:26:24 -0400
Content-Disposition: inline
In-Reply-To: <20090906072322.GA29949@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128060>

On Sun, Sep 06, 2009 at 03:23:22AM -0400, Jeff King wrote:

> I'll re-roll 3 and 4 based on that, but I will wait a bit to see any
> more comments. Probably you should consider patches 1 and 2 as a
> potential series for 'maint', and 3 and 4 should be spun off into their
> own series (they really only rely textually on the first two).

Looks like you applied 1 and 2 already, so here is the re-roll of the
latter two patches incorporating the changes that have been discussed.

  [1/2]: push: make non-fast-forward help message configurable
  [2/2]: status: make "how to stage" messages optional

-Peff
