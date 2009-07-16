From: Jeff King <peff@peff.net>
Subject: Re: How to ignore space when using 'git send-email' command
Date: Thu, 16 Jul 2009 17:00:52 -0400
Message-ID: <20090716210051.GA17229@coredump.intra.peff.net>
References: <3b9893450907131353o77102b8cx6c8944f6cc45214a@mail.gmail.com>
 <20090716100926.GC6742@coredump.intra.peff.net>
 <7v4otc8hy8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: n179911 <n179911@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 23:01:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRY4e-0007id-UZ
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 23:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368AbZGPVA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933366AbZGPVA4
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 17:00:56 -0400
Received: from peff.net ([208.65.91.99]:36325 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933364AbZGPVAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 17:00:55 -0400
Received: (qmail 22700 invoked by uid 107); 16 Jul 2009 21:02:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Jul 2009 17:02:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jul 2009 17:00:52 -0400
Content-Disposition: inline
In-Reply-To: <7v4otc8hy8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123424>

On Thu, Jul 16, 2009 at 01:57:03PM -0700, Junio C Hamano wrote:

> >   2. give send-email revision arguments, which are fed to format-patch
> >      (which is what I showed above).  In this case, you can give
> >      format-patch arguments directly to send-email.
> >
> > Does that help?
> 
> That may help but it is generally a bad idea to send a patch generated
> with ignore-all-spaces and other options, as it means that the receiving
> end will get changes that not even you the sender had any chance to test.

True. You are probably better off using "rebase -i" to fix your commits,
testing them, then sending in the result.

-Peff
