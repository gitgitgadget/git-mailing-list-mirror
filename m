From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Wed, 21 May 2014 13:59:30 -0400
Message-ID: <20140521175930.GA4588@sigill.intra.peff.net>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
 <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
 <20140520082740.GB27590@sigill.intra.peff.net>
 <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
 <20140520182443.GA30533@sigill.intra.peff.net>
 <xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
 <20140521164255.GA2040@sigill.intra.peff.net>
 <xmqq61kzqbi6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 19:59:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnAng-0000nx-QP
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 19:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbaEUR7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 13:59:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:56681 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752662AbaEUR7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 13:59:32 -0400
Received: (qmail 25823 invoked by uid 102); 21 May 2014 17:59:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 12:59:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 13:59:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61kzqbi6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249817>

On Wed, May 21, 2014 at 10:37:05AM -0700, Junio C Hamano wrote:

> > I wasn't planning on anything as drastic as stripspace. I really just
> > wanted to suppress the one newline, which is almost certainly the right
> > thing to include for "--signature", but the wrong thing for
> > "--signature-file" (i.e., the patch I posted earlier).
> > ...
> > I dunno. Maybe it is not worth caring too much about.
> 
> I suggested stripspace() because I know we do not care too
> much, actually.
> 
> Cleansing blank lines in one way for many types of user input
> (e.g. commit log messages and tag messages) while doing it in a
> completely different way just for "--signature-file" is warranted if
> there is a good reason for them to be different, but I did not think
> of any, and I still don't.  So...

I didn't think of mine as cleansing. It is more like "do not duplicate a
newline ourselves if there is already one there".  But I guess those are
two sides of the same coin.

-Peff
