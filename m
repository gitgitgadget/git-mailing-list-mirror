From: Jeff King <peff@peff.net>
Subject: Re: Configuring diff --color-words using git-config?
Date: Wed, 1 Jun 2011 12:51:48 -0400
Message-ID: <20110601165147.GE7132@sigill.intra.peff.net>
References: <BANLkTikMPDM7ce0mJhx=Hmm4bhLFCREUCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Delanoy <frederic.delanoy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRoeB-0005Hg-Em
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758534Ab1FAQvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 12:51:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60072
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497Ab1FAQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:51:50 -0400
Received: (qmail 14335 invoked by uid 107); 1 Jun 2011 16:51:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 12:51:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 12:51:48 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikMPDM7ce0mJhx=Hmm4bhLFCREUCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174881>

On Wed, Jun 01, 2011 at 12:12:18PM +0200, Fr=C3=A9d=C3=A9ric Delanoy wr=
ote:

> Is it possible to use a config option so that "--color-words" is used
> as default for diff?

No. And I'm not sure it would be a good idea, as the resulting diffs
would not be able to be applied, which could create some confusion.

Another option would be to use an alias to reduce the amount of typing:

  git config alias.dcw "diff --color-words"

-Peff
