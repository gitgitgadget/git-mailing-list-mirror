From: Jeff King <peff@peff.net>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 06:33:52 -0400
Message-ID: <20080731103351.GA22895@sigill.intra.peff.net>
References: <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org> <20080731082553.GA19522@sigill.intra.peff.net> <7v8wvizc16.fsf@gitster.siamese.dyndns.org> <20080731090348.GB20691@sigill.intra.peff.net> <20080731091515.GC12867@artemis.madism.org> <20080731093410.GA21396@sigill.intra.peff.net> <20080731102223.GD12867@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 12:35:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOVV0-0006Ns-1X
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 12:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977AbYGaKeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 06:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbYGaKeE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 06:34:04 -0400
Received: from peff.net ([208.65.91.99]:1288 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169AbYGaKeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 06:34:01 -0400
Received: (qmail 22886 invoked by uid 111); 31 Jul 2008 10:33:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 06:33:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 06:33:52 -0400
Content-Disposition: inline
In-Reply-To: <20080731102223.GD12867@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90921>

On Thu, Jul 31, 2008 at 12:22:23PM +0200, Pierre Habouzit wrote:

> > [Pierre, you have the bogus MFT header that people are often complaining
> > about. Either I have to do extra work to fix the headers, or more people
> > end up in the To: field. I don't personally care about the latter, but
> > it seems that others organize their mail based on To versus Cc]
> 
>   [  err if you do a list reply, nobody ends up in To:... but oh well I
>      can probably remove it, it'll just make my own mutt git folder
>      awkwardly colorized.  ]

I can't do a list reply, as mutt sees no list (and I didn't bother
setting up a 'subscribe' variable, since I didn't want to generate MFTs
in the first place). However, I just realized that mutt has an
honor_followup_to, which will do what I want (AFAICT, there is no point
in honoring MFT when using the conventions of this mailing list).

But I wonder if it is as simple in other clients.

-Peff
