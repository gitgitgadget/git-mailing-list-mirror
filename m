From: Dan Aloni <da-x@monatomic.org>
Subject: Re: [PATCH] Limit the number of requests outstanding in ssh-fetch.
Date: Tue, 4 Oct 2005 10:16:38 +0300
Message-ID: <20051004071638.GA23725@localdomain>
References: <Pine.LNX.4.63.0510040016110.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:14:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMgyq-0005CT-Ve
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 09:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVJDHMu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 03:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVJDHMu
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 03:12:50 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:16361 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932451AbVJDHMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 03:12:50 -0400
Received: from bzq-82-80-223-232.red.bezeqint.net
	([82.80.223.232]:34606 helo=callisto.yi.org ident=karrde)
	by noname.neutralserver.com with esmtpa (Exim 4.52)
	id 1EMgyj-000810-Em; Tue, 04 Oct 2005 02:12:45 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510040016110.23242@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9665>

On Tue, Oct 04, 2005 at 12:24:55AM -0400, Daniel Barkalow wrote:
> This completes fetches if there are more than 100 outstanding requests
> and there are more to prefetch.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> 
> Lightly tested; I reduced the limit to 5, and pulled a small tree 
> successfully with some of the requests being completed early. I didn't 
> have the test case to verify that a limit of 100 is sufficiently low, but 
> handwaving suggests that it should be.

Good, it seems that your patch works alright with the local Linux complete 
database fetch.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
