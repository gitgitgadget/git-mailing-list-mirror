From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 16 May 2007 07:18:57 -0400
Message-ID: <20070516111857.GD30256@coredump.intra.peff.net>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk> <20070514183931.GC23090@fieldses.org> <20070515042200.GA10884@coredump.intra.peff.net> <20070515045044.GB2805@fieldses.org> <20070515050808.GA11745@coredump.intra.peff.net> <20070515152457.GC6794@fieldses.org> <20070515153513.GA26944@coredump.intra.peff.net> <7vabw6j5db.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 13:19:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoHX7-0002I9-O4
	for gcvg-git@gmane.org; Wed, 16 May 2007 13:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247AbXEPLTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 07:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757429AbXEPLTA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 07:19:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3465 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756247AbXEPLS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 07:18:59 -0400
Received: (qmail 14159 invoked from network); 16 May 2007 11:18:59 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 May 2007 11:18:59 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2007 07:18:57 -0400
Content-Disposition: inline
In-Reply-To: <7vabw6j5db.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47434>

On Tue, May 15, 2007 at 11:42:24AM -0700, Junio C Hamano wrote:

> > +				"MIME-Version: 1.0\n"
> Thanks; I think this is a sane thing to do.

Do you want me to work up a commit message, or do you just want to
assemble it from my other discussion?

BTW, I also checked for other places where we generate a content-type.
The only other place I found was when we do multipart/mixed
(log-tree.c:209), but we correctly generate the MIME-Version header
there.

-Peff
