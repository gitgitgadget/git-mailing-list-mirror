From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Date parsing
Date: Sun, 22 Jun 2008 00:40:42 +0200
Message-ID: <20080621224042.GE15111@leksak.fem-net>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com> <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil> <bd6139dc0806100831y7a00a0f4sbc8dee9df7a8c16a@mail.gmail.com> <alpine.LFD.1.10.0806100942500.3101@woody.linux-foundation.org> <20080621215240.GD15111@leksak.fem-net> <alpine.LFD.1.10.0806211507370.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl, Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 22 00:42:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KABmN-0001qW-5e
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 00:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbYFUWk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 18:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbYFUWk6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 18:40:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:59430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbYFUWk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 18:40:58 -0400
Received: (qmail invoked by alias); 21 Jun 2008 22:40:56 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp058) with SMTP; 22 Jun 2008 00:40:56 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19G9/RKtztGr8zspJ/Cbrs5PhMWwrD3I0Dc/7W3J1
	ZjbpxPyFhU5Mcv
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KABlC-0003pc-US; Sun, 22 Jun 2008 00:40:42 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806211507370.2926@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85738>

Hi,

On Sat, Jun 21, 2008 at 03:28:56PM -0700,
Linus Torvalds <torvalds@linux-foundation.org>:
[...]
>                 /* Be it commit time or author time, it does not make
>                  * sense to specify timestamp way into the future.  Make
>                  * sure it is not later than ten days from now...
>                  */
>                 if (now + 10*24*3600 < specified)
>                         return 0;
[...]

Great.
So it really turns out that this bug is a nifty feature. (Except if we receive
patches from the future with a numeric date format.)

Thanks for the explanation,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
