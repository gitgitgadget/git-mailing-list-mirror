From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] wt-status: take advice.statusHints seriously
Date: Mon, 26 Apr 2010 15:10:12 -0400
Message-ID: <20100426191012.GA10772@coredump.intra.peff.net>
References: <c7003ec93f4ea01be80fbba08d2ed5544fa0df4d.1271968072.git.git@drmicha.warpmail.net>
 <86a4d8e5df80008c5c2b3ff4f2a5842ad1f58dc4.1271968072.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 26 21:10:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6ThH-0008FU-Ar
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 21:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab0DZTKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 15:10:16 -0400
Received: from peff.net ([208.65.91.99]:39215 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511Ab0DZTKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 15:10:15 -0400
Received: (qmail 13341 invoked by uid 107); 26 Apr 2010 19:10:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Apr 2010 15:10:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Apr 2010 15:10:12 -0400
Content-Disposition: inline
In-Reply-To: <86a4d8e5df80008c5c2b3ff4f2a5842ad1f58dc4.1271968072.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145849>

On Thu, Apr 22, 2010 at 10:30:20PM +0200, Michael J Gruber wrote:

> Currently, status gives a lot of hints even when advice.statusHints is
> false. Change this so that all hints depend on the config variable.

I didn't bother with them because they aren't actually wasting screen
real estate, unlike the other hints. But I don't really care either way,
so it's fine by me.

Though I wonder if you should simply suppress the line entirely. It is
totally redundant with the information presented above. But like I said,
I don't care too much.

-Peff
