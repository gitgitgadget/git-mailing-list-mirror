From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 13:29:14 -0400
Message-ID: <20130410172914.GB16908@sigill.intra.peff.net>
References: <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
 <20130410035039.GA795@sigill.intra.peff.net>
 <7vzjx6mjct.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 19:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPypp-0003oX-RP
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 19:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177Ab3DJR3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 13:29:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38912 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964866Ab3DJR3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 13:29:21 -0400
Received: (qmail 4301 invoked by uid 107); 10 Apr 2013 17:31:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 13:31:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 13:29:14 -0400
Content-Disposition: inline
In-Reply-To: <7vzjx6mjct.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220708>

On Wed, Apr 10, 2013 at 09:38:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Apr 09, 2013 at 04:13:32PM -0700, Jonathan Nieder wrote:
> >
> >> Random idea: today you can do
> >> 
> >> 	git push origin master; # push branch master to remote origin
> >> 	git push --multiple origin korg; # push default refspec to 2 remotes
> >
> > Can we do "git push --multiple" today?
> 
> You can have multiple destination URLs for a single remote nickname.
> Wouldn't that be sufficient for regular publishing purposes?

Yes, though that is different than specifying two different remotes,
which may have their own sets of default refspecs (i.e., what Jonathan
wrote above). If they are two URLs of the same configured remote, there
is no question that they should respect the same refspecs.

-Peff
