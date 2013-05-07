From: Jeff King <peff@peff.net>
Subject: Re: jn/config-ignore-inaccessible (Re: What's cooking in git.git
 (Apr 2013, #10; Mon, 29))
Date: Tue, 7 May 2013 14:41:20 -0400
Message-ID: <20130507184120.GB5776@sigill.intra.peff.net>
References: <7vppxdgife.fsf@alter.siamese.dyndns.org>
 <87y5bvyw7j.fsf@hexa.v.cablecom.net>
 <20130504201414.GA2420@elie.Belkin>
 <7vwqreull0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 20:41:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZmpK-0004SR-UX
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 20:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab3EGSlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 14:41:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:50064 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab3EGSlW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 14:41:22 -0400
Received: (qmail 27890 invoked by uid 102); 7 May 2013 18:41:43 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 May 2013 13:41:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2013 14:41:20 -0400
Content-Disposition: inline
In-Reply-To: <7vwqreull0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223592>

On Sat, May 04, 2013 at 08:55:39PM -0700, Junio C Hamano wrote:

> >>   http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3022
> >>   http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3111
> >
> > I think the approach taken in the patch above is a good one.  If
> > /etc/gitconfig contains important configuration, it is still not
> > ignored, errors other than permissions reading ~/.gitconfig are
> > still fatal, and permissions errors accessing ~/.gitconfig are no
> > longer fatal because they are expected as something very common
> > in normal setups.
> 
> OK.  Let's cook it in 'next' for a while and then decide what to do
> post 1.8.3; I am perfectly fine with making it graduate to 'master'
> immediately after 1.8.3 if everybody thinks this is a good idea.

FWIW, I do think this is the best path. I don't like the complex "which
errors are fatal" rule, but I think it is easily the most practical
solution.

-Peff
