From: Jeff King <peff@peff.net>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 18:13:08 -0400
Message-ID: <20140424221308.GA15061@sigill.intra.peff.net>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
 <87lhuvb9kr.fsf@fencepost.gnu.org>
 <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
 <87tx9ia5zq.fsf@fencepost.gnu.org>
 <xmqq8uquv84u.fsf@gitster.dls.corp.google.com>
 <20140424213529.GB7815@sigill.intra.peff.net>
 <87lhuu9z69.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, d9ba@mailtor.net,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 00:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdRtT-000361-4b
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 00:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbaDXWNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 18:13:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:37873 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753869AbaDXWNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 18:13:10 -0400
Received: (qmail 13235 invoked by uid 102); 24 Apr 2014 22:13:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Apr 2014 17:13:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Apr 2014 18:13:08 -0400
Content-Disposition: inline
In-Reply-To: <87lhuu9z69.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247016>

On Thu, Apr 24, 2014 at 11:48:30PM +0200, David Kastrup wrote:

> > I really think the right solution here is to teach less to make it more
> > obvious that there is something worth scrolling over to. Here's a very
> > rough patch for less, if you want to see what I'm thinking of.
> 
> Still useless.  I'm not actually interested in a more prominent "I could
> be useful" indicator.

So don't set -S, then.

There are two questions here:

  1. Can less do a better job of indicating what's in the input when -S
     is in effect?

  2. What should get put into $LESS by default?

I was specifically addressing (1). Your comment does not help at all
there.

It could have an impact on (2), but you didn't say anything besides "I
don't like it". That doesn't add anything to the conversation.

-Peff
