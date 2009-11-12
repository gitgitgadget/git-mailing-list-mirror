From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 23:11:21 -0800
Message-ID: <20091112071121.GA569@dcvr.yhbt.net>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com> <4AFA91BB.7050402@obry.net> <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com> <4AFB1756.7090708@obry.net> <20091111202201.GA10351@dcvr.yhbt.net> <20091111203413.GA9648@dcvr.yhbt.net> <4AFB32DC.50505@obry.net> <20091111224454.GA16178@dcvr.yhbt.net> <4AFBADA9.3060401@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 08:11:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Tq5-0007kr-3g
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 08:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbZKLHLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 02:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbZKLHLR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 02:11:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38261 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbZKLHLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 02:11:17 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76521F679;
	Thu, 12 Nov 2009 07:11:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AFBADA9.3060401@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132741>

Pascal Obry <pascal@obry.net> wrote:
> Eric,
>
>> Did you try an early version of Adam's patch before it made it into
>> git.git by any chance?
>
> No.
>
>> Or, did you by any chance start a fresh import with a v1.6.5 and then
>> rsync $GIT_DIR to one created with 1.6.4 and not use --delete with
>> rsync?
>
> No. The import has been done with 1.6.4. A filter-branch has been  
> applied to fix author names. But AFAIK (will check) it has been done  
> with 1.6.4 too.

Oh...  Any chance that lost commit you couldn't find was clobbered
by filter-branch?  That would explain a lot...

-- 
Eric Wong
