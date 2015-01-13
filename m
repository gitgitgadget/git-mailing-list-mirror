From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] git-compat-util: add xstrdup_or_null helper
Date: Mon, 12 Jan 2015 21:23:36 -0500
Message-ID: <20150113022336.GA3927@peff.net>
References: <20150113015427.GA5497@peff.net>
 <20150113015736.GA18986@peff.net>
 <20150113022119.GA29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 03:23:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAr8w-0006eU-DG
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 03:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbbAMCXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 21:23:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:33633 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753238AbbAMCXh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 21:23:37 -0500
Received: (qmail 20313 invoked by uid 102); 13 Jan 2015 02:23:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 20:23:37 -0600
Received: (qmail 22890 invoked by uid 107); 13 Jan 2015 02:23:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 21:23:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 21:23:36 -0500
Content-Disposition: inline
In-Reply-To: <20150113022119.GA29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262322>

On Mon, Jan 12, 2015 at 06:21:19PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -675,6 +675,11 @@ extern char *xgetcwd(void);
> >  
> >  #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), (alloc) * sizeof(*(x)))
> >  
> > +static inline char *xstrdup_or_null(const char *str)
> > +{
> > +	return str ? xstrdup(str) : NULL;
> > +}
> 
> Would it make sense for xstrdup to always include the NULL check,
> avoiding the need for the more verbose xstrdup_or_null?

Read the rest of the thread. :)

-Peff
