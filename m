From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] import memmem() with linear complexity from Gnulib
Date: Sat, 28 Feb 2009 22:41:23 -0500
Message-ID: <20090301034123.GC30384@coredump.intra.peff.net>
References: <cover.1235629933.git.gitster@pobox.com> <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com> <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org> <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org> <49A937B8.1030205@lsrfire.ath.cx> <7vmyc6foj3.fsf@gitster.siamese.dyndns.org> <1235848615.7043.30.camel@ubuntu.ubuntu-domain> <20090228224401.GA27262@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Mar 01 04:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldcd3-0000gy-68
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 04:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbZCADlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 22:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbZCADla
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 22:41:30 -0500
Received: from peff.net ([208.65.91.99]:32783 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbZCADla (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 22:41:30 -0500
Received: (qmail 28655 invoked by uid 107); 1 Mar 2009 03:41:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Feb 2009 22:41:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Feb 2009 22:41:23 -0500
Content-Disposition: inline
In-Reply-To: <20090228224401.GA27262@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111811>

On Sat, Feb 28, 2009 at 11:44:01PM +0100, Mike Hommey wrote:

> > ---
> >  Makefile             |    1 +
> >  compat/memmem.c      |  103 +++++++++----
> >  compat/str-two-way.h |  429 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 504 insertions(+), 29 deletions(-)
> 
> Seeing how much memmem is being used in the codebase, is it really worth?

See earlier in the thread, where "git log -Stoken" is substantially
faster on Linux versus Windows (but some exact numbers before and after
on Windows would be nice to have in the commit message).

-Peff
