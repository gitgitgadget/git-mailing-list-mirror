From: Jeff King <peff@peff.net>
Subject: Re: OSX packages on git-scm.com broken on previous OSX versions?
Date: Tue, 22 Jul 2014 06:41:27 -0400
Message-ID: <20140722104126.GA29607@peff.net>
References: <CA+kxMuQLUJ+sohiSGaDpz7U-fiAwaYbe5wv7XnG7UCj=tw6uyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Dan Ackroyd <danack@basereality.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 12:41:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9XVo-000325-E6
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 12:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbaGVKlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 06:41:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:38124 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750737AbaGVKlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 06:41:31 -0400
Received: (qmail 22676 invoked by uid 102); 22 Jul 2014 10:41:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Jul 2014 05:41:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2014 06:41:27 -0400
Content-Disposition: inline
In-Reply-To: <CA+kxMuQLUJ+sohiSGaDpz7U-fiAwaYbe5wv7XnG7UCj=tw6uyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254009>

On Mon, Jul 21, 2014 at 01:08:53PM +0100, Dan Ackroyd wrote:

> Apologies in advance if this is the wrong place, but it looks like the
> OSX packages available from http://git-scm.com/download/mac are not
> working for at least some people including myself.

As you noticed, those packages are done by the git-osx-installer
project. I've cc'd Tim Harper, who runs that project (but who I don't
think reads the list carefully).

-Peff

-- >8 --
[copious quoting of original problem below]
> What I'm seeing is that any call to invoke git gives an illegal
> instruction, crash report is below.
> 
> The other people are listed at:
> http://sourceforge.net/p/git-osx-installer/tickets/97/
> 
> Apparently this may be a problem caused by the lack of the compile
> flag "-mmacosx-version-min=10.5" according to:
> 
> http://stackoverflow.com/questions/14268887/what-is-the-illegal-instruction-4-error-and-why-does-mmacosx-version-min-10
> 
> Any chance this can be investigated and fixed please?
> 
> cheers
> Dan
> Ackroyd
> 
> btw I'm on OSX 10.6.8 but the other reports are on more up to date versions.
> 
> Process:         bash [90170]
> Path:            /bin/bash
> Identifier:      bash
> Version:         ??? (???)
> Code Type:       X86-64 (Native)
> Parent Process:  bash [89840]
> 
> Date/Time:       2014-07-21 12:34:59.093 +0100
> OS Version:      Mac OS X 10.6.8 (10K549)
> Report Version:  6
> 
> Exception Type:  EXC_BAD_ACCESS (SIGILL)
> Exception Codes: KERN_INVALID_ADDRESS at 0xfffffffffffffff8
> Crashed Thread:  Unknown
> 
> Backtrace not available
> 
> Unknown thread crashed with X86 Thread State (64-bit):
>   rax: 0x0000000000000055  rbx: 0x0000000000000000  rcx:
> 0x0000000000000000  rdx: 0x0000000000000000
>   rdi: 0x0000000000000000  rsi: 0x0000000000000000  rbp:
> 0x0000000000000000  rsp: 0x0000000000000000
>    r8: 0x0000000000000000   r9: 0x0000000000000000  r10:
> 0x0000000000000000  r11: 0x0000000000000000
>   r12: 0x0000000000000000  r13: 0x0000000000000000  r14:
> 0x0000000000000000  r15: 0x0000000000000000
>   rip: 0x00007fff5fc01028  rfl: 0x0000000000010203  cr2: 0xfffffffffffffff8
> 
> Binary images description not available
