From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git ignore
Date: Tue, 16 Dec 2008 14:53:07 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812161450010.14014@localhost.localdomain>
References: <21043430.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Max Power <mkwright@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 23:54:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCio9-0001hK-OZ
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 23:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbYLPWxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 17:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbYLPWxL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 17:53:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43596 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750879AbYLPWxK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Dec 2008 17:53:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBGMr8or031872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Dec 2008 14:53:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBGMr7dm006474;
	Tue, 16 Dec 2008 14:53:07 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <21043430.post@talk.nabble.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.423 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103294>



On Tue, 16 Dec 2008, Max Power wrote:
> 
> So I understand how to use the .gitignore file to ignore specific
> files/directories that I put in there... is there a way to ignore everything
> BUT a given file extension? 

Something like

	*
	!*.jpg

to only save the jpegs in your pr0n collection?

The first rule says "ignore everything". The second one says "don't 
ignore *.jpg files".

Untested. 

		Linus
