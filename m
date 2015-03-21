From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t6039: fix broken && chain
Date: Sat, 21 Mar 2015 03:35:04 -0400
Message-ID: <20150321073504.GA27780@peff.net>
References: <550D1811.3040802@web.de>
 <550D1B78.5090703@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 21 08:35:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZDwK-00006m-DR
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 08:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbbCUHfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 03:35:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:36397 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751164AbbCUHfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 03:35:07 -0400
Received: (qmail 30184 invoked by uid 102); 21 Mar 2015 07:35:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Mar 2015 02:35:07 -0500
Received: (qmail 32257 invoked by uid 107); 21 Mar 2015 07:35:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Mar 2015 03:35:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Mar 2015 03:35:04 -0400
Content-Disposition: inline
In-Reply-To: <550D1B78.5090703@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266014>

On Sat, Mar 21, 2015 at 08:19:20AM +0100, Torsten B=C3=B6gershausen wro=
te:

> On 2015-03-21 08.04, Torsten B=C3=B6gershausen wrote:
> > Add missing %%, detected by the --chain-lint option
> Oh, early morning typo, should be
> Add missing &&, detected by the --chain-lint option
>=20
> (I'll re-run the testsuite with the  --chain-lint in a minute,
>  thanks everybody for this nice feature)

Yay! I'm glad to see it detecting something, and people trying it out o=
n
platforms with different prereqs than mine.

-Peff
