From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 23:03:30 +0200
Message-ID: <20050420210330.GD19112@pasky.ji.cz>
References: <20050420205633.GC19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 20 23:00:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMI6-0004fS-2X
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 22:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDTVDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVDTVDe
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:03:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57565 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261798AbVDTVDb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 17:03:31 -0400
Received: (qmail 1737 invoked by uid 2001); 20 Apr 2005 21:03:30 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050420205633.GC19112@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 10:56:33PM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
>   cg pull will now always only pull, never merge.
> 
>   cg update will do pull + merge.

Note that what you will probably do _most_ by far is cg update.
You generally do cg pull only when you want to make sure you have the
latest and greatest when doing some cg diff or whatever, or on your
notebook when getting on an airplane. And you do direct cg merge generally
only on the airplane.

I also forgot one last usage change:

  cg fork BNAME BRANCH_DIR [COMMIT_ID]
  ->
  cg fork BRANCH_DIR [BNAME] [COMMIT_ID]

This will bring its usage in sync to both cg export and cg tag.
The branch name will also default to the last element in the
BRANCH_DIR path (that annoyed me a lot, basically writing a thing
two times at single line).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
