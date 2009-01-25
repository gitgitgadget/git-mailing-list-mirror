From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sun, 25 Jan 2009 16:44:35 -0500
Message-ID: <20090125214435.GA20173@coredump.intra.peff.net>
References: <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org> <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com> <831vuvfh7t.fsf@kalahari.s2.org> <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com> <83wscndv57.fsf@kalahari.s2.org> <94a0d4530901240021u65adeff8pb6995ef707bc1f68@mail.gmail.com> <alpine.DEB.1.00.0901241438370.13232@racer> <94a0d4530901240604o5ae0d321h17dc6aabeefe9d53@mail.gmail.com> <7vvds3dszy.fsf@gitster.siamese.dyndns.org> <94a0d4530901251312q4201d51btd806fe860a12afd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 22:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRCnq-00020N-VG
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 22:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbZAYVoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 16:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbZAYVoi
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 16:44:38 -0500
Received: from peff.net ([208.65.91.99]:45201 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbZAYVoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 16:44:38 -0500
Received: (qmail 28327 invoked by uid 107); 25 Jan 2009 21:44:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 16:44:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 16:44:35 -0500
Content-Disposition: inline
In-Reply-To: <94a0d4530901251312q4201d51btd806fe860a12afd6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107107>

On Sun, Jan 25, 2009 at 11:12:57PM +0200, Felipe Contreras wrote:

> However, my last proposal was to have both the git config --global
> *and* the $HOME/.gitconfig description. Is there any argument against
> that?

This is like the fifth time you have asked, and for some reason, nobody
seems to have said yes or no. So I will go ahead and say: yes, I think
that is a fine idea.

I think there should also be some explanatory text that indicates they
are totally interchangeable for the rest of the document. Something
like: "When we show configuration in the rest of this document, we will
use format X [I think probably "git config $VAR $VALUE"]. But you can
use whichever method you are most comfortable with."

-Peff
