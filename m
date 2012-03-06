From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Tue, 6 Mar 2012 09:09:11 -0500
Message-ID: <20120306140911.GA22329@sigill.intra.peff.net>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
 <20120306114914.GB6733@sigill.intra.peff.net>
 <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
 <4F5611F1.4020309@redhat.com>
 <vpqr4x5hmt3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Privoznik <mprivozn@redhat.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 06 15:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4v4s-0001W7-B9
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 15:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831Ab2CFOJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 09:09:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42182
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758591Ab2CFOJO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 09:09:14 -0500
Received: (qmail 11342 invoked by uid 107); 6 Mar 2012 14:09:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 09:09:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 09:09:11 -0500
Content-Disposition: inline
In-Reply-To: <vpqr4x5hmt3.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192349>

On Tue, Mar 06, 2012 at 02:38:16PM +0100, Matthieu Moy wrote:

> Michal Privoznik <mprivozn@redhat.com> writes:
> 
> > Okay guys. I'll got with diff.algorithm = [patience | minimal |
> > histogram | myers] then. What I am not sure about is how to threat case
> > when user have say algorithm = patience set in config but want to use
> > myers. I guess we need --myers option then, don't we?
> 
> At this point, maybe it's time to have
> --diff-algorithm=[patience|minimal|histogram|myers], and keep
> --patience, --minimal and --histogram just as compatibility aliases.
> 
> Having one option per algorithm feels wrong ...

Yeah, that was going to be my suggestion, too. And explaining it that
way in the docs will make it clear that "--histogram" overrides
"--patience" and so forth.

-Peff
