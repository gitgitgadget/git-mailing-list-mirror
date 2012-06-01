From: Jeff King <peff@peff.net>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Fri, 1 Jun 2012 05:30:39 -0400
Message-ID: <20120601093039.GD32340@sigill.intra.peff.net>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
 <7vehq18c82.fsf@alter.siamese.dyndns.org>
 <20120531011911.GC5488@sigill.intra.peff.net>
 <7v62bc97w1.fsf@alter.siamese.dyndns.org>
 <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
 <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
 <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com>
 <7vd35k6w0i.fsf@alter.siamese.dyndns.org>
 <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Lanny Ripple <lanny@spotinfluence.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:30:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaOC7-0002kg-UU
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759309Ab2FAJaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 05:30:46 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39692
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758780Ab2FAJan (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 05:30:43 -0400
Received: (qmail 31358 invoked by uid 107); 1 Jun 2012 09:30:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Jun 2012 05:30:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2012 05:30:39 -0400
Content-Disposition: inline
In-Reply-To: <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198969>

[Please don't top-post.]

On Thu, May 31, 2012 at 02:21:16PM -0500, Lanny Ripple wrote:

> >> Perhaps the error message in git-am could be modified to indicate
> >> sed is a suspect?.  E.g.,
> [...]
> > Hrm, that does not sound an attractive way going forward.
> [...]
> You have three recent instances where people have bumped into this
> with sed.  (And yes on reporting it to the packaging project.)  It
> seems to me leaving a breadcrumb so that folks can figure out what's
> going on without having to bother the list would be a win for
> everyone.

But you have to keep in mind all of the people who will be led down the
wrong path by your breadcrumb when the failure is caused by a
_different_ problem. What is the probability that it is helpful versus
not helpful?  If you are going to give advice that sed might be broken,
you should at least test to see if it is broken and report it.

But really, I'd rather just see the broken sed fixed. Where would the
breadcrumb lead people at this point, anyway? We don't actually have a
solution besides "uninstall this other, crappy sed". Has the sed bug
actually been fixed?

-Peff
