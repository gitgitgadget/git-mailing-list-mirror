From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] ls-files: fix overeager pathspec optimization
Date: Tue, 12 Jan 2010 11:33:11 -0500
Message-ID: <20100112163311.GD25092@coredump.intra.peff.net>
References: <1263022535-12822-1-git-send-email-gitster@pobox.com>
 <1263022535-12822-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 17:33:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUjgM-0000hQ-V7
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 17:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453Ab0ALQdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 11:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754432Ab0ALQdU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 11:33:20 -0500
Received: from peff.net ([208.65.91.99]:42722 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384Ab0ALQdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 11:33:20 -0500
Received: (qmail 8431 invoked by uid 107); 12 Jan 2010 16:38:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 11:38:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 11:33:11 -0500
Content-Disposition: inline
In-Reply-To: <1263022535-12822-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136739>

On Fri, Jan 08, 2010 at 11:35:35PM -0800, Junio C Hamano wrote:

> This patch changes the optimization so that it notices when the common
> prefix directory that it starts reading from is an ignored one.

Having just produced the similar but more ugly and messy patch earlier
in the thread, this series looks right to me.

-Peff
