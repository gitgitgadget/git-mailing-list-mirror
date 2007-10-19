From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Fri, 19 Oct 2007 08:27:56 -0400
Message-ID: <20071019122755.GA17002@coredump.intra.peff.net>
References: <20071019090400.GA8944@coredump.intra.peff.net> <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dan McGee <dan@archlinux.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 14:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiqxX-0002ve-5T
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 14:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060AbXJSM17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 08:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757399AbXJSM17
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 08:27:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2405 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbXJSM16 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 08:27:58 -0400
Received: (qmail 12427 invoked by uid 111); 19 Oct 2007 12:27:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 08:27:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 08:27:56 -0400
Content-Disposition: inline
In-Reply-To: <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61696>

On Fri, Oct 19, 2007 at 07:10:42AM -0500, Dan McGee wrote:

> Hmm. For some reason this passes with your test case, but not with my
> original bash test script[1]. Did you try it with this?
>
> [1] http://www.toofishes.net/uploads/

[please trim quoted text; I had a hard time finding your message amidst
the patch]

I didn't try it until you sent your message, but your test seems to work
fine for me. My patch is on top of 'next', which is what I usually run.
I haven't looked into 'master' (I assumed since the bug was reproducible
in both, it would be the same in both, but that is perhaps not the
case).

-Peff
