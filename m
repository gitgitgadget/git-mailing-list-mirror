From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] CodingGuidelines: on comparison
Date: Thu, 1 May 2014 17:36:57 -0400
Message-ID: <20140501213657.GC14441@sigill.intra.peff.net>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
 <1398894312-30763-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 01 23:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfyfB-0004Ts-Kj
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 23:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbaEAVhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 17:37:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:43128 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751970AbaEAVg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 17:36:59 -0400
Received: (qmail 15557 invoked by uid 102); 1 May 2014 21:36:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 May 2014 16:36:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2014 17:36:57 -0400
Content-Disposition: inline
In-Reply-To: <1398894312-30763-8-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247886>

On Wed, Apr 30, 2014 at 02:45:11PM -0700, Junio C Hamano wrote:

> See http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=4126
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Don't you often complain about submitters referencing a discussion
in a commit message without providing some context or summary?

> + - There are two schools of thought when it comes to comparison,
> +   especially inside a loop. Some people prefer to have less stable
> +   value on the left hand side and more stable value on the right hand
> +   side, e.g. if you have a loop that counts variable i down to the
> +   lower bound,

Grammar: /(less|more) stable/the &/

> +   Both are valid, and we use both, even though we tend to see the
> +   former the more preferable, the more "stable" the more stable side
> +   becomes (comparison with a constant, "i > 0", is an extreme
> +   example).  Just do not mix styles in the same part of the code.
> +

I had trouble parsing the first sentence. Maybe:

  Both are valid, and we use both. However, the more "stable" the stable
  side becomes, the more we tend to prefer the former (comparison with a
  constant[...]

-Peff
