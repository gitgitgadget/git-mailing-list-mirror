From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 16:50:04 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org>  <384AA932-227B-43B0-9D38-560A3567918A@gmail.com>
 <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org>  <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>  <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> 
 <h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com>  <alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org> <q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@googlemail.com, prohaska@zib.de
To: hasen j <hasan.aljudy@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 01:52:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAXL6-0007wE-8d
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 01:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab0EGXwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 19:52:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39937 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752321Ab0EGXwK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 19:52:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47Nq2X8006145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 16:52:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47Nq1bv018775;
	Fri, 7 May 2010 16:52:01 -0700
In-Reply-To: <q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146621>



On Fri, 7 May 2010, hasen j wrote:

> >
> > The only reason to ever support 'lf' is
> > if you're a total moron of a SCM, and you save files you know are text in
> > CRLF format internally. That's just f*cking stupid.
> >
> 
> What if:
> 
> - The entire history of the file is stored in CRLF
> - It's a windows-only file where the official "tool" that reads it
> barfs on LF line endings.
> - Third party tools also expect (or at least, handle) CRLF line endings.

Umm. Then it's not text, is it? What you are describing is a binary file 
that happens to look like text with CRLF.

If it's _text_, then you import it as such, and set crlf=true so that it 
gets checked out with crlf.

		Linus
