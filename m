From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cache.h: move remote/connect API out of it
Date: Tue, 9 Jul 2013 00:21:06 -0400
Message-ID: <20130709042106.GC27903@sigill.intra.peff.net>
References: <7v1u78zrko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 06:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwPQQ-0000pJ-KL
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 06:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920Ab3GIEVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 00:21:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:35234 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725Ab3GIEVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 00:21:09 -0400
Received: (qmail 1407 invoked by uid 102); 9 Jul 2013 04:22:24 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Jul 2013 23:22:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 00:21:06 -0400
Content-Disposition: inline
In-Reply-To: <7v1u78zrko.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229906>

On Mon, Jul 08, 2013 at 02:09:59PM -0700, Junio C Hamano wrote:

> The definition of "struct ref" in "cache.h", a header file so
> central to the system, always confused me.  This structure is not
> about the local ref used by sha1-name API to name local objects.
> [...]
>  * I hate to to this kind of code-movement in the middle of the
>    cycle, but every time I follow the push->transport codepath, I
>    become disoriented by these "struct ref"s.

FWIW, this has often bugged me, too. I did not check what fallouts this
will have for series in flight, but in general, I think it is a good
thing to be doing.

-Peff
