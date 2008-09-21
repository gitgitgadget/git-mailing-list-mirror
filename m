From: Jeff King <peff@peff.net>
Subject: Re: git-am strips final ')' character from author name
Date: Sun, 21 Sep 2008 06:18:08 -0400
Message-ID: <20080921101808.GD3376@sigill.intra.peff.net>
References: <2f54d7a20809191057t76c405e7q643912388efe2f01@mail.gmail.com> <2f54d7a20809191058w558f3a28nc1537dc82f4a6ec2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: AI <ai0867@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 12:20:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhM36-0008Sv-Tm
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 12:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbYIUKSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 06:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbYIUKSL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 06:18:11 -0400
Received: from peff.net ([208.65.91.99]:1291 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbYIUKSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 06:18:10 -0400
Received: (qmail 29190 invoked by uid 111); 21 Sep 2008 10:18:09 -0000
Received: from c-75-75-5-148.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.5.148)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 21 Sep 2008 06:18:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Sep 2008 06:18:08 -0400
Content-Disposition: inline
In-Reply-To: <2f54d7a20809191058w558f3a28nc1537dc82f4a6ec2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96387>

On Fri, Sep 19, 2008 at 07:58:14PM +0200, AI wrote:

> Applying attached patch with git-am strips the ')' character from the name.

Are you using 1.5.x? This seems to be fixed in v1.6.0 by 0d4ede9f
(mailinfo: better parse email adresses containg parentheses).

-Peff
