From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 17:04:55 -0400
Message-ID: <20130410210455.GA2999@sigill.intra.peff.net>
References: <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200548.GC24177@sigill.intra.peff.net>
 <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net>
 <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2Cc-0000JY-E5
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab3DJVFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:05:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39197 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab3DJVFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:05:03 -0400
Received: (qmail 7257 invoked by uid 107); 10 Apr 2013 21:06:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 17:06:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 17:04:55 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220762>

On Thu, Apr 11, 2013 at 02:25:59AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > On Thu, Apr 11, 2013 at 01:49:54AM +0530, Ramkumar Ramachandra wrote:
> >> Huh, why?  Simply because he specified master alongside it?  How can
> >> we infer what you said in a consistent system?
> >
> > That's kind of my point. Why would they put two refs together in a
> > single push command? Did they mean "I am pushing up master, and since I
> > just tagged it, send the tag along, too"? Or did they really mean to
> > push them to two different places? If so, why not just run two separate
> > push commands?
> 
> I disagree.  The protocol was built ground up to support updating
> multiple refs in the same git push.  Running N separate push commands
> is _not_ the same thing at all; it running N times as slowly aside.

But I think all of this discussion just reinforces my point. We do not
have to agree on what the user intended. But the fact that we do not
agree means that out of a sample size of 2 users, we have 2 different
things the user expects to happen. If we choose a behavior and say "this
makes sense", then the other half of the users are going to be confused
or annoyed.

-Peff
