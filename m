From: Jeff King <peff@peff.net>
Subject: Re: [RFC - draft #2] List of proposed future changes that are
	backward incompatible
Date: Sun, 15 Feb 2009 22:20:35 -0500
Message-ID: <20090216032035.GA12235@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <7vskmff6fp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:22:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYu3Z-00064A-81
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbZBPDUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbZBPDUh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:20:37 -0500
Received: from peff.net ([208.65.91.99]:51848 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755729AbZBPDUh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:20:37 -0500
Received: (qmail 12649 invoked by uid 107); 16 Feb 2009 03:20:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 22:20:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 22:20:35 -0500
Content-Disposition: inline
In-Reply-To: <7vskmff6fp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110124>

On Sun, Feb 15, 2009 at 06:42:50PM -0800, Junio C Hamano wrote:

> * git-push to update the checked out branch will be refused by default
> 
>   Make "git push" into a repository to update the branch that is checked
>   out fail by default.  You can countermand this default by setting a
>   configuration variable in the receiving repository.
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

It might be too subtle that "checked out" here implies a non-bare
repository (that is, somebody might think the HEAD branch in their bare
repo is "checked out"). So you might want to specifically mention
non-bare in the summary.

> * make core.quotepath=false the default

I have a comment on this, but I'll put it in a new thread. ;P

-Peff
