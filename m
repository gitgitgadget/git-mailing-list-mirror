From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Do not strip empty lines / trailing spaces from a
 commit message template
Date: Thu, 11 Mar 2010 17:46:56 -0500
Message-ID: <20100311224656.GA25553@sigill.intra.peff.net>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
 <20100311083148.GA13786@sigill.intra.peff.net>
 <7vaaueziv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 23:47:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npr9n-00038s-EO
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 23:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab0CKWrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 17:47:00 -0500
Received: from peff.net ([208.65.91.99]:60570 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710Ab0CKWq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 17:46:59 -0500
Received: (qmail 4977 invoked by uid 107); 11 Mar 2010 22:47:23 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 11 Mar 2010 17:47:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Mar 2010 17:46:56 -0500
Content-Disposition: inline
In-Reply-To: <7vaaueziv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142005>

On Thu, Mar 11, 2010 at 12:46:51PM -0800, Junio C Hamano wrote:

> > How about a test to check the new behavior?
> 
> Speaking of tests, t2203 will segfault with your patch.  I don't think the
> following does, though.

I thought I ran the tests, but obviously not. I see the segfault here.
It is not just t2203, but any "git commit" with no message will cause
it.

Your patch looks right, and is more readable, too, I think.

-Peff
