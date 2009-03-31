From: Jeff King <peff@peff.net>
Subject: Re: bsd group semantics
Date: Tue, 31 Mar 2009 14:46:04 -0400
Message-ID: <20090331184604.GA10701@coredump.intra.peff.net>
References: <20090331112637.GA1910@coredump.intra.peff.net> <7vvdpp6623.fsf@gitster.siamese.dyndns.org> <20090331160842.GA9019@coredump.intra.peff.net> <7veiwd61k1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loj2K-0003Xj-PS
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 20:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763515AbZCaSqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 14:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763494AbZCaSqT
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 14:46:19 -0400
Received: from peff.net ([208.65.91.99]:42196 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763510AbZCaSqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 14:46:18 -0400
Received: (qmail 12181 invoked by uid 107); 31 Mar 2009 18:46:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 14:46:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 14:46:04 -0400
Content-Disposition: inline
In-Reply-To: <7veiwd61k1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115297>

On Tue, Mar 31, 2009 at 10:32:14AM -0700, Junio C Hamano wrote:

> My point was if I belong only to my personal group and git.git work tree
> is owned by junio.junio to begin with, you would never be able to notice
> any breakage with such a test.

Ah, I see. Yes, you would need to belong to at least two groups to make
such a test feasible.

Such a requirement is generally outside the scope of running the
test suite; do you want to just ditch the g+s test, then, or do you want
me to work up something conditional based on the Makefile flag?

-Peff
