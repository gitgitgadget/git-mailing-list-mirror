From: Jeff King <peff@peff.net>
Subject: Re: Please support add -p with a new file, to add only part of the
 file
Date: Tue, 10 Jan 2012 14:38:57 -0500
Message-ID: <20120110193857.GA19665@sigill.intra.peff.net>
References: <20120109105134.1239.39047.reportbug@leaf>
 <20120109204721.GC23825@burratino>
 <87ty43fy7f.fsf@thomas.inf.ethz.ch>
 <7vpqer9znv.fsf@alter.siamese.dyndns.org>
 <20120110183833.GA15787@sigill.intra.peff.net>
 <7vd3ar9wto.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Wincent Colaiuta <win@wincent.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:39:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkhXE-0007Za-7i
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175Ab2AJTi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:38:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33911
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756349Ab2AJTi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:38:59 -0500
Received: (qmail 13401 invoked by uid 107); 10 Jan 2012 19:45:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 14:45:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 14:38:57 -0500
Content-Disposition: inline
In-Reply-To: <7vd3ar9wto.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188286>

On Tue, Jan 10, 2012 at 11:33:39AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Even if you start with "add -N", there won't be individual "hunks" you can
> >> pick and choose from diffing emptiness and the whole new file, so you end
> >> up using "edit hunk" interface.
> >
> > I don't think the main impetus for this is that people necessarily want
> > to pick and choose hunks from added files.
> 
> Well, read the subject of your e-mail and tell me what it says ;-)

Heh. Oops.

Yes, I agree that "add -p" is not especially useful for that case, and
the workflow I was describing is very different[1].

Sorry for the noise.

-Peff

[1] For the record, I _do_ find myself using "git add -N" so that new
    files can be part of my "git add -p" workflow. So that feature is
    working as intended. It would save me a little bit of effort,
    though, if I could tell git I also want to include untracked files
    during the "-p" session, and dispense with the earlier "add -N".

    I'd also find it useful to mark conflicts as resolved, but I think
    we discussed that once before and you brought up some ugly corner
    cases.
