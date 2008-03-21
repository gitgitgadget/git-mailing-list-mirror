From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty.c: add %z specifier.
Date: Fri, 21 Mar 2008 00:51:37 -0400
Message-ID: <20080321045137.GA5563@coredump.intra.peff.net>
References: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com> <7veja4u1gv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZEs-0001Pl-0s
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYCUEvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYCUEvk
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:51:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4074 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbYCUEvk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:51:40 -0400
Received: (qmail 25102 invoked by uid 111); 21 Mar 2008 04:51:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 21 Mar 2008 00:51:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2008 00:51:37 -0400
Content-Disposition: inline
In-Reply-To: <7veja4u1gv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77712>

On Thu, Mar 20, 2008 at 09:48:16PM -0700, Junio C Hamano wrote:

> > +	case 'z':		/* null */
> > +		strbuf_addch(sb, '\0');
> > +		return 1;
> >  	}
> >
> >  	/* these depend on the commit */
> 
> I do not like this at all.  Why aren't we doing %XX (2 hexadecimal digits
> for an octet)?

Because %ad is already taken? :)

%x* is still available, though, so maybe %x00?

-Peff
