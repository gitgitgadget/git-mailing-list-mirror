From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] blame,cat-file: Demonstrate --textconv is
 wrongly running converter on symlinks
Date: Tue, 21 Sep 2010 16:43:12 -0400
Message-ID: <20100921204312.GC395@sigill.intra.peff.net>
References: <cover.1285013802.git.kirr@landau.phys.spbu.ru>
 <cover.1285013802.git.kirr@landau.phys.spbu.ru>
 <3c344d9b8f014ccb96dc37dc42668426fb5a3c30.1285013802.git.kirr@landau.phys.spbu.ru>
 <vpqvd6086fq.fsf@bauges.imag.fr>
 <20100921183959.GB4390@landau.phys.spbu.ru>
 <vpqzkvaetq4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 21 22:43:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9gM-00011D-Fq
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab0IUUnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 16:43:13 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58458 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407Ab0IUUnM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 16:43:12 -0400
Received: (qmail 11563 invoked by uid 111); 21 Sep 2010 20:43:12 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 21 Sep 2010 20:43:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 16:43:12 -0400
Content-Disposition: inline
In-Reply-To: <vpqzkvaetq4.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156757>

On Tue, Sep 21, 2010 at 10:18:11PM +0200, Matthieu Moy wrote:

> > This note clearly says "git diff is not affected, that's why we don't
> > write new tests for it".
> 
> I disagree with the implication. Git diff is not affected because it
> was done right, but behaving correctly doesn't mean you don't need
> tests. Checking the behavior of diff with tests wouldn't harm (but
> that's not serious not to do it).

Actually, there is some breakage in "git diff" with userdiffs, just not
for textconv (but the fix covers both, so the problem is sort of a
superset).  I'm about to send a patch that has some tests, so don't
worry about them for this series.

-Peff
