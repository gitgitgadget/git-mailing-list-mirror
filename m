From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] remote.c: silently tolerate single-level keys like
	remote.default
Date: Thu, 23 Apr 2009 16:01:37 -0400
Message-ID: <20090423200136.GA3056@coredump.intra.peff.net>
References: <1240494546-25775-1-git-send-email-j6t@kdbg.org> <20090423164008.GA26346@coredump.intra.peff.net> <200904232037.27095.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx58f-0008BY-Rp
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 22:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbZDWUBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbZDWUBm
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 16:01:42 -0400
Received: from peff.net ([208.65.91.99]:48873 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbZDWUBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 16:01:42 -0400
Received: (qmail 24614 invoked by uid 107); 23 Apr 2009 20:01:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Apr 2009 16:01:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2009 16:01:37 -0400
Content-Disposition: inline
In-Reply-To: <200904232037.27095.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117376>

On Thu, Apr 23, 2009 at 08:37:26PM +0200, Johannes Sixt wrote:

> >   + warn("Config with no key for remote %s", name);
> >   + return 0;
> 
> I don't like this. This would warn in a number of situations where it's not 
> obvious that remotes are involved, for example in 'git status'.

Ah, I didn't think of that (I didn't really look too closely into the
affected code, and you obviously have). So let me withdraw my comment.

-Peff
