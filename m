From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6 v3] Make git log --graph looks better with -p and
 other diff options
Date: Thu, 20 May 2010 23:50:08 -0400
Message-ID: <20100521035008.GA15924@coredump.intra.peff.net>
References: <1274406764-32278-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 05:50:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFJFj-0000v1-Lh
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 05:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab0EUDuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 23:50:13 -0400
Received: from peff.net ([208.65.91.99]:49480 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871Ab0EUDuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 23:50:12 -0400
Received: (qmail 22393 invoked by uid 107); 21 May 2010 03:50:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 20 May 2010 23:50:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 May 2010 23:50:09 -0400
Content-Disposition: inline
In-Reply-To: <1274406764-32278-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147430>

On Thu, May 20, 2010 at 06:52:38PM -0700, Bo Yang wrote:

> Thanks to Jeff, make --graph work well with --summary.

Ah, I see. My problem earlier was that show_mode_change only outputs
sometimes, so it needs to conditionally load the prefix.

Thanks, the output from this version looks good to me.

-Peff
