From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 3 Aug 2012 16:07:18 -0400
Message-ID: <20120803200718.GA10648@sigill.intra.peff.net>
References: <20120803160229.GA13094@sigill.intra.peff.net>
 <1344024290-9197-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:07:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxO9e-00013n-57
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab2HCUHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 16:07:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50895 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523Ab2HCUHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 16:07:21 -0400
Received: (qmail 28041 invoked by uid 107); 3 Aug 2012 20:07:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 16:07:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 16:07:18 -0400
Content-Disposition: inline
In-Reply-To: <1344024290-9197-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202857>

On Fri, Aug 03, 2012 at 10:04:50PM +0200, Micha=C5=82 Kiedrowicz wrote:

> Previous patch didn't support `test_seq 1 50` (I removed it accidenta=
lly).

Our emails just crossed paths. :)

> +# test_seq is a portable replacement for seq(1).
> +# It may be used like:
> +#
> +#	for i in `test_seq 100`; do
> +#		echo $i
> +#	done

This should probably note that it is a subset of seq's behavior. You
talked about it in the commit message, but the in-code comment is a muc=
h
more likely thing for a potential user to read.

-Peff
