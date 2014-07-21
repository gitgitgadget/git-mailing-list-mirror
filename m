From: Dan Ackroyd <danack@basereality.com>
Subject: OSX packages on git-scm.com broken on previous OSX versions?
Date: Mon, 21 Jul 2014 13:08:53 +0100
Message-ID: <CA+kxMuQLUJ+sohiSGaDpz7U-fiAwaYbe5wv7XnG7UCj=tw6uyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 14:09:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9COp-0006js-Re
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 14:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbaGUMIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 08:08:55 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:46411 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbaGUMIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 08:08:54 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so6269566wgh.34
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 05:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=4l++kTxTTlMjyl2QCWLtKcKTsmZlTT+X0IX2zGrbODc=;
        b=PoXfiJyOYaPpLuc7qf0VXx7EHLrVvR18gia4IseQ7wksSr+ohQ29Eh4FUtC2My6vne
         vpYGz+EIe5uLTUtSo9i/93r/w8uo226d5qMheqo6ZyzIe23RTMsndfNEXZIAZcYvaVEX
         az/C8IOPsre0IAdhr+s6upKNE9IWEuKvDKclRrGw2mTMi4JwrHK1ugJ27Vn8+VqoXwxL
         Q4kH2vpIXuuW9p05qa+DkrbBlSZPz9lXrdMQeoBQ3Ve4FQsYA1lLe5JoxNpoULG7Cowq
         IpwVZaAb/O2kRlSoIvdbORLhWz0Fk+6PCEOKWlP0E3wE80X/B1HFZdR1+DKG0p8m4Nkc
         sfJg==
X-Gm-Message-State: ALoCoQmwCfwnuwgG4s0bJ6ouVk6yA3+x8O8b+pTQ3/kenzv8R0uj1Z9NjszJeZrttBuvQYnt2UjV
X-Received: by 10.194.187.4 with SMTP id fo4mr8794121wjc.35.1405944533075;
 Mon, 21 Jul 2014 05:08:53 -0700 (PDT)
Received: by 10.216.51.144 with HTTP; Mon, 21 Jul 2014 05:08:53 -0700 (PDT)
X-Originating-IP: [78.148.156.63]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253956>

Hi,

Apologies in advance if this is the wrong place, but it looks like the
OSX packages available from http://git-scm.com/download/mac are not
working for at least some people including myself.

What I'm seeing is that any call to invoke git gives an illegal
instruction, crash report is below.

The other people are listed at:
http://sourceforge.net/p/git-osx-installer/tickets/97/

Apparently this may be a problem caused by the lack of the compile
flag "-mmacosx-version-min=10.5" according to:

http://stackoverflow.com/questions/14268887/what-is-the-illegal-instruction-4-error-and-why-does-mmacosx-version-min-10

Any chance this can be investigated and fixed please?

cheers
Dan
Ackroyd

btw I'm on OSX 10.6.8 but the other reports are on more up to date versions.

Process:         bash [90170]
Path:            /bin/bash
Identifier:      bash
Version:         ??? (???)
Code Type:       X86-64 (Native)
Parent Process:  bash [89840]

Date/Time:       2014-07-21 12:34:59.093 +0100
OS Version:      Mac OS X 10.6.8 (10K549)
Report Version:  6

Exception Type:  EXC_BAD_ACCESS (SIGILL)
Exception Codes: KERN_INVALID_ADDRESS at 0xfffffffffffffff8
Crashed Thread:  Unknown

Backtrace not available

Unknown thread crashed with X86 Thread State (64-bit):
  rax: 0x0000000000000055  rbx: 0x0000000000000000  rcx:
0x0000000000000000  rdx: 0x0000000000000000
  rdi: 0x0000000000000000  rsi: 0x0000000000000000  rbp:
0x0000000000000000  rsp: 0x0000000000000000
   r8: 0x0000000000000000   r9: 0x0000000000000000  r10:
0x0000000000000000  r11: 0x0000000000000000
  r12: 0x0000000000000000  r13: 0x0000000000000000  r14:
0x0000000000000000  r15: 0x0000000000000000
  rip: 0x00007fff5fc01028  rfl: 0x0000000000010203  cr2: 0xfffffffffffffff8

Binary images description not available
