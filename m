From: Jeff King <peff@peff.net>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 13:52:20 -0400
Message-ID: <20080819175220.GA10142@coredump.intra.peff.net>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:53:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVOr-0001Er-FB
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 19:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbYHSRwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 13:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYHSRwX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:52:23 -0400
Received: from peff.net ([208.65.91.99]:3259 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbYHSRwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 13:52:22 -0400
Received: (qmail 2870 invoked by uid 111); 19 Aug 2008 17:52:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Aug 2008 13:52:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 13:52:20 -0400
Content-Disposition: inline
In-Reply-To: <7vy72tit90.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92887>

On Mon, Aug 18, 2008 at 08:22:19PM -0700, Junio C Hamano wrote:

> I do not know if I like the end result, but here is a patch to make the
> traditional a/ and b/ prefix more mnemonic.

Hmm. Something deep in my gut doesn't like this, just because I like the
fact that no matter how I prepare a diff (and I do tend to do it
different ways and post to the mailing list) it always ends up the same.
For example, I sometimes "hand-generate" patch messages meant to be
applied by git-am by doing a diff between the working tree and index and
pasting the result into an email. It just feels a bit wrong for it not
to be the exact output I would get from commiting and running
format-patch.

And yes, obviously the prefix should be thrown away by am (and any sane
tools), so it shouldn't matter. So I don't think there is a technical
reason not to do so.  But one of the things I have always liked about
git is that no matter how I prepare content, the output is always the
same.

But maybe this is just me being a curmudgeonly old-timer. Feel free to
ignore.

-Peff
