From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Tue, 1 Mar 2011 17:04:29 -0500
Message-ID: <20110301220428.GE23945@sigill.intra.peff.net>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com>
 <4D58E17C.9090001@viscovery.net>
 <alpine.DEB.2.00.1102232216180.11038@debian>
 <20110224080734.GB25595@sigill.intra.peff.net>
 <20110224080904.GC25595@sigill.intra.peff.net>
 <m3sjvb7tg4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:04:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuXg8-0005mL-PW
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab1CAWEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 17:04:20 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51092 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755640Ab1CAWET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:04:19 -0500
Received: (qmail 10902 invoked by uid 111); 1 Mar 2011 22:04:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 22:04:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 17:04:29 -0500
Content-Disposition: inline
In-Reply-To: <m3sjvb7tg4.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168264>

On Fri, Feb 25, 2011 at 12:27:03PM -0800, Jakub Narebski wrote:

> > > Yes, sourced scripts should not have an executable bit. See 46bac90 for
> > > rationale.
> > 
> > And I should have mentioned: they should go in SCRIPT_LIB in the
> > Makefile, not SCRIPT_SH.
> 
> Shouldn't this information be in Documentation/CodingGuidelines, and
> perhaps also (checking if one doesn't accidentally change executable
> bit on sourced scripts) in Documentation/SubmittingPatches?

I think it might make more sense as comments in the Makefile, which is
not very well commented for people tweaking non-config bits. Patches
welcome.

-Peff
