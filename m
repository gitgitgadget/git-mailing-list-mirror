From: Jeff King <peff@peff.net>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 00:36:54 -0500
Message-ID: <20110111053653.GB10094@sigill.intra.peff.net>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <7vmxnc48yt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 06:37:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcWuj-0005zE-RU
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 06:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab1AKFg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 00:36:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37305 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117Ab1AKFg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 00:36:56 -0500
Received: (qmail 11342 invoked by uid 111); 11 Jan 2011 05:36:56 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 05:36:56 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 00:36:54 -0500
Content-Disposition: inline
In-Reply-To: <7vmxnc48yt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164909>

On Fri, Jan 07, 2011 at 02:58:34PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   2. Should clone fetch refs from refs/replace (either by default, or
> >      with an option)?
> > ...
> > Which leads to the second question. It is basically a matter of saying
> > "do you want to fetch the view that upstream has"? I can definitely see
> > that being useful, and meriting an option. However, it may or may not be
> > worth turning on by default, as upstream's view may be confusing.
> 
> I think that should be stated a bit differently.  "Do you want to fetch
> the view that the upstream offers as an option, and if you want, which
> ones (meaning: there could be more than one replacement grafts to give
> different views)?"

Sure, I think that is a sane way for the user to think about it, but do
we actually support multiple views? I thought replacement objects were
all or nothing.

-Peff
