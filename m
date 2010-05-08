From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 18:49:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>  <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org>
  <h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com>  <alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org>  <q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com>  <alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org> 
 <i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com>  <alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org> <i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@googlemail.com, prohaska@zib.de
To: hasen j <hasan.aljudy@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 03:51:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAZCN-0000ul-NX
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 03:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644Ab0EHBvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 21:51:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50393 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab0EHBvR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 21:51:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o481pC9c013200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 18:51:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o481pBQD023244;
	Fri, 7 May 2010 18:51:11 -0700
In-Reply-To: <i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146626>



On Fri, 7 May 2010, hasen j wrote:
> > However, if you think that it needs to be CRLF on _all_ platforms, even
> > platforms where CRLF is _wrong_ for a text-file, then see above: in that
> > case it's not a text-file at all as far as the SCM is concerned.
> >
> > In that case it's just a binary file, and CRLF is _not_ "end of text
> > line", it's part of the definition of the format for that binary file.
> 
> What does the platform care? This doesn't make any sense. Files that
> need CRLF are not Unix files to begin with (e.g. sln).

Don't be silly.

The whole AND ONLY point of CRLF translation is that line-endings are 
different on different platforms.

So when you say "What does the platform care?", that is a totally idiotic 
and utterly stupid thing to ask.

And since you ask it, I can only assume that you don't understand anything 
about the whole CRLF discussion, that you don't care about cross-platform 
repositories, and that as a result you should NEVER EVER actually use any 
of the git crlf conversion code.

It's that simple. You seem to totally miss the whole point of the whole 
feature in the first place.

			Linus
