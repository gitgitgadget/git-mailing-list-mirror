From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Fri, 11 Mar 2011 00:33:12 -0500
Message-ID: <20110311053312.GC16605@sigill.intra.peff.net>
References: <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
 <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
 <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
 <7vipvq1hpw.fsf@alter.siamese.dyndns.org>
 <20110311052235.GA16605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 06:33:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxuyV-0000sa-Ob
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 06:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab1CKFdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 00:33:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58855
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab1CKFdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 00:33:14 -0500
Received: (qmail 2651 invoked by uid 107); 11 Mar 2011 05:33:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Mar 2011 00:33:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2011 00:33:12 -0500
Content-Disposition: inline
In-Reply-To: <20110311052235.GA16605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168883>

On Fri, Mar 11, 2011 at 12:22:35AM -0500, Jeff King wrote:

> This is basically the birthday problem used in hash collision analysis.
> Which means that if we decide on some acceptable probability of
> collision, we can figure out the hash-length required to keep the
> probability of collision below that acceptable level for a repository
> with objects.

Urgh, that was supposed to be "...for a repository with _n_ objects".
But hopefully that became clear as you read on.

-Peff
