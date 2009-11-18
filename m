From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 17:44:49 -0500
Message-ID: <20091118224448.GA4616@coredump.intra.peff.net>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
 <20091118142320.GA1220@coredump.intra.peff.net>
 <7vaayjebu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 23:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAtGt-0000YQ-Ef
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 23:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618AbZKRWor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 17:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756402AbZKRWoq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 17:44:46 -0500
Received: from peff.net ([208.65.91.99]:46019 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbZKRWop (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 17:44:45 -0500
Received: (qmail 32754 invoked by uid 107); 18 Nov 2009 22:48:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Nov 2009 17:48:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2009 17:44:49 -0500
Content-Disposition: inline
In-Reply-To: <7vaayjebu5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133204>

On Wed, Nov 18, 2009 at 01:56:34PM -0800, Junio C Hamano wrote:

> On black-on-white terminals, cyan tends to be less visible, and I think
> that is the whole point of painting the hunk header @@ .. @@ in that
> color--- make it less distracting).

Hmm. I find cyan-on-white gratingly ugly instead of "less distracting",
but then again, I find black-on-white terminals to be eye-searing in
general.

> I would suggest "normal" as the neutral default.  After all, the purpose
> of the funcname in the hunk header is to give context to people who read
> patches.

I think that is sensible.

-Peff
