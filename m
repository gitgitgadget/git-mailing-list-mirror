From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 09:25:52 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org>
 <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 18:26:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDNeX-0002sA-SG
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 18:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760190AbYAKR0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 12:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760245AbYAKR0S
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 12:26:18 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56009 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754944AbYAKR0R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 12:26:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BHPrmF004185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jan 2008 09:25:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BHPq1T000983;
	Fri, 11 Jan 2008 09:25:52 -0800
In-Reply-To: <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70178>



On Fri, 11 Jan 2008, Steffen Prohaska wrote:
> > 
> > No. What would it help?
> 
> You may later decide that you want to check out your project on Windows.
> In this case your repository should not contain CRLF.  autocrlf=input
> ensures this.

But under Unix, it would never do that *anyway*, unless the file for some 
reason really needs it (which I cannot imagine, but I've never seen 
anything so craptastically stupid that some crazy person hasn't done it)

So your argument is bogus.

		Linus
