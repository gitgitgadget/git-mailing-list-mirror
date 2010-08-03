From: Jeff King <peff@peff.net>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 13:49:04 -0400
Message-ID: <20100803174904.GA28529@coredump.intra.peff.net>
References: <i372v0$3np$1@dough.gmane.org>
 <m3hbjcptyr.fsf@localhost.localdomain>
 <4C57D997.5010003@drmicha.warpmail.net>
 <FF986C58-37A5-41ED-B2AF-1EA4C045B9F7@gmail.com>
 <20100803124456.GA11608@coredump.intra.peff.net>
 <2D8CEA56-63B7-425E-A92B-89E2D1548679@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 19:49:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgLc7-0003iM-En
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 19:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab0HCRtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 13:49:12 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51041 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab0HCRtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 13:49:11 -0400
Received: (qmail 14213 invoked by uid 111); 3 Aug 2010 17:49:09 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 03 Aug 2010 17:49:09 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Aug 2010 13:49:04 -0400
Content-Disposition: inline
In-Reply-To: <2D8CEA56-63B7-425E-A92B-89E2D1548679@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152529>

On Tue, Aug 03, 2010 at 10:37:26AM -0700, Joshua Juran wrote:

> >>Does any system exist where long long is not 64 bits?  In any case,
> >>you can future-proof it by spelling it "int64_t".  That symbol is not
> >>guaranteed to exist (nor is <stdint.h>), but neither is the long long
> >>type in the first place.
> >
> >C99 specifies that "short" and "int" be at least 16 bits, that
> >"long" be
> >at least 32 bits, and that "long long" be at least 64 bits. See
> >section
> >5.2.4.2.1.
> 
> Right, but there's no guarantee that long long won't be *larger* than
> 64 bits.  Though maybe that wouldn't be a problem.

Ah, I took your statement to mean "at least". In this case, I don't
think it would be a problem (we could just represent more times).

-Peff
