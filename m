From: Jeff King <peff@peff.net>
Subject: Re: Possible bug: "git log" ignores "--encoding=UTF-8" option if
	--pretty=format:%e%n%s%n is used
Date: Wed, 12 Nov 2008 23:34:55 -0500
Message-ID: <20081113043454.GA5048@coredump.intra.peff.net>
References: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com> <20081112104318.GA20120@coredump.intra.peff.net> <85647ef50811120311q7bc5451x7c084fd2a7864177@mail.gmail.com> <20081112112654.GA20640@coredump.intra.peff.net> <85647ef50811120508j5074f892p1e2a95acfae8c0a8@mail.gmail.com> <7vvdusjtg8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 05:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0TwU-0001EP-9R
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 05:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbYKMEfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 23:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbYKMEfF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 23:35:05 -0500
Received: from peff.net ([208.65.91.99]:3353 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbYKMEfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 23:35:04 -0500
Received: (qmail 24627 invoked by uid 111); 13 Nov 2008 04:34:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 23:34:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 23:34:55 -0500
Content-Disposition: inline
In-Reply-To: <7vvdusjtg8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100850>

On Wed, Nov 12, 2008 at 05:38:47PM -0800, Junio C Hamano wrote:

> > BTW for some reason --pretty=raw is affected by encoding option on the
> > command line.
> 
> Unfortunately, that is what you get for reading from a Porcelain output,
> which is meant for, and are subject to improvement for, human consumption.
> 
> If you want bit-for-bit information, you can always ask "git cat-file".

What about "git rev-list --pretty=raw"? Is that also porcelain?

I would be curious to hear your take on our failure to respect
--encoding for --pretty=format. Is it a bug to be fixed, or a historical
behavior to be maintained?

-Peff
