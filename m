From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 2.6.24-rc6
Date: Thu, 20 Dec 2007 19:49:05 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712201937470.21557@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0712201731010.21557@woody.linux-foundation.org> <20071221024805.GB8535@fattire.cabal.ca> <20071221030152.GC8535@fattire.cabal.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 04:50:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Yte-0001lp-G4
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 04:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbXLUDtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 22:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbXLUDtb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 22:49:31 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50273 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690AbXLUDta (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 22:49:30 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL3n61A005625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 19:49:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL3n5JE028207;
	Thu, 20 Dec 2007 19:49:05 -0800
In-Reply-To: <20071221030152.GC8535@fattire.cabal.ca>
X-Spam-Status: No, hits=-2.713 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69036>



On Thu, 20 Dec 2007, Kyle McMartin wrote:
> 
> I think I see the problem, it's lack of context in the diff,

No, the problem is that "git diff" is apparently broken by a recent 
optimization. The diff is simply broken.

The tar-ball and the git archive itself is fine, but yes, the diff from 
2.6.23 to 2.6.24-rc6 is bad. It's the "trim_common_tail()" optimization 
that has caused way too much pain.

Sorry about that, I'll fix it up asap.

		Linus
