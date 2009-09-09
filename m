From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message
 configurable
Date: Wed, 9 Sep 2009 07:22:36 -0400
Message-ID: <20090909112236.GA30303@coredump.intra.peff.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>
 <20090906064816.GC28941@coredump.intra.peff.net>
 <7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
 <20090906072322.GA29949@coredump.intra.peff.net>
 <7vzl98fr22.fsf@alter.siamese.dyndns.org>
 <20090907094457.6117@nanako3.lavabit.com>
 <20090907082430.GA17997@coredump.intra.peff.net>
 <vpqeiqjf90u.fsf@bauges.imag.fr>
 <20090907085405.GA17968@coredump.intra.peff.net>
 <4AA6A7A9.3080908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Uri Okrent <uokrent@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 13:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlLGB-0006LD-Ok
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 13:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZIILWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 07:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbZIILWi
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 07:22:38 -0400
Received: from peff.net ([208.65.91.99]:48582 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbZIILWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 07:22:38 -0400
Received: (qmail 27892 invoked by uid 107); 9 Sep 2009 11:22:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Sep 2009 07:22:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 07:22:36 -0400
Content-Disposition: inline
In-Reply-To: <4AA6A7A9.3080908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128059>

On Tue, Sep 08, 2009 at 11:51:21AM -0700, Uri Okrent wrote:

> I know that by default I'd like to see new messages, and in case I'm
> doing something adventurous I'd like to see a message I may not have
> seen before. If I had turned off all messages because I got sick of
> seeing one or two in particular, then I'd never know.

Yeah, I think the 'advice.all' option, while clever, is not really
helping anyone. In my revised series, I am just omitting entirely (but
the code is still structured that adding it later would be very easy if
we change our minds).

> P.S. I never really introduced myself to the list... Uri Okrent here
> from L.A. Keep up the great work everyone!

Welcome. :)

-Peff
