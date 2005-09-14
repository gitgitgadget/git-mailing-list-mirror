From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-pull to pull branches, not the whole repository
Date: Thu, 15 Sep 2005 01:34:12 +0200
Message-ID: <20050914233412.GG2936@pasky.or.cz>
References: <1126733516.10827.54.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:35:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFglj-0008Ce-AJ
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 01:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVINXeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 19:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVINXeU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 19:34:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10119 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030282AbVINXeU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 19:34:20 -0400
Received: (qmail 10639 invoked by uid 2001); 15 Sep 2005 01:34:16 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1126733516.10827.54.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8575>

Dear diary, on Wed, Sep 14, 2005 at 11:31:56PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> I believe cg-pull should be changed to pull only the objects relevant to
> the branch rather than the whole repository.

well, that should be the case for all the methods but rsync. Actually,
it's not the case for local pulls now either, because git-local-pull
wasn't able to deal with packs, but I think that's fixed by now so I'll
reenable that.

> Ideally, cogito should not rely on the server being able to list
> directories.  This would allow support more protocols and servers, e.g.
> http servers without directory listings.  Unfortunately, listings are
> still needed to get refs/tags and refs/heads.  Any fix for that would
> involve git core, and I don't see an elegant fix.

Well, there's that update-server-info thing. It'd be nice if
git-send-pack could call that automagically or something, so it's kept
up-to-date. But I have no idea about how expensive can the command
actually be.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
