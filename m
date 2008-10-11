From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: fix color reset in say_color()
Date: Fri, 10 Oct 2008 22:00:48 -0400
Message-ID: <20081011020048.GA29328@coredump.intra.peff.net>
References: <1223590030-7464-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 04:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoTnu-0001BU-A9
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 04:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbYJKCAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 22:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754669AbYJKCAv
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 22:00:51 -0400
Received: from peff.net ([208.65.91.99]:3096 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbYJKCAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 22:00:51 -0400
Received: (qmail 4769 invoked by uid 111); 11 Oct 2008 02:00:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 10 Oct 2008 22:00:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2008 22:00:48 -0400
Content-Disposition: inline
In-Reply-To: <1223590030-7464-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97962>

On Fri, Oct 10, 2008 at 12:07:10AM +0200, Miklos Vajna wrote:

> Actually I'm not 100% sure about how many users are affected. I have a
> black background in konsole with white letters, and after the test I get
> a green cursor, and once I hit enter, I get the white one back.

I think my comment is way late, as this has already been applied, but I
think this is definitely the right thing to do. We are very careful to
use the same pattern (color reset before newline) in the C code.

-Peff
