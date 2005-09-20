From: Petr Baudis <pasky@suse.cz>
Subject: Re: GIT - breaking backward compatibility
Date: Tue, 20 Sep 2005 15:08:48 +0200
Message-ID: <20050920130848.GA1884@pasky.or.cz>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net> <432F8C33.5080603@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 15:10:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHhrx-0001x2-JT
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 15:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVITNIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 09:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVITNIw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 09:08:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19378 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965008AbVITNIu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 09:08:50 -0400
Received: (qmail 4204 invoked by uid 2001); 20 Sep 2005 15:08:48 +0200
To: Brian Gerst <bgerst@didntduck.org>
Content-Disposition: inline
In-Reply-To: <432F8C33.5080603@didntduck.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8994>

Dear diary, on Tue, Sep 20, 2005 at 06:12:35AM CEST, I got a letter
where Brian Gerst <bgerst@didntduck.org> told me that...
> Cogito would benefit from this too.  It currently uses git-diff-index 
> and some ugly sed expressions in cg-commit to detect modified files.

Actually, I think most of it is unnecessary - it was around from very
early days, some of it from even before the time when we started
recording adds/removed in the cache. It just doesn't break anything so I
kept it around just to be sure, but I'll remove it soon - I want to
write some cg-commit regression tests first.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
