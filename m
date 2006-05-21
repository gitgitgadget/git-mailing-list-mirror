From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk highlight feature
Date: Sun, 21 May 2006 10:40:14 +1000
Message-ID: <17519.46830.626777.438845@cargo.ozlabs.ibm.com>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0605021659430.4086@g5.osdl.org>
	<Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
	<17496.7073.507895.484698@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0605030946260.4086@g5.osdl.org>
	<17518.24000.952384.563448@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0605200934240.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 02:53:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhcCI-0008Lu-Kd
	for gcvg-git@gmane.org; Sun, 21 May 2006 02:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWEUAx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 20:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWEUAx2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 20:53:28 -0400
Received: from ozlabs.org ([203.10.76.45]:1696 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932234AbWEUAx1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 20:53:27 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 87976679F8; Sun, 21 May 2006 10:53:26 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605200934240.10823@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20414>

Linus Torvalds writes:

> I think the "Find" field should highlight things too. Right now there's no 
> way to get highlighting for somebody having signed-off on a patch, for 
> example, even though you can _search_ for it.

Yes, I think the way to go is to extend the highlight feature to be
able to do everything that the "Find" function can do, and then I
think the "Find" function won't be needed any more.

> Also, right now it says "Author/committer", but it actually only triggers 
> on author. Which may be the right thing to do (it's certainly what I'd 
> normally want to see), but it doesn't match the description. 

If the author matches, it highlights both the headline and the
author.  If the committer matches, it highlights only the headline (as
it does for any other highlighting).  Try it with "torvalds" in the
author/committer field on commit a54c9d30 (compared to cb46c370,
say).  If that's confusing I can change it of course.

Paul.
