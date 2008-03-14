From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t6000lib.sh: tr portability fix fix
Date: Fri, 14 Mar 2008 16:54:15 -0400
Message-ID: <20080314205415.GA17728@coredump.intra.peff.net>
References: <20080312213831.GJ26286@coredump.intra.peff.net> <47DAE469.7080409@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: armstrong.whit@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 14 21:54:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaGvZ-0004Vc-RR
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 21:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbYCNUyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 16:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755762AbYCNUyS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 16:54:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4802 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774AbYCNUyR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 16:54:17 -0400
Received: (qmail 29923 invoked by uid 111); 14 Mar 2008 20:54:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Mar 2008 16:54:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2008 16:54:15 -0400
Content-Disposition: inline
In-Reply-To: <47DAE469.7080409@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77281>

On Fri, Mar 14, 2008 at 03:47:37PM -0500, Brandon Casey wrote:

> This patch fixes things. If the dashdash notation is not portable, then
> backslashing each dash also works. i.e. '\-\-\-\-.. etc. but as you
> mentioned something like that is less readable, but possibly not as bad
> as a sed version.

It seems to work fine on Solaris with all versions of tr. I did just
blindly extend the '-' without thinking, though...I wonder if there are
systems that will get confused about it being a range. It might be
safer to just use sed anyway.

-Peff
