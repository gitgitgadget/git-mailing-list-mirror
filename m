From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/4] Rename push.default to push.mode
Date: Mon, 30 Mar 2009 09:45:45 -0400
Message-ID: <20090330134544.GA31827@coredump.intra.peff.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net> <1238407903-28020-5-git-send-email-santi@agolina.net> <49D0A1FE.60300@drmicha.warpmail.net> <adf1fd3d0903300537i41d4aef3g49ab6bde9343cbc5@mail.gmail.com> <49D0C3B8.2050801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 15:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoHpp-0007si-BA
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 15:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbZC3Np5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 09:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbZC3Np5
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 09:45:57 -0400
Received: from peff.net ([208.65.91.99]:49858 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbZC3Np5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 09:45:57 -0400
Received: (qmail 4389 invoked by uid 107); 30 Mar 2009 13:46:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 30 Mar 2009 09:46:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2009 09:45:45 -0400
Content-Disposition: inline
In-Reply-To: <49D0C3B8.2050801@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115149>

On Mon, Mar 30, 2009 at 03:06:00PM +0200, Michael J Gruber wrote:

> > I don't see the quoted-printable characters, I see them in utf-8 and 8bit.
> > 
> > Content-Type: text/plain; charset=utf-8
> > Content-Transfer-Encoding: 8bit
> > 
> > Maybe some server in between is recoding it.
> 
> That's weird. I read through gmane/nntp, but others' posts are fine.
> Yours have
> 
> Content-Type: text/plain; charset=utf-8
> Content-Transfer-Encoding: QUOTED-PRINTABLE

If a subscriber's mailserver does not support the 8BITMIME SMTP
extension, then vger will (correctly) encode an 8bit message as QP.
Gmane's mailservers do not seem to support 8BITMIME.

You see it only with Santi's message because most messages are already
7bit clean; however, the accent in his name requires git to mark it as
8-bit.

-Peff
