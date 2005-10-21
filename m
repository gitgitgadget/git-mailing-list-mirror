From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito RFE: cg-commit -q
Date: Sat, 22 Oct 2005 00:06:29 +0200
Message-ID: <20051021220629.GK30889@pasky.or.cz>
References: <434E9D50.2040807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 00:08:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET522-0002rQ-QZ
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 00:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVJUWGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 18:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVJUWGc
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 18:06:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5035 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965180AbVJUWGb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 18:06:31 -0400
Received: (qmail 16930 invoked by uid 2001); 22 Oct 2005 00:06:29 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <434E9D50.2040807@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10452>

Dear diary, on Thu, Oct 13, 2005 at 07:45:52PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> I would find it very useful if cg-commit had a "-q" option, meaning 
> "silently skip this commit if there is nothing to commit."  There are 
> some automatic release scripts that I have which enforces consistency 
> before release, but if the repository is already correctly set up for 
> release, there is nothing to do.
> 
> This is the opposite of -f, which would create a commit object pointing 
> to the same tree.

Thanks for the idea, implemented.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
