From: Jeff King <peff@peff.net>
Subject: Re: git quietly fails on https:// URL, https errors are never
 reported to user
Date: Fri, 17 Jan 2014 15:18:58 -0500
Message-ID: <20140117201858.GA3362@sigill.intra.peff.net>
References: <52D7D017.107@rawbw.com>
 <20140116180310.GA27180@sigill.intra.peff.net>
 <52D8FAA6.1010601@rawbw.com>
 <xmqqmwiuwg0o.fsf@gitster.dls.corp.google.com>
 <20140117201325.GB775@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yuri <yuri@rawbw.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 21:19:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Fsg-00059r-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbaAQUTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 15:19:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:34371 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752940AbaAQUTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:19:00 -0500
Received: (qmail 29660 invoked by uid 102); 17 Jan 2014 20:19:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jan 2014 14:19:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jan 2014 15:18:58 -0500
Content-Disposition: inline
In-Reply-To: <20140117201325.GB775@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240627>

On Fri, Jan 17, 2014 at 03:13:25PM -0500, Jeff King wrote:

> On Fri, Jan 17, 2014 at 11:43:35AM -0800, Junio C Hamano wrote:
> 
> > Yuri <yuri@rawbw.com> writes:
> > 
> > > I think that in a rare case of error this extra-printout wouldn't
> > > hurt.
> > 
> > If the "error is rare, extra verbiage does not hurt" were a valid
> > attitude, "error is rare, non-zero exit is enough" would be equally
> > valid ;-)
> 
> I think the problem is that error is _not_ rare. For years, we did not
> print the extra verbiage, and nobody complained. Then, within days of us
> making a release that included the extra line, somebody complained[1].

Forgot my footnote here, but it was:

  http://article.gmane.org/gmane.comp.version-control.git/228498

which led to 266f1fd (transport-helper: be quiet on read errors from
helpers, 2013-06-21).

-Peff
