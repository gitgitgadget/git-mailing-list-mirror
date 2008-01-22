From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to
 UTF8
Date: Tue, 22 Jan 2008 07:58:47 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801220757080.2957@woody.linux-foundation.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org> <fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org> <7vve5nzdqx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801220917310.20753@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 17:01:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHLYX-0000vJ-Jx
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 17:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbYAVQAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 11:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbYAVQAY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 11:00:24 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47648 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753105AbYAVQAX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 11:00:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MFwmhx014184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 07:58:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MFwlJU028237;
	Tue, 22 Jan 2008 07:58:47 -0800
In-Reply-To: <alpine.LFD.1.00.0801220917310.20753@xanadu.home>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.723 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71457>



On Tue, 22 Jan 2008, Nicolas Pitre wrote:
> 
> You need to use "signed char" here.  On ARM a char is unsigned by 
> default.  That's the case on some other systems too.

Correct you are. Me bad.

		Linus
