From: Jeff King <peff@peff.net>
Subject: Re: Removing redundant packs
Date: Sat, 8 Dec 2007 18:50:32 -0500
Message-ID: <20071208235032.GB31121@sigill.intra.peff.net>
References: <20071208125050.GA17478@machine.or.cz> <7vsl2cvpef.fsf@gitster.siamese.dyndns.org> <20071208234414.GA31121@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 00:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J19Rh-0005CT-7M
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 00:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbXLHXuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 18:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbXLHXuf
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 18:50:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2978 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbXLHXue (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 18:50:34 -0500
Received: (qmail 22283 invoked by uid 111); 8 Dec 2007 23:50:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 08 Dec 2007 18:50:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 18:50:32 -0500
Content-Disposition: inline
In-Reply-To: <20071208234414.GA31121@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67578>

On Sat, Dec 08, 2007 at 06:44:15PM -0500, Jeff King wrote:

> You seem to think that repacking without "-l" will pull objects from
> alternates, but it doesn't (I have also seen "repack -a -d" recommended
> for "how do I break alternates dependencies", but it obviously also
> doesn't work for that).

And by "you seem to think" I obviously don't mean "stupid n00b, you
don't understand git" but "I'm unclear on what the behavior should be.
You seem to be saying this, which means this is a serious bug."

-Peff
