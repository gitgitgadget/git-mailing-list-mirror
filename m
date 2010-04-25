From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH 3/5] Dangling commas in enum is not portable (resend)
Date: Sun, 25 Apr 2010 11:03:06 -0500 (CDT)
Message-ID: <20100425152449.GB27695@thor.il.thewrittenword.com>
References: <20100311163235.GC7877@thor.il.thewrittenword.com>
 <94a0d4531003120118l2a5c69ebh7e62ea8630f94738@mail.gmail.com>
 <20100315031718.GA21130@thor.il.thewrittenword.com>
 <l2od2d39d861004250612g9ac6c7b4qdaa8ce0f973846e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Sun Apr 25 18:03:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O64Ib-0001IT-Fk
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 18:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab0DYQDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 12:03:08 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:50479 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab0DYQDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 12:03:07 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id D5FBC5CB8
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 16:24:09 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com D5FBC5CB8
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id C77259FD
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 16:03:06 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 8646457C; Sun, 25 Apr 2010 11:03:06 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <l2od2d39d861004250612g9ac6c7b4qdaa8ce0f973846e7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145746>

On Sun, Apr 25, 2010 at 03:12:37PM +0200, Tor Arntsen wrote:
> On Sun, Apr 25, 2010 at 10:35, Gary V. Vaughan
> <git@mlists.thewrittenword.com> wrote:
> 
> > I take it back. ?I've been porting this patch forward from our builds
> > of previous releases, and at some point it certainly was necessary
> > (otherwise I wouldn't have written the patch)... and yet, all of our
> > platforms are now able to compile a minimal test program in C.
> > [[...]]
> > It's notable that aCC (the HP C++ compiler) and CC (the SunOS C++
> > compiler) both issue a warning on dangling enum commas, but even they
> > still compile successfully.
> 
> The SGI MIPS Compiler v6.2 on IRIX 6.2 compiles, but with a warning.
> Later MIPSPro 7.2 and 7.4 versions (on 6.5) are OK (silent)
> Unfortunately IBM VisualAge C 5.0 (I have 5.0.2) on AIX 5.1 fails to
> compile with a trailing comma.
> IBM XLC V10.1 (I have one on AIX 6.1) is OK (silent)
> Native compiler on Tru64 V5.1 is OK (silent)
> 
> So, from the boxes I have access to the IBM XLC V5 version is the one
> which has a problem.

I'd be happy to resurrect this patch and resubmit against the latest
git release.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
