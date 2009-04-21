From: Jeff King <peff@peff.net>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 23:08:49 -0400
Message-ID: <20090421030848.GF14479@coredump.intra.peff.net>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 05:10:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw6NO-0004mx-Mh
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 05:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZDUDIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 23:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbZDUDIy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 23:08:54 -0400
Received: from peff.net ([208.65.91.99]:59274 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbZDUDIx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 23:08:53 -0400
Received: (qmail 6187 invoked by uid 107); 21 Apr 2009 03:09:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Apr 2009 23:09:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 23:08:49 -0400
Content-Disposition: inline
In-Reply-To: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117081>

On Mon, Apr 20, 2009 at 10:59:00AM -0400, Jay Soffian wrote:

> Whatever is decided this time, perhaps it should be burned into the tops of
> the *.perl scripts (i.e. "require 5.008;"). It should also be added to
> CodingGuidelines. You know, so this conversation doesn't keep recurring. :-)

I have no real comment on _which_ version, but yes, I think a 'require'
for the right version would be very helpful. The error messages you get
when running on a too-old version can be confusing, at best. Saying "you
need a newer perl" would be much nicer.

-Peff
