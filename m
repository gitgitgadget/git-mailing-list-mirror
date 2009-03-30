From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/4] Rename push.default to push.mode
Date: Mon, 30 Mar 2009 14:02:53 -0400
Message-ID: <20090330180253.GA7220@coredump.intra.peff.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net> <1238407903-28020-5-git-send-email-santi@agolina.net> <49D0A1FE.60300@drmicha.warpmail.net> <adf1fd3d0903300537i41d4aef3g49ab6bde9343cbc5@mail.gmail.com> <49D0C3B8.2050801@drmicha.warpmail.net> <20090330134544.GA31827@coredump.intra.peff.net> <49D0DB78.2010204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 20:06:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoLqj-0002x4-Un
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 20:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbZC3SDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbZC3SDF
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 14:03:05 -0400
Received: from peff.net ([208.65.91.99]:49432 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbZC3SDE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 14:03:04 -0400
Received: (qmail 6062 invoked by uid 107); 30 Mar 2009 18:03:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 30 Mar 2009 14:03:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2009 14:02:53 -0400
Content-Disposition: inline
In-Reply-To: <49D0DB78.2010204@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115181>

On Mon, Mar 30, 2009 at 04:47:20PM +0200, Michael J Gruber wrote:

> Thanks for the explanation! I rechecked, and for sure it also happene=
d
> with patches from Tor Arne Vestb=C3=B8 and Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy.
> Again I feel blessed by my umlautlessness... and challenged by gmane.
> About time to ditch it for reading patches also, or at least to be aw=
are
> of it when saving patches.

The message gmane passes out has the content-transfer-encoding set
properly. Your newsreader should properly un-QP it, or if it has an
option to save it directly (encoding and all), then "git am" will un-QP
it. If you were to "git apply" it directly, that would break, though
(and it is user error). If your newsreader saves the QP text without th=
e
matching header, then that would also break (and your newsreader is
broken).

Just curious how you are seeing the breakage (because I want to make
sure there is no git bug).

-Peff
