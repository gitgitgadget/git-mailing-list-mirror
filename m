From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] bisect: improve output when bad commit is found
Date: Wed, 13 May 2015 17:42:29 -0400
Message-ID: <20150513214228.GA17350@peff.net>
References: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
 <20150513005432.GF31257@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqoalpcm9f.fsf@gitster.dls.corp.google.com>
 <20150513013637.GB3066@peff.net>
 <CAP8UFD14LuyaVcoNHxR00ZeGgHWXbuW_QdVf4YqZWzgMdufUjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Trevor Saunders <tbsaunde@tbsaunde.org>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 23:42:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YseQL-0007a3-8N
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 23:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965424AbbEMVmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 17:42:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:58230 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933971AbbEMVmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 17:42:36 -0400
Received: (qmail 19762 invoked by uid 102); 13 May 2015 21:42:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 16:42:36 -0500
Received: (qmail 16914 invoked by uid 107); 13 May 2015 21:42:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 17:42:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 17:42:29 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD14LuyaVcoNHxR00ZeGgHWXbuW_QdVf4YqZWzgMdufUjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269010>

On Wed, May 13, 2015 at 11:39:41AM +0200, Christian Couder wrote:

> > It is not clear to me that people are actually scripting around the
> > output. Between the exit code and the stable output in BISECT_LOG, that
> > seems like a much more preferable way for scripted uses to find out what
> > happened.
> >
> > Of course, that is not a guarantee that nobody scraped stderr, but at
> > least it makes me feel better that they're Doing It Wrong. :)
> 
> Aren't we sending the "XXXX is the first bad commit" and the diff-tree
> to stdout?

Good point. I'm much more sympathetic to people scraping stdout than
stderr. I do still think we would do better to direct them to more
robust formats, though.

-Peff
