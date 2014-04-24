From: Jeff King <peff@peff.net>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 18:02:41 -0400
Message-ID: <20140424220241.GC7815@sigill.intra.peff.net>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
 <87lhuvb9kr.fsf@fencepost.gnu.org>
 <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
 <87tx9ia5zq.fsf@fencepost.gnu.org>
 <xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
 <20140424213529.GB7815@sigill.intra.peff.net>
 <xmqq4n1iv1re.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, d9ba@mailtor.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 00:03:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdRjX-0005JR-0n
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 00:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbaDXWDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 18:03:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:37857 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756198AbaDXWCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 18:02:43 -0400
Received: (qmail 12163 invoked by uid 102); 24 Apr 2014 22:02:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Apr 2014 17:02:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Apr 2014 18:02:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4n1iv1re.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247013>

On Thu, Apr 24, 2014 at 02:47:01PM -0700, Junio C Hamano wrote:

> And I do agree that the "chopped marker" would be a very sensible
> thing to show in the "-S" output; I would have chosen "$" myself for
> that to match an existing practice in (setq truncate-lines t) in
> Emacs, though.

Hmm. I do not use Emacs, but I explicitly avoided "$" because of its
end-of-line connotations. E.g., in "cat -A" it means the opposite: this
is the real "\n" end-of-line. But if there's existing precedent for "$",
that would be fine with me.

-Peff
