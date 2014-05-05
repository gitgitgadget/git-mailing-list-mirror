From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Revert "make error()'s constant return value more
 visible"
Date: Mon, 5 May 2014 02:29:31 -0400
Message-ID: <20140505062931.GA9311@sigill.intra.peff.net>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-2-git-send-email-felipe.contreras@gmail.com>
 <20140505054901.GA19331@sigill.intra.peff.net>
 <5367257a857ce_2db613a731043@nysa.notmuch>
 <20140505060202.GA27360@sigill.intra.peff.net>
 <53672c53f2ed9_2e86acd30c6e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhtK-0005Yp-3I
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbaEEG3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 02:29:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:45111 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754473AbaEEG3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 02:29:33 -0400
Received: (qmail 24569 invoked by uid 102); 5 May 2014 06:29:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 01:29:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 02:29:31 -0400
Content-Disposition: inline
In-Reply-To: <53672c53f2ed9_2e86acd30c6e@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248122>

On Mon, May 05, 2014 at 01:14:43AM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > On Mon, May 05, 2014 at 12:45:30AM -0500, Felipe Contreras wrote:
> > 
> > > Jeff King wrote:
> > > > On Sun, May 04, 2014 at 01:12:53AM -0500, Felipe Contreras wrote:
> > > > 
> > > > > So it looks like gcc is smarter now, and in trying to fix a few warnings
> > > > > we generated hundreds more.
> > > > > 
> > > > > This reverts commit e208f9cc7574f5980faba498d0aa30b4defeb34f.
> > > > 
> > > > And now we've gone the other way, and re-enabled the initial warnings.
> > > > Can we come up with a solution that helps both cases?
> > > 
> > > What initial warnings? As I explained already I don't get any warnings
> > > with this patch series in gcc 4.9.0.
> > 
> > The "few warnings" in your statement quoted above.
> > 
> > You could try reading the commit message of the commit you are
> > reverting, which explains it, but the short answer is: try compiling
> > with -O3.
> 
> Sigh. And I'm the one with the abrasive style of communication.

I apologize if that seemed abrasive. I am slightly annoyed that you
seemed to be reverting my commit without understanding (or dealing with)
the problem that the original fixed.

But I was _also_ trying to point you in the right direction by directing
you to -O3. Do you see the problem now?  And did you look at the
follow-up patch I sent?

-Peff
