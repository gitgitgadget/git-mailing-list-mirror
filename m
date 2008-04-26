From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: default commit message for a tree
Date: Fri, 25 Apr 2008 19:01:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804251859100.2813@woody.linux-foundation.org>
References: <524f69650804251839u56198808o8b7a66d9894fbbfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steve French <smfrench@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 04:02:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpZk2-0005Qs-H1
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 04:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbYDZCBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 22:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755777AbYDZCBa
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 22:01:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46835 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755766AbYDZCBa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2008 22:01:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3Q21Rgj032230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Apr 2008 19:01:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3Q21Qbd001329;
	Fri, 25 Apr 2008 19:01:27 -0700
In-Reply-To: <524f69650804251839u56198808o8b7a66d9894fbbfc@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.445 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80363>



On Fri, 25 Apr 2008, Steve French wrote:
> 
> I created a file .git/commit-template with default text as follows:
> 
> [CIFS]
> 
> Signed-off-by: Steve French <sfrench@us.ibm.com>

You need to use

	    git-config commit.template .git/commit-template

(or use the whole absolute pathname to your template file). The pathname 
is relative to the working tree, not GIT_DIR.

		Linus
