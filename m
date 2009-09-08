From: Jeff King <peff@peff.net>
Subject: Re: Improving merge failure message
Date: Tue, 8 Sep 2009 03:51:56 -0400
Message-ID: <20090908075156.GA19294@coredump.intra.peff.net>
References: <20090908153101.6117@nanako3.lavabit.com>
 <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
 <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0909080020i3daa92aar952fc5102df62bdb@mail.gmail.com>
 <7vk509ev20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkvUk-0007be-V1
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbZIHHv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbZIHHv5
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:51:57 -0400
Received: from peff.net ([208.65.91.99]:44282 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbZIHHv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 03:51:57 -0400
Received: (qmail 21578 invoked by uid 107); 8 Sep 2009 07:52:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Sep 2009 03:52:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2009 03:51:56 -0400
Content-Disposition: inline
In-Reply-To: <7vk509ev20.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127987>

On Tue, Sep 08, 2009 at 12:48:23AM -0700, Junio C Hamano wrote:

> Thanks, very true indeed.  "It would be clobbered if we were to continue
> hence we abort." is how we want to explain our behaviour, so "would" is
> definitely better here.

While we're picking apart your wording, is "clobbered" the word we want
to use? Everywhere else that is user-facing we tend to use the term
"overwritten".

-Peff
