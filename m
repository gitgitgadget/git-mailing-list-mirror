From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-update question.
Date: Mon, 12 Sep 2005 02:02:10 +0200
Message-ID: <20050912000210.GA15630@pasky.or.cz>
References: <43082A96.1070700@mozilla.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 02:03:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEbmA-0007dc-NE
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 02:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVILACS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVILACS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 20:02:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27305 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751087AbVILACR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 20:02:17 -0400
Received: (qmail 20882 invoked by uid 2001); 12 Sep 2005 02:02:10 +0200
To: Johnny Stenback <jst@mozilla.org>
Content-Disposition: inline
In-Reply-To: <43082A96.1070700@mozilla.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8345>

Dear diary, on Sun, Aug 21, 2005 at 09:17:42AM CEST, I got a letter
where Johnny Stenback <jst@mozilla.org> told me that...
> Hi all,

Hello,

> I just realized that if I've got an uncommitted local change in a tree 
> and I update my tree with cg-update to merge in changes from a different 
> tree... cg-update will pull the changes and do the merge. So that's all 
> cool, but as it does the merge, it will re-write my local file that has 
> the uncommitted change, even if that file didn't change in the 
> repository I pulled from, i.e. nothing to merge for that file.
> 
> This is, to me at least, not the desired behavior, if there's no reason 
> for cg-update to touch a file it shouldn't.
> 
> Thoughts? If someone points me in the right direction I'm willing to 
> take a stab at fixing this myself...

can you provide a concrete example of such a situation? This should
never ever happen - cg-update should refuse to touch any files
containing uncommitted changes.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
