From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Sat, 8 May 2010 14:57:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 00:00:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAs4B-0001bj-8w
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 00:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268Ab0EHWAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 18:00:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54444 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753866Ab0EHWAD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 18:00:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o48LxOmH029721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 May 2010 14:59:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o48LxNTn004745;
	Sat, 8 May 2010 14:59:23 -0700
In-Reply-To: <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146680>



On Sat, 8 May 2010, Eyvind Bernhardsen wrote:
>
> Introduce a new configuration variable, "core.eolStyle", that allows the
> user to set which line endings to use for end-of-line-normalized files
> in the working directory.  It defaults to "native", which means CRLF on
> Windows and LF everywhere else.

So I at least agree with the semantics now, but I think that we really 
would be better off just calling it "core.crlf". I don't _care_ whether 
people think it's a bad name - much worse than a bad name is to use a name 
that is not consistent. 

Having two config variables named "core.autocrlf" and "core.crlf" at least 
is consistent. Having "autocrlf" and "eolStyle" is just messed up.

		Linus
