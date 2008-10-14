From: Jeff King <peff@peff.net>
Subject: Re: View remote logs?
Date: Tue, 14 Oct 2008 04:10:26 -0400
Message-ID: <20081014081024.GA9344@coredump.intra.peff.net>
References: <20081014071907.GP16999@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 10:11:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpf0K-0000rK-DR
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 10:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbYJNIKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 04:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754361AbYJNIKb
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 04:10:31 -0400
Received: from peff.net ([208.65.91.99]:2951 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbYJNIKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 04:10:30 -0400
Received: (qmail 29509 invoked by uid 111); 14 Oct 2008 08:10:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 14 Oct 2008 04:10:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Oct 2008 04:10:26 -0400
Content-Disposition: inline
In-Reply-To: <20081014071907.GP16999@penguin.codegnome.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98173>

On Tue, Oct 14, 2008 at 12:19:07AM -0700, Todd A. Jacobs wrote:

> I've Googled around, and tried some experiments with likely-looking
> tools like git log, git diff, and git ls-remote, but they only seem to
> operate on the local repository. In particular, there doesn't seem to be
> an obvious way to view the commit logs on a remote repository without
> pulling it first.

Remember that pull is really "fetch + merge". So you can do just the
fetch part without affecting your local branches.

> On an intuitive level, it seems like "git log origin" would allow me to
> see what someone has committed to a remote repository so I can decide

It does. It just uses the remote tracking branch for "origin" instead of
contacting the remote.

> whether it's something I want to pull. Even something like "git diff
> HEAD origin" would let me know if there were changes I might want to
> pull before doing so.

And that works, too. Once fetched, you can use "origin" as you would any
other ref.

-Peff
