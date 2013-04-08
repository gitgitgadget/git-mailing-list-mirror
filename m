From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] decorate: add "clear_decoration()"
Date: Mon, 8 Apr 2013 17:09:03 -0400
Message-ID: <20130408210903.GC9649@sigill.intra.peff.net>
References: <7v1ual35xi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:09:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJJS-0005Ro-A5
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951Ab3DHVJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:09:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34279 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964875Ab3DHVJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:09:08 -0400
Received: (qmail 15408 invoked by uid 107); 8 Apr 2013 21:10:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 17:10:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 17:09:03 -0400
Content-Disposition: inline
In-Reply-To: <7v1ual35xi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220517>

On Sun, Apr 07, 2013 at 11:14:17PM -0700, Junio C Hamano wrote:

> So far, all the users of the decoration API used decoration that
> only grows and discarded at the end of the program execution.
> 
> Introduce for_each_decoration() that lets the caller iterate over
> all defined decorations and use it to implement clear_decoration()
> function.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Both this and the first patch look good to me. I had documented
api-decorate long ago as part of the cache-metadata-on-disk series (it
was built on generic maps, which I also refactored decorate on top of).
But I didn't see anything in my version that was missing from yours (in
fact, it was much sparser, because it just referred to the generic map
api, which we never merged).

Out of curiosity: where is the patch 3 that presumably led you to
wanting these?

-Peff
