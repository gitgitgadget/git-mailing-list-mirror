From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] documentation fix: git log -p does not imply -c.
Date: Mon, 7 Mar 2011 10:47:12 -0500
Message-ID: <20110307154712.GA11934@sigill.intra.peff.net>
References: <4D724A0F.7050904@gmail.com>
 <1299355004-3532-2-git-send-email-haircut@gmail.com>
 <7vbp1n4vhv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Monsen <haircut@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 16:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwcej-0003Pp-VY
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 16:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab1CGPr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 10:47:27 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39880 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162Ab1CGPrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 10:47:17 -0500
Received: (qmail 5210 invoked by uid 111); 7 Mar 2011 15:47:15 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 15:47:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 10:47:12 -0500
Content-Disposition: inline
In-Reply-To: <7vbp1n4vhv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168592>

On Sun, Mar 06, 2011 at 04:36:28PM -0800, Junio C Hamano wrote:

> Adam Monsen <haircut@gmail.com> writes:
> 
> > Relates to the thread with subject "frustrated forensics: hard to find
> > diff that undid a fix" on the git mailing list.
> >
> > 	http://thread.gmane.org/gmane.comp.version-control.git/168481
> >
> > I don't wish for anyone to repeat my bungled forensics episode.
> 
> But this patch is wrong, isn't it?
> 
> The --cc format _is_ the default, not -c format.

Hmm. "git show" seems to show --cc, but "git log -p" does not show
anything. Try:

  $ git show 1538f21
  $ git log -p -1 1538f21

So the current doc seems to be wrong. Should we be fixing the code and
not the doc?

-Peff
