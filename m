From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Fri, 1 Feb 2013 03:25:38 -0500
Message-ID: <20130201082538.GA25674@sigill.intra.peff.net>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
 <20130201050343.GA29973@sigill.intra.peff.net>
 <7v7gmsd26o.fsf@alter.siamese.dyndns.org>
 <20130201073352.GB970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 09:26:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Bwi-0007lh-N3
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 09:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab3BAIZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 03:25:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55277 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab3BAIZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 03:25:42 -0500
Received: (qmail 19236 invoked by uid 107); 1 Feb 2013 08:27:05 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 03:27:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 03:25:38 -0500
Content-Disposition: inline
In-Reply-To: <20130201073352.GB970@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215215>

On Fri, Feb 01, 2013 at 02:33:52AM -0500, Jeff King wrote:

> I am starting to think it has grown in an unnecessarily complex
> direction, and we would be much happier just calling all of the
> "concept" documentation "git-".
> 
> The steps I see are:

I am still undecided on whether it is a good idea (in some ways, I like
that "gitrevisions" signals to the user that it is not a command; but I
also recognize that it is more complex for users, and gitremote-helpers
looks silly to me). But here is what the patch looks like, for
reference. The first one is a cleanup we might want to take anyway, and
the second one is the meat.

  [1/2]: Documentation/Makefile: clean up MAN*_TXT lists
  [2/2]: docs: convert "concept" manpages to git-*

-Peff
