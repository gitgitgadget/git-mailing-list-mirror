From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0005: work around strange $? in ksh when program
 terminated by a signal
Date: Fri, 9 Jul 2010 07:53:48 -0400
Message-ID: <20100709115348.GB5740@sigill.intra.peff.net>
References: <20100709030812.GA16877@dert.cs.uchicago.edu>
 <4C36CA2C.5050305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 13:53:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXC9S-0007bb-VN
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 13:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab0GILxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 07:53:51 -0400
Received: from peff.net ([208.65.91.99]:60775 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817Ab0GILxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 07:53:50 -0400
Received: (qmail 20939 invoked by uid 107); 9 Jul 2010 11:54:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 09 Jul 2010 07:54:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jul 2010 07:53:48 -0400
Content-Disposition: inline
In-Reply-To: <4C36CA2C.5050305@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150655>

On Fri, Jul 09, 2010 at 09:05:16AM +0200, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> ksh is known to report $? of programs that terminated by a signal as
> 256 + signal number instead of 128 + signal number like other POSIX
> compliant shells. (ksh's behavior is still POSIX compliant in this regard.)

Thanks, that fix looks good to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
