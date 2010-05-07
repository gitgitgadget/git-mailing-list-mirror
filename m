From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 14:23:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>  <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>  <alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org>  <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com> 
 <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org> <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com> <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>
 <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> <384AA932-227B-43B0-9D38-560A3567918A@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 23:26:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAV3k-0005Gy-Cf
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397Ab0EGV0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 17:26:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50291 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756212Ab0EGV0F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 17:26:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47LPfXB026274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 14:25:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47LPfCd012715;
	Fri, 7 May 2010 14:25:41 -0700
In-Reply-To: <384AA932-227B-43B0-9D38-560A3567918A@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146602>



On Fri, 7 May 2010, Eyvind Bernhardsen wrote:
> 
> I don't understand.  All you have to do is add "* auto-eol=true" to your 
> .gitattributes, and line endings will be normalized exactly as if you'd 
> set "core.autocrlf".  Why would you have to write totally new rules?  
> Which rules?

I think "* auto-eol=true" is just crazy. We would _never_ want to do that. 
Any project that does that should be shot in the head.

So encouraging that as a format is just silly and stupid.

In contrast, the slight change in semantics (with no new config options 
_or_ attributes) that I suggest should just make everybody happy - because 
it takes care of the real life situation that people are in.

		Linus
