From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2010, #06; Sat, 17)
Date: Sun, 18 Apr 2010 04:36:41 -0400
Message-ID: <20100418083641.GA17717@coredump.intra.peff.net>
References: <7v7ho5xp3z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Gilger <heipei@hackvalue.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 10:37:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Q0U-0000AS-VN
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 10:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab0DRIhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 04:37:22 -0400
Received: from peff.net ([208.65.91.99]:51578 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab0DRIhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 04:37:21 -0400
Received: (qmail 31792 invoked by uid 107); 18 Apr 2010 08:37:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Apr 2010 04:37:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Apr 2010 04:36:41 -0400
Content-Disposition: inline
In-Reply-To: <7v7ho5xp3z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145216>

On Sat, Apr 17, 2010 at 11:16:00PM -0700, Junio C Hamano wrote:

> * jg/auto-initialize-notes-with-percent-n-in-format (2010-04-13) 1 commit
>  - pretty: Initialize notes if %N is used

I think the last round looked good, and this would ideally go into
v1.7.1, as it fixes a segfault. It is getting a bit late in the -rc
cycle, though. I guess the other option is to close the segfault with a
one-liner and just make %N a no-op for v1.7.1, and then fix it right for
v1.7.2.  I think I would prefer to have Johannes' patch right away,
though.

-Peff
