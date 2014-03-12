From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2014, #02; Tue, 11)
Date: Wed, 12 Mar 2014 16:03:49 -0400
Message-ID: <20140312200348.GB1816@sigill.intra.peff.net>
References: <xmqq7g80o05g.fsf@gitster.dls.corp.google.com>
 <20140312193509.GA1816@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:03:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpNc-0006fr-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbaCLUDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:03:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:38292 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751039AbaCLUDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:03:50 -0400
Received: (qmail 31703 invoked by uid 102); 12 Mar 2014 20:03:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 15:03:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 16:03:49 -0400
Content-Disposition: inline
In-Reply-To: <20140312193509.GA1816@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243976>

On Wed, Mar 12, 2014 at 03:35:09PM -0400, Jeff King wrote:

> On Tue, Mar 11, 2014 at 03:12:11PM -0700, Junio C Hamano wrote:
> 
> > * jk/warn-on-object-refname-ambiguity (2014-01-09) 6 commits
> [...]
> Having looked at it again, I really think it is not worth pursuing. The
> end goal is not that interesting, there is a lot of code introduced, and
> a reasonable chance of accidentally introducing regressions and/or
> making the code less maintainable.  Keeping the existing code (which
> just disables the check for cat-file) is probably the sanest course of
> action. We can do a similar thing for "rev-list --stdin" if we want, or
> we can wait until somebody complains.

Having said that, here are two follow-on patches. The first is an extra
cat-file cleanup, and the second adjusts "rev-list --stdin". I am on
the fence on both of them, so I will leave it up to your judgement.

  [1/2]: cat-file: restore warn_on_object_refname_ambiguity flag
  [2/2]: rev-list: disable object/refname ambiguity check with --stdin

-Peff
