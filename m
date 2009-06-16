From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Makefile: refactor regex compat support
Date: Tue, 16 Jun 2009 15:05:50 -0400
Message-ID: <20090616190550.GA22905@coredump.intra.peff.net>
References: <20090616120737.GA5227@coredump.intra.peff.net> <20090616121126.GA11918@coredump.intra.peff.net> <200906162047.28368.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Bito <jwbito@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:06:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGdyy-0006qN-UX
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 21:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760931AbZFPTFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760498AbZFPTFv
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 15:05:51 -0400
Received: from peff.net ([208.65.91.99]:33621 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759604AbZFPTFu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 15:05:50 -0400
Received: (qmail 5896 invoked by uid 107); 16 Jun 2009 19:07:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 15:07:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:05:50 -0400
Content-Disposition: inline
In-Reply-To: <200906162047.28368.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121704>

On Tue, Jun 16, 2009 at 08:47:28PM +0200, Johannes Sixt wrote:

> It compiles and passes t/t40* (diff stuff) on Windows. But the patch
> conflicts with recent master, though nothing worrisome.

Thanks for checking.

Yeah, it looks like several changes got merged to master right after
my branch point. All the conflicts are purely textual. For convenience,
I'll repost a rebased version.

-Peff
