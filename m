From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2009, #02; Sun, 11)
Date: Wed, 14 Oct 2009 00:24:17 -0400
Message-ID: <20091014042417.GA28795@coredump.intra.peff.net>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
 <20091012051442.GB23007@coredump.intra.peff.net>
 <7vmy3w9qdd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 06:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxvVO-0005XA-1p
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 06:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbZJNEY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 00:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbZJNEY4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 00:24:56 -0400
Received: from peff.net ([208.65.91.99]:60931 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbZJNEYz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 00:24:55 -0400
Received: (qmail 24128 invoked by uid 107); 14 Oct 2009 04:27:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 00:27:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 00:24:17 -0400
Content-Disposition: inline
In-Reply-To: <7vmy3w9qdd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130240>

On Mon, Oct 12, 2009 at 03:52:46PM -0700, Junio C Hamano wrote:

> > Hmm. I thought you wanted to re-order some of these for to put the
> > porcelain and short formats into v1.6.6, but leave the status switchover
> > for v1.7.0.
> 
> We could build an alternate history between 3fa509d..46b77a6, revert the
> merges 9558627 and 65c8513, and merge the alternate history.  But is the
> short format support so solid that it deserves to be in 1.6.6 in the
> current shape?

Somewhere I seem to recall you saying that it would be nice to give the
--short format some wider exposure as "git status --short" before making
the "status is no longer commit --dry-run" switch-over. But now I can't
find that message anywhere.

Let's not worry about it.

-Peff
