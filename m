From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 9 Nov 2010 11:08:33 -0500
Message-ID: <20101109160833.GA24975@sigill.intra.peff.net>
References: <9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org>
 <7vpqufpr7f.fsf@alter.siamese.dyndns.org>
 <4F75AA0C-B68A-4ABB-B67A-D7F62D989655@sb.org>
 <20101109051631.GA19867@sigill.intra.peff.net>
 <7v4obqo5dk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 17:07:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFqjh-00034k-UO
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 17:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab0KIQHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 11:07:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47041 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233Ab0KIQHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 11:07:38 -0500
Received: (qmail 7782 invoked by uid 111); 9 Nov 2010 16:07:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Nov 2010 16:07:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Nov 2010 11:08:33 -0500
Content-Disposition: inline
In-Reply-To: <7v4obqo5dk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161056>

On Tue, Nov 09, 2010 at 07:59:03AM -0800, Junio C Hamano wrote:

> > It seems to me the natural way to do that would be to use our existing
> > generic "start at this ref and follow some chain" syntax, which is
> > ref^{foo}. For example: origin/pu^{:Merge 'kb/blame-author-email'}.
> 
> Yeah, that may make more sense but I think the operation specifier should
> be '/', not ':', no?

Yeah, I don't know what I was thinking when I wrote the text above. It
should definitely be origin/pu^{/Merge...}.

-Peff
