From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 11:56:11 -0400
Message-ID: <20130410155611.GA10749@sigill.intra.peff.net>
References: <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
 <20130410035039.GA795@sigill.intra.peff.net>
 <CALkWK0=Tu7ttVqF1RPKvHiMQTH7dU+PKCfsZw9eq1H=vkRen9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 17:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPxNn-0002SK-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 17:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936169Ab3DJP4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 11:56:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38802 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762357Ab3DJP4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 11:56:18 -0400
Received: (qmail 3422 invoked by uid 107); 10 Apr 2013 15:58:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 11:58:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 11:56:11 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=Tu7ttVqF1RPKvHiMQTH7dU+PKCfsZw9eq1H=vkRen9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220697>

On Wed, Apr 10, 2013 at 06:52:51PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> >   git push --remote=host:some/path
> >
> > if we are willing to break the existing syntax. Though your proposal
> > does have the benefit of breaking only one particular syntax which is
> > (I'm guessing) less frequently used. But we'd still need the usual
> > deprecation period, I think.
> 
> Why?  'git push host:some/path' should treat host:some/path as a
> destination and not a refspec.  If the user meant refspec, she should
> do 'git push -- host:some/path' instead.

You snipped the part of Jonathan's message I quoted; I was responding
specifically to making "git push host:some/path" an error.  I do not
think that is a good idea, and doing so would require a deprecation
period.

-Peff
