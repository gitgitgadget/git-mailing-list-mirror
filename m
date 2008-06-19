From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cannot use stable 2.6.25.y tree with HTTP
Date: Wed, 18 Jun 2008 17:26:19 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181725250.2907@woody.linux-foundation.org>
References: <200806182037.m5IKboGC012108@pogo.cesa.opbu.xerox.com> <20080619000722.GA14270@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Klossner <andrew@cesa.opbu.xerox.com>, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K980F-0004y1-G7
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbYFSA05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755267AbYFSA04
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:26:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42262 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755718AbYFSA04 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 20:26:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5J0QKcq024740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 17:26:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5J0QJ7V028632;
	Wed, 18 Jun 2008 17:26:19 -0700
In-Reply-To: <20080619000722.GA14270@kroah.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.351 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85433>



On Wed, 18 Jun 2008, Greg KH wrote:
>
> git developers, do I need to do something to get git-update-server-info
> to run on kernel.org every time I do a push so that I don't have to do
> it by hand (and then forget for new releases, like I did above?)

Just do the hook:

> I thought I remember a script somewhere telling me what to put into a
> trigger in the git documentation a long time ago.
> 
> Oh, wait, is it just:
> 	chmod +x my-git.git/hooks/post-update
> 
> as the core-tutorial.txt file shows?  Is that all that is needed?

Indeed.

		Linus
