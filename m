From: David Brown <git@davidb.org>
Subject: Re: git packs
Date: Fri, 9 Nov 2007 23:59:48 -0800
Message-ID: <20071110075948.GA29288@old.davidb.org>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <alpine.LFD.0.9999.0711100011150.21255@xanadu.home> <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com> <DF65F7E4-448A-4726-8B42-642776155A8F@vicaya.com> <alpine.LFD.0.999.0711092254130.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Luke Lu <git@vicaya.com>, bob <kranki@mac.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 09:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqlGE-0007F0-KK
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 09:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbXKJH7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 02:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbXKJH7y
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 02:59:54 -0500
Received: from mail.davidb.org ([66.93.32.219]:49843 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbXKJH7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 02:59:53 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IqlFs-0007io-BO; Fri, 09 Nov 2007 23:59:48 -0800
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>, bob <kranki@mac.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0711092254130.15101@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64315>

On Fri, Nov 09, 2007 at 10:58:16PM -0800, Linus Torvalds wrote:

>But hearing whether -m64 makes a difference would be interesting. I'm 
>hoping OS X is LP64, not some insane half-way thing like Vista is.

Some casual tests with printf and sizeof makes it look like it is.  At
least sizeof (void *) and sizeof (long) are both 8.

David
