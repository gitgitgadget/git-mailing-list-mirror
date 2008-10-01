From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2008, #05; Mon, 29)
Date: Tue, 30 Sep 2008 23:31:29 -0400
Message-ID: <20081001033129.GD24513@coredump.intra.peff.net>
References: <20080930183759.GF21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 05:32:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KksSC-0003Lk-9L
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 05:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYJADbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 23:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbYJADbc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 23:31:32 -0400
Received: from peff.net ([208.65.91.99]:4892 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbYJADbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 23:31:32 -0400
Received: (qmail 14129 invoked by uid 111); 1 Oct 2008 03:31:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Sep 2008 23:31:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 23:31:29 -0400
Content-Disposition: inline
In-Reply-To: <20080930183759.GF21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97189>

On Tue, Sep 30, 2008 at 11:37:59AM -0700, Shawn O. Pearce wrote:

> * mw/sendemail (Mon Sep 29 12:41:06 2008 -0500) 8 commits
>  - send-email: signedoffcc -> signedoffbycc, but handle both
>  - Docs: send-email: Create logical groupings for man text
>  - Docs: send-email: Remove unnecessary config variable description
>  - Docs: send-email: --chain_reply_to -> --[no-]chain-reply-to
>  - send-email: change --no-validate to boolean --[no-]validate
>  - Docs: send-email: Man page option ordering
>  - Docs: send-email usage text much sexier
>  - Docs: send-email's usage text and man page mention same options
> 
> This series has already gone through 3 iterations before I could
> start to carry it in-tree.  I haven't had a chance to read it yet
> myself, so its sitting around in `pu` for futher review.

I think today's revision is probably ready for 'next'.

> * pb/commit-where (Mon Sep 8 01:05:41 2008 +0200) 1 commit
>  + builtin-commit.c: show on which branch a commit was added
> 
> [jc: Tentatively kicked back to "still cooking" status after
>  Jeff voiced his annoyance.  I personally do not like making this
>  multi-line as Jeff suggested as an alternative (the message already
>  is too verbose to my taste).]
> 
> Agree with Junio.  Hence its still here.

Definitely leave this out of master for now. I think there is some good
discussion going on, and I am hoping to get comments on Andreas' or my
patches.

-Peff
