From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't update unchanged merge entries
Date: Sun, 16 Mar 2008 14:15:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803161413250.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161136060.3020@woody.linux-foundation.org> <alpine.LNX.1.00.0803161548250.19665@iabervon.org>
 <alpine.LFD.1.00.0803161338100.3020@woody.linux-foundation.org> <alpine.LNX.1.00.0803161700430.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:16:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb0Dl-0007UV-1p
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 22:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbYCPVQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 17:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbYCPVQF
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 17:16:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44029 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752582AbYCPVQE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2008 17:16:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GLGHvN010238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Mar 2008 14:16:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GLFBeg013560;
	Sun, 16 Mar 2008 14:15:11 -0700
In-Reply-To: <alpine.LNX.1.00.0803161700430.19665@iabervon.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.31 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77385>



On Sun, 16 Mar 2008, Daniel Barkalow wrote:
> 
> Well, the top part of the comment suggests that this is just an 
> optimization (don't bother to write out a file that you know is 
> unchanged), when it's actually necessary for correctness (since we don't 
> know if the working tree matches the old index).

Ahh, that part. Yeah, maybe we could expand/clarify it. I don't think the 
comment is wrong per se, but yes, I'm sure it could be improved. 

		Linus
