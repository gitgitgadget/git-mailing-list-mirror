From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 03:33:53 -0500
Message-ID: <20081112083353.GB3817@coredump.intra.peff.net>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081029171122.GA12167@sigill.intra.peff.net> <20081102123519.GA21251@atjola.homenet> <7vljw2yo93.fsf@gitster.siamese.dyndns.org> <20081103071420.GD10772@coredump.intra.peff.net> <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0BBt-0003Ei-J3
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbYKLId4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbYKLId4
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:33:56 -0500
Received: from peff.net ([208.65.91.99]:3406 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbYKLIdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:33:55 -0500
Received: (qmail 17791 invoked by uid 111); 12 Nov 2008 08:33:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:33:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:33:53 -0500
Content-Disposition: inline
In-Reply-To: <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100729>

On Mon, Nov 10, 2008 at 11:04:42PM -0500, Avery Pennarun wrote:

> Speaking just for myself, I would find this all a lot less confusing
> if "staged" were a refspec of some sort, not an option at all.
> 
>    git diff HEAD..STAGED
>    git diff STAGED..WORKTREE
>    git grep pattern STAGED HEAD sillybranch WORKTREE ^ignorebranch --
> path/to/files

I agree that such a thing is reasonably intuitive. I have thought about
"magic" refspecs before; my local git has an "EMPTY" refspec which
points to the empty tree for diffing. However, that was trivial to
implement (since it turns into a sha1), and yours is very hard (since
you will have to pass these "pretend" objects around).

So I think it is a neat idea, but I am not volunteering to work on it.
:)

-Peff
