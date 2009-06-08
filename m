From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] enhancing builds on Solaris
Date: Mon, 8 Jun 2009 07:50:45 -0400
Message-ID: <20090608115045.GB13775@coredump.intra.peff.net>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:51:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDdNU-00084p-SW
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 13:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbZFHLux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 07:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754851AbZFHLux
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 07:50:53 -0400
Received: from peff.net ([208.65.91.99]:54787 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754815AbZFHLuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 07:50:52 -0400
Received: (qmail 21196 invoked by uid 107); 8 Jun 2009 11:51:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Jun 2009 07:51:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 07:50:45 -0400
Content-Disposition: inline
In-Reply-To: <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121064>

On Fri, Jun 05, 2009 at 06:36:08PM -0500, Brandon Casey wrote:

> Here is a re-roll of the work on Solaris which integrates the ideas from you
> and Jeff.  This should replace bc/solaris in pu.
> 
> This should allow compiling on Solaris with or without a c99 compiler,
> GCC or SUNWspro.
> 
> Solaris 7 should be able to compile when using GCC and bash.

With the exception of 7/8 (which I already complained about separately),
these look reasonable to me, and my setup still passes the same tests
(though that is perhaps not saying much, as I was already using gcc).

-Peff
