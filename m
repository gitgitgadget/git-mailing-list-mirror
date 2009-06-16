From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] Makefile: refactor regex compat support
Date: Tue, 16 Jun 2009 20:47:28 +0200
Message-ID: <200906162047.28368.j6t@kdbg.org>
References: <20090616120737.GA5227@coredump.intra.peff.net> <20090616121126.GA11918@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: John Bito <jwbito@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 20:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGdh4-0007R5-OQ
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 20:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761201AbZFPSr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760938AbZFPSr2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 14:47:28 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27641 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758339AbZFPSr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 14:47:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A434A10029;
	Tue, 16 Jun 2009 20:47:28 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7544762749;
	Tue, 16 Jun 2009 20:47:28 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090616121126.GA11918@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121700>

On Dienstag, 16. Juni 2009, Jeff King wrote:
> There was no tweakable knob to use the regex compat code; it
> was embedded in the mingw build. Since other platforms may
> want to use it, let's factor it out in the usual way for
> build configuration knobs.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This should behave the same as before on all platforms. The only one I
> might have screwed up by doing it wrong is mingw, but I have no machine
> to test on. Johannes, can you confirm that it is right?

It compiles and passes t/t40* (diff stuff) on Windows. But the patch conflicts 
with recent master, though nothing worrisome.

-- Hannes
