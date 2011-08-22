From: Jeff King <peff@peff.net>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Mon, 22 Aug 2011 17:32:14 -0400
Message-ID: <20110822213214.GA14404@sigill.intra.peff.net>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
 <7vliurd62x.fsf@alter.siamese.dyndns.org>
 <20110817231922.GA28966@sigill.intra.peff.net>
 <CAGdFq_iiTt8F+kPXwZZT3fAKwZLCpPr7BOYtistxvv6s52Q5nQ@mail.gmail.com>
 <20110822161932.GA1945@sigill.intra.peff.net>
 <CAGdFq_gx+NutDCU7egr_fYUvVG=g1t76LiV1SV-W=0KWBTjHyQ@mail.gmail.com>
 <20110822175705.GB1945@sigill.intra.peff.net>
 <7vpqjxuogr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 23:32:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvc6Y-0003w9-59
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 23:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034Ab1HVVcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 17:32:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51726
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab1HVVcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 17:32:16 -0400
Received: (qmail 20323 invoked by uid 107); 22 Aug 2011 21:32:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 22 Aug 2011 17:32:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2011 17:32:14 -0400
Content-Disposition: inline
In-Reply-To: <7vpqjxuogr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179893>

On Mon, Aug 22, 2011 at 02:27:00PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, the behavior of your patch looks fine to me. I thought the point
> > in contention was that having export understand refspecs would fix a lot
> > of _other_ cases, too.
> 
> Perhaps if we added refspecs we could cover other cases, too, but I do not
> think we need to require the patch to cover additional cases. The more
> problematic was that the particular implementation in the patch smelled
> bad.

OK. I didn't look at that at all. I just wanted to express my support
for "refspecs would solve other problems, too". :)

-Peff
