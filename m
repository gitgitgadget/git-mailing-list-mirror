From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Sat, 7 Jun 2008 00:42:12 -0400
Message-ID: <20080607044211.GA29096@sigill.intra.peff.net>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org> <alpine.DEB.1.00.0806061911300.1783@racer> <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil> <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com> <alpine.DEB.1.00.0806070006150.1783@racer> <7v4p86rwfi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Cedric Vivier <cedricv@neonux.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 06:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4qGi-0003rW-QS
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 06:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYFGEmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbYFGEmP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 00:42:15 -0400
Received: from peff.net ([208.65.91.99]:4716 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbYFGEmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 00:42:14 -0400
Received: (qmail 22902 invoked by uid 111); 7 Jun 2008 04:42:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 07 Jun 2008 00:42:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jun 2008 00:42:12 -0400
Content-Disposition: inline
In-Reply-To: <7v4p86rwfi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84171>

On Fri, Jun 06, 2008 at 04:11:13PM -0700, Junio C Hamano wrote:

> I sometimes dreamed of having "sort --random" for testing purposes ;-)

perl -MList::Util=shuffle -e 'print shuffle <>'

-Peff
