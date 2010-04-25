From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH 3/5] Dangling commas in enum is not portable (resend)
Date: Sun, 25 Apr 2010 03:35:41 -0500 (CDT)
Message-ID: <20100315031718.GA21130@thor.il.thewrittenword.com>
References: <20100311163235.GC7877@thor.il.thewrittenword.com>
 <94a0d4531003120118l2a5c69ebh7e62ea8630f94738@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:36:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xKB-0005sU-3e
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab0DYIfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:35:44 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:59167 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0DYIfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:35:42 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 8C70C5CED
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:56:44 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 8C70C5CED
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 42AE1A77
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:35:42 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id EF7D957C; Sun, 25 Apr 2010 03:35:41 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <94a0d4531003120118l2a5c69ebh7e62ea8630f94738@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145722>

On Fri, Mar 12, 2010 at 11:18:47AM +0200, Felipe Contreras wrote:
> On Thu, Mar 11, 2010 at 6:32 PM, Gary V. Vaughan
> <git@mlists.thewrittenword.com> wrote:
> > Unfortunately there are a still a lot of vendor compilers that choke
> > when the last entry in an enum has a dangling comma (irix is one, and
> > I can get you a list of which of our particular platforms exhibit this
> > problem).
> 
> I would appreciate that list if it's not much trouble.

I take it back.  I've been porting this patch forward from our builds
of previous releases, and at some point it certainly was necessary
(otherwise I wouldn't have written the patch)... and yet, all of our
platforms are now able to compile a minimal test program in C.
Either the offending vendor compilers have issued an update to accept
the dangling comma syntax, or we have retired the machines that used
to have this problem since I originally wrote the patch.

It's notable that aCC (the HP C++ compiler) and CC (the SunOS C++
compiler) both issue a warning on dangling enum commas, but even they
still compile successfully.

Sorry for the noise,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
