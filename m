From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/6] "git commit --dry-run" updates
Date: Mon, 17 Aug 2009 21:16:25 +0200
Message-ID: <200908172116.26737.trast@student.ethz.ch>
References: <1250330803-22171-1-git-send-email-gitster@pobox.com> <200908171201.43343.trast@student.ethz.ch> <7vljlixwkz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:20:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7hZ-0006Ol-V6
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbZHQTQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 15:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZHQTQ5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:16:57 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:53120 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbZHQTQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 15:16:46 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 17 Aug
 2009 21:16:45 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 17 Aug
 2009 21:16:45 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7vljlixwkz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126254>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > If it's not too much work, it would be nice to somehow detect if -u
> > can have any influence at all.  For example,
> >
> >   $ git status bar
> >   # Not currently on any branch.
> >   nothing to commit (use -u to show untracked files)
> >
> > is a bit misleading if 'bar' is tracked because adding a -u won't make
> > any difference.
[...]
> It is not about "we know that there are untracked files but you told me
> not to show it, so I am not telling".  We simply do not know at the point
> we give that message.  In other words, conditional removal of that message
> is fundamentally incompatible with the use of -uno.

Ok.  I hoped there would be an easy way to know that all pathspecs
exactly matched a tracked file, and thus no untracked files can
possibly change the listing.

But you convinced me that it doesn't fit into the current scheme, and
it doesn't really matter...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
