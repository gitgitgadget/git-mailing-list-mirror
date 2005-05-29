From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] fix "cg-Xnormid: command not found" error
Date: Sun, 29 May 2005 14:06:28 +0200
Message-ID: <20050529120628.GE1036@pasky.ji.cz>
References: <20050529.121545.77345008.yoshfuji@linux-ipv6.org> <1117360678.7072.53.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: YOSHIFUJI Hideaki / ???????????? <yoshfuji@linux-ipv6.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 14:05:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcMWZ-000630-Ds
	for gcvg-git@gmane.org; Sun, 29 May 2005 14:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVE2MGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 08:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVE2MGc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 08:06:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16873 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261205AbVE2MG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 08:06:29 -0400
Received: (qmail 17610 invoked by uid 2001); 29 May 2005 12:06:28 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1117360678.7072.53.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 29, 2005 at 11:57:57AM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> I made the same patch, but when I used cg-diff to create the patch, I
> got two extra annoying lines at the top.
> 
> commit-id: needs update
> tree-id: needs update
> Index: commit-id
> ===================================================================
> --- c8e987e5e4608c1144293cd3f852210d70b572cb/commit-id  (mode:100755)
> +++ uncommitted/commit-id  (mode:100755)
> 
> I think the "needs update" lines came from "git-update-cache --refresh"
> and we don't really want them there. Should we simply direct the output
> to /dev/null or what?

Oh yes, this is one of the small things I've long meant to fix but never
really got to it. Thanks for reminding me, fixed now. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
