From: Jeff King <peff@peff.net>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 13:24:28 -0400
Message-ID: <20090616172428.GA18118@coredump.intra.peff.net>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <3ae83b000906161016k4927a91cke86d6c4aa087a590@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGcOj-0001IA-3h
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 19:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759698AbZFPRYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 13:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759536AbZFPRYa
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 13:24:30 -0400
Received: from peff.net ([208.65.91.99]:57891 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760643AbZFPRY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 13:24:28 -0400
Received: (qmail 5247 invoked by uid 107); 16 Jun 2009 17:26:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 13:26:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 13:24:28 -0400
Content-Disposition: inline
In-Reply-To: <3ae83b000906161016k4927a91cke86d6c4aa087a590@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121691>

On Tue, Jun 16, 2009 at 10:16:39AM -0700, John Bito wrote:

> The Solaris 10 server here isn't set up to build git.  git/Makefile
> isn't compatible with /usr/ccs/bin/make. Is it desired to have a
> Makefile that's portable to the Sun tools?

No, the Makefile is hopelessly GNU, and that is intentional: the subset
of make that is portable means there are a lot of things you just can't
do. I think it was decided long ago that it wasn't worth trying to
support non-gmake.

-Peff
