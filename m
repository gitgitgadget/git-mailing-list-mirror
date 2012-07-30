From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 12:39:07 -0400
Message-ID: <20120730163907.GA18109@sigill.intra.peff.net>
References: <1343664610-479-1-git-send-email-dangra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel =?utf-8?B?R3Jhw7Fh?= <dangra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:39:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svszz-0006zj-UO
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab2G3QjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 12:39:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41485 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439Ab2G3QjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:39:10 -0400
Received: (qmail 17298 invoked by uid 107); 30 Jul 2012 16:39:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jul 2012 12:39:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2012 12:39:07 -0400
Content-Disposition: inline
In-Reply-To: <1343664610-479-1-git-send-email-dangra@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202576>

On Mon, Jul 30, 2012 at 01:10:10PM -0300, Daniel Gra=C3=B1a wrote:

> Subject: Re: [PATCH] Improve tests for detached worktree in git-submo=
dule
>=20
> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>

The space between the subject and your S-o-b is an excellent place to
explain the rationale for your commit.

How are we improving them? What cases or classes of failure does this
catch that the original did not?  It may be because I have not been
following this topic closely, but reading the patch, I am not sure what
the purpose is. Please make life easier for reviewers by telling us wha=
t
to expect and why before we even get to the patch.

-Peff
