From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] add '%d' pretty format specifier to show decoration
Date: Thu, 4 Sep 2008 20:11:34 -0400
Message-ID: <20080905001133.GA17463@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx> <48C055B3.3030204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Sep 05 02:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOwb-0007FX-VU
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 02:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbYIEALh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2008 20:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbYIEALh
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 20:11:37 -0400
Received: from peff.net ([208.65.91.99]:1930 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbYIEALg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 20:11:36 -0400
Received: (qmail 13274 invoked by uid 111); 5 Sep 2008 00:11:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 04 Sep 2008 20:11:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Sep 2008 20:11:34 -0400
Content-Disposition: inline
In-Reply-To: <48C055B3.3030204@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94981>

On Thu, Sep 04, 2008 at 11:40:03PM +0200, Ren=C3=A9 Scharfe wrote:

> Michael Dressel implemented an initial version and chose the letter d=
,
> Junio suggested to add a leading space and parentheses.

The whole series looks good to me, and I am happy if it is applied
as-is. The only question I might raise is whether we want to use "%d"
for this, or use something longer to anticipate a collision with other
"d" words (I think you mentioned "describe" at one point).

-Peff
