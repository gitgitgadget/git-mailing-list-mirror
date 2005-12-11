From: Mike McCormack <mike@codeweavers.com>
Subject: Re: [RFC] Planning a git-cvsdaemon
Date: Mon, 12 Dec 2005 05:57:11 +0900
Message-ID: <439C92A7.4030704@codeweavers.com>
References: <46a038f90512101844q326b3d43nf8b40617bd82c576@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 11 21:58:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElYFS-0000or-Sa
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 21:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVLKU4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 15:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVLKU4g
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 15:56:36 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:49353 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1750747AbVLKU4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 15:56:36 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1ElYF9-0005lw-VU; Sun, 11 Dec 2005 14:56:30 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512101844q326b3d43nf8b40617bd82c576@mail.gmail.com>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13508>

Martin Langhoff wrote:

> In any case, I am after feedback in general (and any truly
> insurmountable issues you can think of),  I haven't found yet  a good
> library implementing the server side of the protocol (other than
> cvs's). git-cvsdaemon will probably take shape in Perl initially,
> though if there's a good cvs protocol library in other scripting
> language, I'm interested...

Hey Martin,

That's a neat idea, and a great way to get projects to move from CVS to GIT.

I'd recommend that you avoid providing commit access to a GIT repository 
via CVS for starters.  Many projects (eg. Wine) would benefit greatly 
from just having a way for people to get the source via CVS without 
having to write scripts to maintain a CVS tree in parallel.  Serious 
developers will use GIT if the master repository is GIT anyway.

Mike
