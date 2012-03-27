From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tests: unset COLUMNS inherited from environment
Date: Tue, 27 Mar 2012 14:44:26 -0400
Message-ID: <20120327184426.GC8460@sigill.intra.peff.net>
References: <20120327051714.GB20897@sigill.intra.peff.net>
 <1332829323-6048-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:44:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCbNi-00026q-0n
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab2C0So3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 14:44:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34427
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880Ab2C0So2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:44:28 -0400
Received: (qmail 6080 invoked by uid 107); 27 Mar 2012 18:44:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 14:44:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 14:44:26 -0400
Content-Disposition: inline
In-Reply-To: <1332829323-6048-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194073>

On Tue, Mar 27, 2012 at 08:22:02AM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> $COLUMNS must be unset to not interfere with the tests. The tests
> already ignore the terminal size because output is redirected to a
> file, but COLUMNS overrides terminal size detection and changes the
> test output away from the standard 80.
>=20
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
> Right, it is better to unset $COLUMNS globally. t4016 was also affect=
ed.

Thanks. Solves the problem for me, and looks obviously correct.

-Peff
