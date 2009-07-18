From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 21:06:06 +0200
Message-ID: <200907182106.06776.j6t@kdbg.org>
References: <20090718134551.GC16708@vidovic> <20090718135649.GA6759@sigill.intra.peff.net> <20090718141658.GE16708@vidovic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 18 21:07:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSFFd-0006Hj-Ca
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 21:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbZGRTGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbZGRTGM
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 15:06:12 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56400 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbZGRTGM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 15:06:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9DFCFA7EAE;
	Sat, 18 Jul 2009 21:06:08 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3F6F34277D;
	Sat, 18 Jul 2009 21:06:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090718141658.GE16708@vidovic>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123532>

On Samstag, 18. Juli 2009, Nicolas Sebrecht wrote:
> ==10807== Process terminating with default action of signal 11 (SIGSEGV)
> ==10807==  Access not within mapped region at address 0x1
> ==10807==    at 0x4C22349: strlen (in
> /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so) ==10807==    by
> 0x5616ED6: vfprintf (in /lib64/libc-2.8.so)
> ==10807==    by 0x563C159: vsnprintf (in /lib64/libc-2.8.so)
> ==10807==    by 0x495E90: git_vsnprintf (snprintf.c:38)
> ==10807==    by 0x48917B: strbuf_addf (strbuf.c:203)

amd64-linux, and you build with SNPRINTF_RETURNS_BOGUS? Why do you have this 
option set?

-- Hannes
