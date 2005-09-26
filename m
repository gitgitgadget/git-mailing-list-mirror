From: walt <wa1ter@myrealbox.com>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 12:23:07 -0700
Organization: none
Message-ID: <dh9hqs$6nl$1@sea.gmane.org>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org> <dh98gk$6rp$1@sea.gmane.org> <Pine.LNX.4.58.0509261038460.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 26 21:32:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJye6-0005Ux-Aq
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 21:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVIZT2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 15:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVIZT2I
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 15:28:08 -0400
Received: from main.gmane.org ([80.91.229.2]:1741 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932473AbVIZT2G (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 15:28:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EJyba-0004eY-IG
	for git@vger.kernel.org; Mon, 26 Sep 2005 21:25:38 +0200
Received: from adsl-69-234-186-98.dsl.irvnca.pacbell.net ([69.234.186.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2005 21:25:38 +0200
Received: from wa1ter by adsl-69-234-186-98.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2005 21:25:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-186-98.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20050926)
In-Reply-To: <Pine.LNX.4.58.0509261038460.3308@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9323>

Linus Torvalds wrote:
> 
> On Mon, 26 Sep 2005, walt wrote:
>> Just because you mentioned it, I did a git-fsck-objects on my local
>> copies of your kernel tree and Junio's git tree.
>>
>>  From git I got this:
>> $git-fsck-objects
>> missing commit 00d8bbd3c4bba72a6dfd48c2c0c9cbaa000f13c2
>> broken link from     tag 02b2acff8bafb6d73c6513469cdda0c6c18c4138
>>                to  commit d5bc7eecbbb0b9f6122708bf5cd62f78ebdaafd8
>> <similar lines snipped>
>>
>>  From your tree I got only this single line:
>> dangling commit 02459eaab98a6a57717bc0cacede148fc76af881
> 
> That commit shouldn't be dangling, but I suspect it is harmless and is
> most likely because you have pack-files. Use "git-fsck-cache --full"

Using the --full flag made the error disappear for your kernel tree,
but had no effect on the git tree.

I neglected to mention that I use cg-clone and cg-update rather than
the git equivalents.  (cogito 0.15.1 from kernel.org)


> Your git tree is quote possibly corrupted.

I recloned from http://kernel.org and I still get exactly the same fsck
errors for git, with or without the --full flag.

(I mention this only FYI.  I'm not having any problems compiling or
using either git or the kernel.)
