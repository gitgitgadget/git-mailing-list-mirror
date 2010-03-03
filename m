From: Jeff King <peff@peff.net>
Subject: Re: Latest master failing t7401 submodule tests
Date: Wed, 3 Mar 2010 15:02:39 -0500
Message-ID: <20100303200239.GA28904@coredump.intra.peff.net>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: A Large Angry SCM <gitzilla@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 21:02:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmumL-0006cW-O4
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383Ab0CCUCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:02:42 -0500
Received: from peff.net ([208.65.91.99]:59502 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab0CCUCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:02:40 -0500
Received: (qmail 13832 invoked by uid 107); 3 Mar 2010 20:03:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Mar 2010 15:03:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Mar 2010 15:02:39 -0500
Content-Disposition: inline
In-Reply-To: <7vhboxqje8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141466>

On Wed, Mar 03, 2010 at 11:45:19AM -0800, Junio C Hamano wrote:

> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
> > 13 to the 18 tests in t7401 submodule test jig are failing with the
> > latest master this morning.
> 
> Do you mean v1.7.0.1-138-ga75bab5?
> 
> I don't see it with Debian 5.0.4 on x86_64 (my primary box), Fedora 11 nor
> FreeBSD 8.0 (the latter two are kvm sandboxes pretending to be i686).

I did see it on my debian unstable box with with dash as /bin/sh (though
IIRC, isn't FreeBSD /bin/sh ash?). It looked like a "shift: can't shift
that many" error, but I haven't had time to track it down further yet
(I'm installing lighting in a 2-year-old's play kitchen. ;) ).

Maybe the shell selection will give somebody lead. If not, I'll try to
look at it again in a few hours.

-Peff
