From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Teach git diff-tree --stdin to diff trees
Date: Mon, 11 Aug 2008 18:28:36 -0400
Message-ID: <20080811222836.GA12301@sigill.intra.peff.net>
References: <20080808204348.7744.46006.stgit@yoghurt> <20080808204829.7744.11661.stgit@yoghurt> <20080808214523.GA31424@sigill.intra.peff.net> <20080809100049.GB10804@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 00:29:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSftY-0003LL-NN
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbYHKW2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 18:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbYHKW2l
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:28:41 -0400
Received: from peff.net ([208.65.91.99]:2387 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbYHKW2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 18:28:40 -0400
Received: (qmail 18905 invoked by uid 111); 11 Aug 2008 22:28:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 11 Aug 2008 18:28:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Aug 2008 18:28:36 -0400
Content-Disposition: inline
In-Reply-To: <20080809100049.GB10804@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92011>

On Sat, Aug 09, 2008 at 12:00:49PM +0200, Karl Hasselstr=C3=B6m wrote:

> > And I think it might even be easier to code. ;)
>=20
> Not for someone who's almost entirely unfamiliar with the git API.
> Finding the right functions to call takes a lot of time ... which is
> why I decided to chicken out and implement only the subset I actually
> needed. But it can be added later -- perhaps by me.

:) I took a quick look, and I don't think it would be too hard to reuse
the logic from the command-line codepath. However, your patches are
already in 'next', and I don't see much point doing it the other way
unless there is actually some demand for mixed commit/tree input.

-Peff
