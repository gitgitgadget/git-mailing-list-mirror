From: Jeff King <peff@peff.net>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sat, 6 Oct 2012 14:30:26 -0400
Message-ID: <20121006183026.GA3644@sigill.intra.peff.net>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer>
 <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net>
 <7vvcenqx39.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 20:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZ97-0000ZK-8g
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 20:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab2JFSab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 14:30:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43117 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968Ab2JFSab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 14:30:31 -0400
Received: (qmail 9691 invoked by uid 107); 6 Oct 2012 18:31:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 14:31:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 14:30:26 -0400
Content-Disposition: inline
In-Reply-To: <7vvcenqx39.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207162>

On Sat, Oct 06, 2012 at 11:22:50AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Another option is to leave it with "-i" semantics in the meantime, which
> > are at least easy to explain: it is simply a shorthand for running "git
> > add -p && git commit". That may be inconsistent with other aspects of
> > commit, but people have (apparently) been happy with it, and there has
> > not been a rash of complaints.
> 
> Yeah, that would be the safest and possibly the sanest way forward.
> Did the documentation update patch by Conrad on the other subthread
> look sane to you?  I haven't read it very carefully yet.

I didn't notice any documentation patch, and I can't find one looking
through the archive. Do you have a link?

-Peff
