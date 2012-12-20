From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2012, #05; Tue, 18)
Date: Thu, 20 Dec 2012 09:59:41 -0500
Message-ID: <20121220145941.GC27211@sigill.intra.peff.net>
References: <7v4njjf6fk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:00:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlhbN-0002Hd-8U
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab2LTO7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 09:59:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59675 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119Ab2LTO7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 09:59:43 -0500
Received: (qmail 9549 invoked by uid 107); 20 Dec 2012 15:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 10:00:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 09:59:41 -0500
Content-Disposition: inline
In-Reply-To: <7v4njjf6fk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211893>

On Tue, Dec 18, 2012 at 12:31:43PM -0800, Junio C Hamano wrote:

> * jk/error-const-return (2012-12-15) 2 commits
>  - silence some -Wuninitialized false positives
>  - make error()'s constant return value more visible
> 
>  Help compilers' flow analysis by making it more explicit that
>  error() always returns -1, to reduce false "variable used
>  uninitialized" warnings.
> 
>  This is still an RFC.

What's your opinion on this? The last round I posted (and what you have
in pu) is about as good as this technique is going to get. So it is
really a taste thing. On the one hand, I really like that it is not just
papering over the problem, but rather giving the compiler more data to
do its analysis. On the other hand, it makes the source kind of ugly.

I don't think there's a rush on it, but I'm just sifting through my
half-done topics.

-Peff
