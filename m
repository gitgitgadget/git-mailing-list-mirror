From: Jeff King <peff@peff.net>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 15:52:16 -0400
Message-ID: <20091030195216.GA27135@coredump.intra.peff.net>
References: <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
 <20091030173838.GB18583@coredump.intra.peff.net>
 <20091030182331.GC10671@ikki.ethgen.de>
 <20091030184155.GC19901@coredump.intra.peff.net>
 <20091030190552.GA3528@coredump.intra.peff.net>
 <7vvdhwk6dq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Klaus Ethgen <Klaus@Ethgen.de>, 553296@bugs.debian.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:52:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xWR-00018N-Uw
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbZJ3TwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbZJ3TwV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:52:21 -0400
Received: from peff.net ([208.65.91.99]:54874 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757305AbZJ3TwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:52:20 -0400
Received: (qmail 2812 invoked by uid 107); 30 Oct 2009 19:56:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 15:56:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 15:52:16 -0400
Content-Disposition: inline
In-Reply-To: <7vvdhwk6dq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131741>

On Fri, Oct 30, 2009 at 12:51:13PM -0700, Junio C Hamano wrote:

> > Here it is. I think this is the right thing to do. Junio?
> 
> I am not sure; my head spins when I see "tracked but ignored" (you have
> a new one in the test) which is quite a bogus concept.
> 
> Does it mean "tracked but would be ignored if it weren't---perhaps it was
> added by mistake?"?

Yes, that is exactly what it means.

-Peff
