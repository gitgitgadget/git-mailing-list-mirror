From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] fetch: don't try to update unfetched tracking refs
Date: Mon, 27 May 2013 12:35:00 -0400
Message-ID: <20130527163500.GA18405@sigill.intra.peff.net>
References: <9c6fd36368cd6b0fba4855be4d31106781c02f58.1369654825.git.john@keeping.me.uk>
 <20130527154252.GB8250@sigill.intra.peff.net>
 <20130527160129.GN27005@serenity.lan>
 <20130527161934.GB9235@sigill.intra.peff.net>
 <20130527163308.GO27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 27 18:35:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh0O7-0005H3-6d
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab3E0QfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:35:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:45041 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab3E0QfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:35:04 -0400
Received: (qmail 1053 invoked by uid 102); 27 May 2013 16:35:41 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 May 2013 11:35:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 May 2013 12:35:00 -0400
Content-Disposition: inline
In-Reply-To: <20130527163308.GO27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225607>

On Mon, May 27, 2013 at 05:33:09PM +0100, John Keeping wrote:

> > Ah, I see. It is not "the refspec on the command-line does not match a
> > configured refspec", but rather "there exists a configured non-pattern
> > refspec that does not match what was on the command-line (even if what
> > was on the command-line did match another refspec)".
> 
> Exactly.  I've changed the commit message to (hopefully) make this
> clearer.

It does. To me, anyway. :)

Thanks again.

-Peff
