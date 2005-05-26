From: Petr Baudis <pasky@ucw.cz>
Subject: Re: seek request
Date: Thu, 26 May 2005 10:29:41 +0200
Message-ID: <20050526082941.GC22262@pasky.ji.cz>
References: <20050522071106.GA8060@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 10:32:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbDm1-0003Y4-By
	for gcvg-git@gmane.org; Thu, 26 May 2005 10:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVEZIc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 04:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVEZIc0
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 04:32:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28589 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261289AbVEZI3n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 04:29:43 -0400
Received: (qmail 29190 invoked by uid 2001); 26 May 2005 08:29:41 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050522071106.GA8060@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 22, 2005 at 09:11:06AM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> Hi folks,
> 
> In Cogito, it would be nice to have a
> 
> cg-seek +
> 
> that would seek to the next archive state. This way, I could start off seeking
> back to the beginning of an archive, and quickly step forward, looking at files
> as I went, to the present.
> 
> A corresponding
> cg-seek -
> would go the reverse direction, back toward the beginning of a project.
> 
> I'm not sure how useful this would be for actual source code - I suspect any
> benefit would be minimal - but the benefit for documentation and text files,
> where the only way to test improvements is to read them by eye, would be
> significant.

Well, and what if the commit has multiple parents? Or - even much more
interestingly - multiple children?

If we keep applying the first parent rule, we could just traverse the
graph from heads/master to HEAD following this rule, and then just take
a step back to where we came from for cg-seek +. It wouldn't be exactly
cheap, but it'd probably work.

Patch welcomed. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
