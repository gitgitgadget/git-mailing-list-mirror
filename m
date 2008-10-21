From: Jeff King <peff@peff.net>
Subject: Re: git command to read
Date: Tue, 21 Oct 2008 07:25:22 -0400
Message-ID: <20081021112521.GC17363@coredump.intra.peff.net>
References: <18685.47909.354146.487700@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:27:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFO7-0006ES-7z
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYJULZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbYJULZZ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:25:25 -0400
Received: from peff.net ([208.65.91.99]:3265 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451AbYJULZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:25:24 -0400
Received: (qmail 19723 invoked by uid 111); 21 Oct 2008 11:25:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Oct 2008 07:25:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Oct 2008 07:25:22 -0400
Content-Disposition: inline
In-Reply-To: <18685.47909.354146.487700@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98776>

On Tue, Oct 21, 2008 at 10:21:09PM +1100, Paul Mackerras wrote:

> Is there a command in git at the moment that will read commit IDs on
> standard input and print the contents of each commit on standard
> output (without waiting for EOF on stdin)?

How about:

  git cat-file --batch

?

Unfortunately it just dumps the raw commit information instead of
allowing the usual formatting, but perhaps that is sufficient (you asked
for "contents").

-Peff
