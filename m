From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-cat-file "Not a valid object name"
Date: Fri, 28 Sep 2007 15:12:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709281511540.3579@woody.linux-foundation.org>
References: <46FD7AA5.2080007@earthdetails.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Reza Roboubi <reza@earthdetails.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 00:12:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbO4q-0007ug-Ax
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 00:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbXI1WMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 18:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbXI1WMp
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 18:12:45 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55805 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752425AbXI1WMo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2007 18:12:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8SMCgcg009903
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Sep 2007 15:12:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8SMCgFE019937;
	Fri, 28 Sep 2007 15:12:42 -0700
In-Reply-To: <46FD7AA5.2080007@earthdetails.com>
X-Spam-Status: No, hits=-2.744 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.41__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59425>



On Fri, 28 Sep 2007, Reza Roboubi wrote:
>
> git-cat-file -t 9b22b50f814b22224d6f838433f1e9cd36bfc2
> 
> says: "Not a valid object name".
> 
> So what is this thing in my .git:
> ../.git/objects/92/9b22b50f814b22224d6f838433f1e9cd36bfc2

The object name for that thing is 929b22b5... You need the two first hex 
digits too (which are used as the fan-out in the object directory).

		Linus
