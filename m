From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] make config --add behave correctly for empty and NULL
 values
Date: Thu, 11 Sep 2014 22:29:45 -0400
Message-ID: <20140912022945.GB15519@peff.net>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
 <xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
 <20140819051732.GA13765@peff.net>
 <xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>
 <20140819062000.GA7805@peff.net>
 <xmqqy4tpbuii.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 04:29:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSGcS-0000re-7f
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 04:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbaILC3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 22:29:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:47283 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751616AbaILC3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 22:29:48 -0400
Received: (qmail 26587 invoked by uid 102); 12 Sep 2014 02:29:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 21:29:48 -0500
Received: (qmail 31229 invoked by uid 107); 12 Sep 2014 02:30:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 22:30:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2014 22:29:45 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4tpbuii.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256893>

On Thu, Sep 11, 2014 at 04:35:33PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here is the patch I wrote, for reference (I also think breaking the
> > "matches" function into a series of conditionals, as you showed, is way
> > more readable):
> 
> OK, while reviewing the today's issue of "What's cooking" and making
> topics graduate to 'master', I got annoyed that the bottom of jch
> branch still needed to be kept.  Let's do this.
> 
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Tue, 19 Aug 2014 02:20:00 -0400
> Subject: [PATCH] config: avoid a funny sentinel value "a^"
> 
> Introduce CONFIG_REGEX_NONE as a more explicit sentinel value to say
> "we do not want to replace any existing entry" and use it in the
> implementation of "git config --add".
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks good, and adding my signoff is fine. Thanks.

-Peff
