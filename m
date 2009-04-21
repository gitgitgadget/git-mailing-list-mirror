From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and
	error-handling in send_message's sendmail code
Date: Mon, 20 Apr 2009 23:14:08 -0400
Message-ID: <20090421031408.GA18596@coredump.intra.peff.net>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com> <1240074128-16132-2-git-send-email-mfwitten@gmail.com> <1240074128-16132-3-git-send-email-mfwitten@gmail.com> <1240074128-16132-4-git-send-email-mfwitten@gmail.com> <1240074128-16132-5-git-send-email-mfwitten@gmail.com> <1240074128-16132-6-git-send-email-mfwitten@gmail.com> <7vljpwp0jr.fsf@gitster.siamese.dyndns.org> <7vfxg4nl0e.fsf@gitster.siamese.dyndns.org> <20090421020021.GA14479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 05:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw6SY-0005gZ-TT
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 05:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbZDUDOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 23:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbZDUDOO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 23:14:14 -0400
Received: from peff.net ([208.65.91.99]:54884 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbZDUDON (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 23:14:13 -0400
Received: (qmail 6275 invoked by uid 107); 21 Apr 2009 03:14:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Apr 2009 23:14:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 23:14:08 -0400
Content-Disposition: inline
In-Reply-To: <20090421020021.GA14479@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117083>

On Mon, Apr 20, 2009 at 10:00:21PM -0400, Jeff King wrote:

> I don't think that's right. perl581delta lists it in the "Future
> Directions" section and says
> 
>   A new operator "//" (defined-or) _will_ be available.

Bah, sorry for the noise. I didn't realize this was described with much
more detail in another thread (a pox on thread-breakers!):

  http://article.gmane.org/gmane.comp.version-control.git/117006

-Peff
