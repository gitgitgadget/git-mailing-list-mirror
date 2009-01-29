From: Jeff King <peff@peff.net>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Wed, 28 Jan 2009 23:05:42 -0500
Message-ID: <20090129040542.GE11836@coredump.intra.peff.net>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com> <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com> <885649360901281815q42199468v8658d864386efe2d@mail.gmail.com> <46a038f90901281828t16ace3bdocc897eb5235d7c30@mail.gmail.com> <d30068860901281846v65baf431mdab5fe961ef9407d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 05:07:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSOBR-0008Cr-Sy
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 05:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbZA2EFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 23:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757881AbZA2EFp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 23:05:45 -0500
Received: from peff.net ([208.65.91.99]:32955 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757228AbZA2EFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 23:05:44 -0500
Received: (qmail 28624 invoked by uid 107); 29 Jan 2009 04:05:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 23:05:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 23:05:42 -0500
Content-Disposition: inline
In-Reply-To: <d30068860901281846v65baf431mdab5fe961ef9407d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107628>

On Thu, Jan 29, 2009 at 12:46:56PM +1000, Greg Hauptmann wrote:

> does the concept of me setting up my own central git server as well
> make any sense from the point of view of a way to ensure I can (when
> I'm not remote) "check-in" to the central git server & thereby keep a
> separate copy of my code (i.e. effectively a backup)

Yes, that is exactly what I do, because:

  - my central server is backed up, but my workstations are not

  - my central server is accessible remotely, but my workstations are
    not. So that is how I get code from one box to the other.

-Peff
