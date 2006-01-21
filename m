From: walt <wa1ter@myrealbox.com>
Subject: Re: cg-update bug?
Date: Sat, 21 Jan 2006 13:59:29 -0800
Organization: none
Message-ID: <dquas0$t5t$1@sea.gmane.org>
References: <dqo6fs$sr$1@sea.gmane.org> <dqtih0$i80$1@sea.gmane.org> <20060121203519.GN28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 21 22:59:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Qlu-0007H8-SE
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 22:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWAUV7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 16:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWAUV7o
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 16:59:44 -0500
Received: from main.gmane.org ([80.91.229.2]:5584 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932376AbWAUV7n (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 16:59:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1F0Qlq-0007Gc-Bc
	for git@vger.kernel.org; Sat, 21 Jan 2006 22:59:42 +0100
Received: from adsl-69-234-188-194.dsl.irvnca.pacbell.net ([69.234.188.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jan 2006 22:59:42 +0100
Received: from wa1ter by adsl-69-234-188-194.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jan 2006 22:59:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-188-194.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060121)
In-Reply-To: <20060121203519.GN28365@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15025>

Petr Baudis wrote:
> Dear diary, on Sat, Jan 21, 2006 at 04:03:59PM CET, I got a letter
> where walt <wa1ter@myrealbox.com> said that...
>> Thanks for adding the flag, Petr.  I tried it on git and
>> the kernel this morning, and in each case cg-update -v
>> printed the name of only one file.  From looking at the
>> logs I'm pretty sure there were multiple files updated,
>> not just one.  Does it print all filenames for you?

> It prints all the filenames for me, but only the fetched ones. If you
> fetched without merge earlier, it will list only the newly fetched
> stuff. That is rather confusing, so now I added also cg-merge -v and
> cg-update will pass its -v to cg-merge instead of cg-fetch.

Well, I was anxious to try your new changes so I did cg-update on
your cogito repository and I saw *six* updated files print out.

I guess that both git and the kernel really did have only *one*
updated file this morning, after all.  A really bizarre coincidence!
Thanks again for the update, and I hope your exam went well :o)
