From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sun, 10 Jun 2007 18:22:29 -0400
Message-ID: <20070610222229.GA28264@coredump.intra.peff.net>
References: <11813427591137-git-send-email-krh@redhat.com> <7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net> <20070610221306.GF27340@coredump.intra.peff.net> <7vzm375u7f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 00:22:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxVny-0004Wc-FK
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 00:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759489AbXFJWWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 18:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760535AbXFJWWc
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 18:22:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3484 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759489AbXFJWWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 18:22:31 -0400
Received: (qmail 23866 invoked from network); 10 Jun 2007 22:22:43 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 10 Jun 2007 22:22:43 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Jun 2007 18:22:29 -0400
Content-Disposition: inline
In-Reply-To: <7vzm375u7f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49782>

On Sun, Jun 10, 2007 at 03:19:00PM -0700, Junio C Hamano wrote:

> > This is the same git-send-email bug that we fixed recently (missing
> > MIME-Version header). Just look for the vger "we munged your message"
> > headers in the version you received.
> 
> Ahh.  You are right.  The message does have these:

Yes, it's easy for me to tell because I get his messages intact. :) Not
to mention his X-Mailer mentions git-send-email 1.5.0.6.

Kristian, the fix is in git 1.5.1.5 and later, if it's not too much
trouble to upgrade.

-Peff
