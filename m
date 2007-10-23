From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk patch collection pull request
Date: Tue, 23 Oct 2007 16:51:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710231647350.30120@woody.linux-foundation.org>
References: <20071019052823.GI14735@spearce.org>
 <alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
 <18201.34779.27836.531742@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710192149020.3794@woody.linux-foundation.org>
 <18205.15967.792413.775786@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710231214150.30120@woody.linux-foundation.org>
 <18206.34254.741787.255299@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 01:51:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkTXP-0001ii-5D
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 01:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbXJWXvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 19:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbXJWXvn
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 19:51:43 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47288 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752752AbXJWXvm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 19:51:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NNpYOS020359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 16:51:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NNpXhQ012551;
	Tue, 23 Oct 2007 16:51:33 -0700
In-Reply-To: <18206.34254.741787.255299@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62171>



On Wed, 24 Oct 2007, Paul Mackerras wrote:
> 
> Is it completely empty, or does it have just the "Comments" entry at
> the top?

Just the comment.

> Can you give me an example of a gitk command line that shows the
> problem on the kernel tree?

Happened for just a random directory I tested. According to my bash 
history, it seems to have been

	gitk v2.6.23.. drivers/char/

which is pretty basic..

		Linus
