From: Mike McCormack <mike@codeweavers.com>
Subject: Re: pushing patches to an imap folder
Date: Wed, 16 Nov 2005 10:53:13 +0900
Organization: CodeWeavers
Message-ID: <437A9109.6010101@codeweavers.com>
References: <43799A67.9030705@codeweavers.com>	<7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net>	<4379B9F6.5020402@codeweavers.com> <7vzmo5ka20.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Nov 16 02:57:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcCWz-0002ay-UD
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 02:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVKPB4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 20:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVKPB4L
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 20:56:11 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:65004 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S965162AbVKPB4K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 20:56:10 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1EcCWs-0004KM-7E; Tue, 15 Nov 2005 19:56:09 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmo5ka20.fsf@assigned-by-dhcp.cox.net>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11987>


Junio C Hamano wrote:

> Wow.  How is the acceptance by wine community?  Favorable, I
> hope.

wine.git hasn't been announced on any of the wine mailing lists yet.  As 
long as we don't get rid of CVS entirely, I don't think there'll be too 
many complaints.  Hopefully when it's announced, we'll have a few GIT 
users who can tell people why it's good to use.

> git-cvsexportcommit?  I haven't had a chance to use it myself,
> although I have to interoperate with CVS in some projects.
> Martin, do you want to do a plug (or brag) here?

git-cvsexportcommit looks nice.  I guess Alexandre is using something 
like that now.  I was thinking more ambitiously... something like a 
git-cvsd.  That would be a pretty awesome migration tool :)

> It is handy, especially for simple things like rebasing topic
> branches, when the things are of managable size without using
> quilt or StGIT.  Do you manage binary files?

No, there's no binary files in the Wine CVS (or symlinks ;).

> Yes, I saw that value there.  Maybe adding hooks to format-patch
> so that it can do form-letter-ish things you had to add there
> without patching might help?  I dunno.

I'll have a go at integrating my code with format-patch.  Hooks for a 
template would be helpful.

Mike
