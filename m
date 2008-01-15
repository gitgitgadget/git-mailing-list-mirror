From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file
 descriptor
Date: Mon, 14 Jan 2008 21:42:11 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org>
References: <4787E981.7010200@nrlssc.navy.mil> <478C1D7A.6090103@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 15 06:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEeZR-0006Al-Hy
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 06:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbYAOFmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 00:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYAOFmR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 00:42:17 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50509 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320AbYAOFmR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 00:42:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0F5gCnd010293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2008 21:42:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0F5gB9Z001412;
	Mon, 14 Jan 2008 21:42:12 -0800
In-Reply-To: <478C1D7A.6090103@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70502>



On Mon, 14 Jan 2008, Brandon Casey wrote:
> 
> To reiterate, I only have problems with the builtin-commit,
> i.e. 1.5.4.*, the 1.5.3.* series works correctly. Of course
> if this is a memory corruption issue, then it could just be
> that the pattern of memory accesses in 1.5.3 does not tweak
> the problem.

Can you do an strace of the failure case and put it up on some public 
place (it's likely going to be too big to send as email)?

			Linus
