From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 23:18:41 -0400
Message-ID: <20150430031841.GA12361@peff.net>
References: <1430341032.14907.9.camel@ubuntu>
 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
 <1430343059.14907.18.camel@ubuntu>
 <20150429214817.GA2725@peff.net>
 <1430346576.14907.40.camel@ubuntu>
 <20150429231150.GB3887@peff.net>
 <20150430003750.GA4258@peff.net>
 <1430355983.14907.55.camel@ubuntu>
 <20150430011612.GA7530@peff.net>
 <xmqq7fsu4d1x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 05:18:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynezx-0006cM-CF
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 05:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbbD3DSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 23:18:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:52032 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751106AbbD3DSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 23:18:44 -0400
Received: (qmail 6075 invoked by uid 102); 30 Apr 2015 03:18:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 22:18:44 -0500
Received: (qmail 1396 invoked by uid 107); 30 Apr 2015 03:19:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 23:19:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 23:18:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fsu4d1x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268052>

On Wed, Apr 29, 2015 at 06:31:22PM -0700, Junio C Hamano wrote:

> > would yield:
> >
> >  (1)   100644 8
> >        content
> >  (2)   040000 3
> >        foo
> >  (3)   040000 6
> >        ../foo
> [...]
> 
> s/040000/160000/ I would think (if you really meant to expose a
> tree, write it as 40000 instead, so that people will not get a wrong
> impression and reimplement a broken tree object encoding some popular
> Git hosting site broke their customer projects with ;-).

Whooops. Yes, definitely 160000. That's what I get for not
double-checking. :)

-Peff
