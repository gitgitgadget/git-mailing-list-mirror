From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 14:58:09 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071455180.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>  <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org>  <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com>
  <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>  <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
 <384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> <FA7479D2-1859-4F8B-AC94-013BD6A4F608@bernhardsen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"hasan.aljudy@gmail.com" <hasan.aljudy@gmail.com>,
	"kusmabite@googlemail.com" <kusmabite@googlemail.com>,
	"prohaska@zib.de" <prohaska@zib.de>
To: Eyvind Bernhardsen <eyvind@bernhardsen.org>
X-From: git-owner@vger.kernel.org Sat May 08 00:00:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAVau-0000Q2-FD
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 00:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758685Ab0EGWAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 18:00:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40023 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753903Ab0EGWAW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 18:00:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47M06jH030626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 15:00:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47M06l7014217;
	Fri, 7 May 2010 15:00:06 -0700
In-Reply-To: <FA7479D2-1859-4F8B-AC94-013BD6A4F608@bernhardsen.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146607>



On Fri, 7 May 2010, Eyvind Bernhardsen wrote:
> 
> Also, I meant to write "* crlf=auto", not "* auto-eol=true", if that makes it
> any less crazy.

Oh, yes. See my other email. "* crlf=auto" is at least sensible, although 
somewhat scary. At least with core.autocrlf=true, the user has to had 
consciously set it. It was the "whole new attribute name" that I thought 
pushed it from "slightly scary" to "crazy".

		Linus
