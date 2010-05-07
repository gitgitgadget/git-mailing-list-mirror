From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 13:57:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>  <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>  <alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org>  <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com> 
 <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org> <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com> <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>
 <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:59:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUeF-0002lx-5A
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310Ab0EGU7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 16:59:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47441 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756244Ab0EGU7o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:59:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47KxZdn023308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 13:59:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47KxZep011433;
	Fri, 7 May 2010 13:59:35 -0700
In-Reply-To: <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146597>



On Fri, 7 May 2010, Eyvind Bernhardsen wrote:
> 
> How can you say that this is simpler than my syntax?

Because your syntax adds totally new attributes, so now you can't even 
take an existing .gitattributes and make it do something sane - instead 
you have to write totally new rules.

My suggestion just makes any existing usage do the "what you'd expect".

THAT is simpler.

		Linus
