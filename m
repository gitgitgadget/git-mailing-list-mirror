From: Jeff King <peff@peff.net>
Subject: Re: gitdiffbinstat  -  git diff --shortstat -like output for changes
 in binary files
Date: Fri, 29 Mar 2013 14:49:22 -0400
Message-ID: <20130329184922.GB13506@sigill.intra.peff.net>
References: <5155D864.8040007@famsik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthias =?utf-8?Q?Kr=C3=BCger?= <matthias.krueger@famsik.de>
X-From: git-owner@vger.kernel.org Fri Mar 29 19:50:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULeNA-0003DY-OV
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 19:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab3C2St1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 14:49:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48510 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756453Ab3C2StY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 14:49:24 -0400
Received: (qmail 9030 invoked by uid 107); 29 Mar 2013 18:51:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 14:51:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 14:49:22 -0400
Content-Disposition: inline
In-Reply-To: <5155D864.8040007@famsik.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219520>

On Fri, Mar 29, 2013 at 07:07:32PM +0100, Matthias Kr=C3=BCger wrote:

> I use git mostly for game-development which means I have to deal with
> a lot of binary files (images, sound files etc).
>=20
> When I came to a point where I had run image optimization on a
> branch, I wanted to know of course how much smaller the new branch
> was in comparison to master.
> Problem was that 'git diff --stat' would only summerize
> per-binary-file size changes and 'git diff --shortstat' did skip the
> binary files entirely.

Have you tried "--summary"? Combined with --stat (or --shortstat) I
wonder if it would get you closer to what you want.

-Peff
