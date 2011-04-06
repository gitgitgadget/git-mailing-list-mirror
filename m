From: Jeff King <peff@github.com>
Subject: Re: [RFC] upload-pack deadlock
Date: Wed, 6 Apr 2011 17:38:18 -0400
Message-ID: <20110406213818.GB18481@sigill.intra.peff.net>
References: <20110404053626.GA26529@sigill.intra.peff.net>
 <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
 <20110406175413.GA8205@sigill.intra.peff.net>
 <BANLkTi=5WgfLoBU1ZXqyEkoBf_pQu2QKOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 23:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7aQk-0004k1-RW
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 23:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858Ab1DFViW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 17:38:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54659
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab1DFViV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 17:38:21 -0400
Received: (qmail 9533 invoked by uid 107); 6 Apr 2011 21:39:07 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 17:39:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 17:38:18 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=5WgfLoBU1ZXqyEkoBf_pQu2QKOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171020>

On Wed, Apr 06, 2011 at 09:15:31PM +0200, Erik Faye-Lund wrote:

> On Wed, Apr 6, 2011 at 7:54 PM, Jeff King <peff@github.com> wrote:
> > I do still wonder about the win32 deadlock that Erik mentioned. Does my
> > patch help at all, or is there another bug hiding somewhere?
> 
> Nope :(
> 
> If you're interested, you can read some more information here on the
> msysGit mailing list:
> http://groups.google.com/group/msysgit/browse_thread/thread/865318a3e89d9e64/9d475b8ff3cef3c3
> 
> It only happens when pushing over the git-protocol. But it happens consistently.

Thanks for an interesting read. Unfortunately, my reading of that thread
is that the bug isn't in git code, but in some weird Windows
interaction, and it isn't worth me trying to reproduce on Linux. So I
guess it is probably unrelated to this.

-Peff
