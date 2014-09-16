From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body
 headers
Date: Tue, 16 Sep 2014 16:29:03 -0400
Message-ID: <20140916202903.GB31398@peff.net>
References: <20140913225713.GB189120@vauxhall.crustytoothpaste.net>
 <20140914004725.GA28010@peff.net>
 <CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
 <20140914010120.GA28498@peff.net>
 <20140914013038.GA5974@peff.net>
 <xmqqha087lwv.fsf@gitster.dls.corp.google.com>
 <xmqq1trc63o8.fsf@gitster.dls.corp.google.com>
 <20140916001948.GC5019@peff.net>
 <xmqqy4tj30ny.fsf@gitster.dls.corp.google.com>
 <xmqq38br2yt7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:29:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzN9-0001HR-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbaIPU3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:29:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:49127 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752342AbaIPU3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:29:06 -0400
Received: (qmail 32727 invoked by uid 102); 16 Sep 2014 20:29:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Sep 2014 15:29:05 -0500
Received: (qmail 2311 invoked by uid 107); 16 Sep 2014 20:29:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Sep 2014 16:29:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Sep 2014 16:29:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38br2yt7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257184>

On Tue, Sep 16, 2014 at 11:41:08AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> I think you forgot to "git add" mbox.h. That being said, if we did go
> >> this route, I do not see any reason to share the code at all. This can
> >> be purely a mailinfo.c thing.
> >
> > OK.  A reroll coming today when I find time.
> 
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Sat, 13 Sep 2014 21:30:38 -0400
> Subject: [PATCH] mailinfo: make ">From" in-body header check more robust
>[...]

This looks good to me. Thanks.

-Peff
