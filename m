From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] post-receive-email: Set content-type and encoding in
 generated mail
Date: Thu, 30 Jul 2009 21:52:15 -0400
Message-ID: <20090731015215.GC11392@coredump.intra.peff.net>
References: <1248875304-13167-1-git-send-email-emmes@informatik.rwth-aachen.de>
 <20090729144610.GA5060@coredump.intra.peff.net>
 <20090730080206.GR31428@hebe.informatik.RWTH-Aachen.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fabian Emmes <emmes@informatik.rwth-aachen.de>
X-From: git-owner@vger.kernel.org Fri Jul 31 03:54:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWhKY-0001wz-BQ
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 03:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZGaBwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 21:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbZGaBwX
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 21:52:23 -0400
Received: from peff.net ([208.65.91.99]:35955 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbZGaBwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 21:52:19 -0400
Received: (qmail 23626 invoked by uid 107); 31 Jul 2009 01:54:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 30 Jul 2009 21:54:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jul 2009 21:52:15 -0400
Content-Disposition: inline
In-Reply-To: <20090730080206.GR31428@hebe.informatik.RWTH-Aachen.DE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124497>

On Thu, Jul 30, 2009 at 10:02:06AM +0200, Fabian Emmes wrote:

> thanks Teemu and Jeff for correcting the errors. Indeed I assumed that
> git log would always output UTF-8 and a "Content-Type" header would be
> valid on its own. The patch of Jeff solves my problem. I tested the
> results in mutt, kmail and thunderbird.

Great. Would you mind re-submitting the patch you tested with a
proper write-up in the commit message?

-Peff
