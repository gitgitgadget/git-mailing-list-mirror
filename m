From: Jeff King <peff@peff.net>
Subject: Re: git status in clean working dir
Date: Thu, 24 Jul 2008 12:54:55 -0400
Message-ID: <20080724165455.GD20816@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <D42305E3-82DA-46C1-B55F-74AD9AD48197@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Ask =?utf-8?B?QmrDuHJu?= Hansen <ask@develooper.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM46g-00077X-R0
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbYGXQy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 12:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbYGXQy5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:54:57 -0400
Received: from peff.net ([208.65.91.99]:3442 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbYGXQy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:54:57 -0400
Received: (qmail 26012 invoked by uid 111); 24 Jul 2008 16:54:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 24 Jul 2008 12:54:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2008 12:54:55 -0400
Content-Disposition: inline
In-Reply-To: <D42305E3-82DA-46C1-B55F-74AD9AD48197@develooper.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89910>

On Wed, Jul 23, 2008 at 11:56:48PM -0700, Ask Bj=C3=B8rn Hansen wrote:

>> (2) Then why are we even allowing to configure the plumbing to page?
>
> I don't have an opinion on the the appropriateness of paging various =
=20
> commands, but to solve the problem of scripts getting tripped up by t=
he=20
> paging, couldn't the plumping check if STDOUT is a tty and only do th=
e=20
> paging if so?
>
> (In Perl "page_output(...) if $pager_configured and -t STDOUT")

We already do this, so "git status >/dev/null" produces the correct exi=
t
code. But scripts don't necessarily redirect stdout.

-Peff
