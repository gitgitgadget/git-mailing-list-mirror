From: Jeff King <peff@peff.net>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 9 Jan 2009 04:33:07 -0500
Message-ID: <20090109093307.GA2039@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net> <7veizc25e8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 10:34:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLDlD-0005dO-Ny
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 10:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZAIJdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 04:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbZAIJdL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 04:33:11 -0500
Received: from peff.net ([208.65.91.99]:57000 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbZAIJdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 04:33:10 -0500
Received: (qmail 17611 invoked by uid 107); 9 Jan 2009 09:33:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 04:33:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 04:33:07 -0500
Content-Disposition: inline
In-Reply-To: <7veizc25e8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104993>

On Fri, Jan 09, 2009 at 01:30:23AM -0800, Junio C Hamano wrote:

> This arrangement to have the third process could even open the possibility
> of having it read from git and write to pager, and not launching the pager
> if there is no interesting data from git to feed it with.
> 
> I do not know if I like the performance implications associated with it,
> though.

Ugh. That has definitely been a requested feature, but the thought of
essentially running "cat" in our pipeline strikes me as a bit kludgey.

On the other hand, we are by definition going to the pager in that case,
so in theory performance is less of a consideration.

But see my other mail for why a third process is hard to always do on
Windows.

-Peff
