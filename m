From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 14:32:26 -0400
Message-ID: <20150430183226.GA2855@peff.net>
References: <20150430003750.GA4258@peff.net>
 <1430355983.14907.55.camel@ubuntu>
 <20150430011612.GA7530@peff.net>
 <1430358345.14907.62.camel@ubuntu>
 <20150430033725.GB12361@peff.net>
 <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
 <5541E3D4.7040207@alum.mit.edu>
 <1430417023.22711.8.camel@ubuntu>
 <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
 <1430418522.22711.22.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:32:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YntGE-0004HR-5Z
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 20:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbbD3Sc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 14:32:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:52390 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752651AbbD3Sc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 14:32:29 -0400
Received: (qmail 11556 invoked by uid 102); 30 Apr 2015 18:32:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 13:32:28 -0500
Received: (qmail 7672 invoked by uid 107); 30 Apr 2015 18:32:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 14:32:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2015 14:32:26 -0400
Content-Disposition: inline
In-Reply-To: <1430418522.22711.22.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268089>

On Thu, Apr 30, 2015 at 11:28:42AM -0700, David Turner wrote:

> On Thu, 2015-04-30 at 11:19 -0700, Junio C Hamano wrote:
> > David Turner <dturner@twopensource.com> writes:
> > 
> > > In no case did we do a ls-files command,...
> > 
> > "ls-tree -r" is what I would have imagined you would be using, as
> > somebody needs to have the full repository in order to resolve the
> > symbolic links _anyway_, and that somebody does not need to have a
> > checkout in order to do so.
> 
> Yes, they have the full repo, but we are only exploring a small fraction
> of it. ls-tree -r would require parsing the entire thing.

git ls-tree HEAD -- BUILD ?

-Peff
