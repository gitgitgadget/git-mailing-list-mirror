From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Soem core git optimizations
Date: Sat, 10 May 2008 19:42:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805101940490.3142@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0805090856350.3142@woody.linux-foundation.org> <7v4p958t35.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 04:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv1Xm-0004Mq-EC
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 04:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbYEKCm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 22:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbYEKCm5
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 22:42:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46234 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754166AbYEKCm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2008 22:42:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4B2gqAu021841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 10 May 2008 19:42:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4B2gp29019404;
	Sat, 10 May 2008 19:42:51 -0700
In-Reply-To: <7v4p958t35.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.928 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81729>



On Sat, 10 May 2008, Junio C Hamano wrote:
> 
> Unfortunately this seems to depend on stuff still in 'next', and a trivial
> rebasing seems to break switching branches with "git checkout" in t4122
> (switching from 'master' to 'test' will lose arch/i386/boot/Makefile).

Gaah. It's actually based on 'master', not 'next', but yeah, I have my 
other patch-series in my tree (the case-insensitivity ones you have in 
next), and while I thought it was independent, I was wrong. Sorry about 
that.

		Linus
