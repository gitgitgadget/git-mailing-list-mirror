From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/6] t6300: introduce test_date() helper
Date: Tue, 1 Sep 2015 18:41:35 -0400
Message-ID: <20150901224135.GH7862@sigill.intra.peff.net>
References: <cover.1441144343.git.john@keeping.me.uk>
 <8e869f362971a44bb1f40ca5fed98b658efaa0dd.1441144343.git.john@keeping.me.uk>
 <20150901223157.GE7862@sigill.intra.peff.net>
 <20150901224013.GJ30659@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:41:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWuFP-0001rb-TY
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbbIAWlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:41:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:53422 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752475AbbIAWlh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:41:37 -0400
Received: (qmail 31917 invoked by uid 102); 1 Sep 2015 22:41:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:41:37 -0500
Received: (qmail 6906 invoked by uid 107); 1 Sep 2015 22:41:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:41:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:41:35 -0400
Content-Disposition: inline
In-Reply-To: <20150901224013.GJ30659@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277067>

On Tue, Sep 01, 2015 at 11:40:13PM +0100, John Keeping wrote:

> > I notice we end up with rather long lines for some of these. Would:
> > 
> >   test_date "" <<-\EOF
> >   Mon Jul 3 17:18:43 2006 +0200
> >   Mon Jul 3 17:18:44 2006 +0200
> >   Mon Jul 3 17:18:45 2006 +0200
> >   EOF
> > 
> > be more readable?
> 
> We could just do:
> 
> 	test_date "" \
> 		"Tue Jul 4 01:18:43 2006 +0200" \
> 		"Tue Jul 4 01:18:44 2006 +0200" \
> 		"Tue Jul 4 01:18:45 2006 +0200"
> 
> I'm not entirely sure why I didn't now that I look at it!

Yeah, that also looks good, and is probably less confusing that the
here-doc.

-Peff
