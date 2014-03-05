From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Wed, 5 Mar 2014 13:52:12 -0500
Message-ID: <20140305185212.GA23907@sigill.intra.peff.net>
References: <20140304174806.GA11561@sigill.intra.peff.net>
 <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
 <20140305005649.GB11509@sigill.intra.peff.net>
 <xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLGvT-0000RR-8B
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700AbaCESwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 13:52:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:33557 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756674AbaCESwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:52:14 -0500
Received: (qmail 17218 invoked by uid 102); 5 Mar 2014 18:52:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 12:52:14 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 13:52:12 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243462>

On Wed, Mar 05, 2014 at 10:49:24AM -0800, Junio C Hamano wrote:

> > Perhaps the right response is "grafts are broken, use git-replace
> > instead". But then should we think about deprecating grafts?
> 
> I am sort of surprised to hear that question, actually ;-)
> 
> I didn't say that in the message you are responding to because I
> somehow thought that everybody has been in agreement with these two
> lines for a long while.  Ever since I suggested the "replace" as an
> alternative "grafts done right" and outlined how it should work to
> Christian while sitting next to him in one of the early GitTogether,
> the plan, at least in my mind, has always been exactly that: grafts
> were a nice little attempt but is broken---if you really wanted to
> muck with the history without rewriting (which is still discouraged,
> by the way), do not use "graft", but use "replace".

I certainly had in the back of my mind that grafts were a lesser form of
"replace", and that eventually we could get rid of the former. Perhaps
my question should have been: "why haven't we deprecated grafts yet?".

-Peff
