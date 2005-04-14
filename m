From: Erik van Konijnenburg <ekonijn@xs4all.nl>
Subject: Re: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 22:23:26 +0200
Message-ID: <20050414222326.E2442@banaan.localdomain>
References: <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 22:20:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMAp0-0007yS-Fn
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 22:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDNUXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 16:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVDNUXl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 16:23:41 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:19212 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S261378AbVDNUXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 16:23:39 -0400
Received: from banaan.xs4all.nl (banaan.xs4all.nl [80.126.2.237])
	by smtp-vbr14.xs4all.nl (8.12.11/8.12.11) with ESMTP id j3EKNRfg011538;
	Thu, 14 Apr 2005 22:23:27 +0200 (CEST)
	(envelope-from konijn@banaan.xs4all.nl)
Received: (from konijn@localhost)
	by banaan.xs4all.nl (8.11.6/8.11.6) id j3EKNRo03995;
	Thu, 14 Apr 2005 22:23:27 +0200
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050414193507.GA22699@pasky.ji.cz>; from pasky@ucw.cz on Thu, Apr 14, 2005 at 09:35:07PM +0200
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 14, 2005 at 09:35:07PM +0200, Petr Baudis wrote:
> Hmm. I actually don't like this naming. I think it's not too consistent,
> is irregular, therefore parsing it would be ugly. What I propose:
> 
> 12c\tname <- legend
>           <- original file
> D         <- tree #1 removed file
>  D        <- tree #2 removed file
> DD        <- both trees removed file
> M         <- tree #1 modified file
>  M
> DM*       <- conflict, tree #1 removed file, tree #2 modified file
> MD*
> MM        <- exact same modification
> MM*       <- different modifications, merging
> 
> This is generic, theoretically scales well even to more trees, is easy
> to parse trivially, still is human readable (actually the asterisk in
> the 'conflict' column is there basically only for the humans), is
> completely regular and consistent.

Detail: perhaps use underscore instead of space, to avoid space/tab typos
that are invisible on paper and user friendly mail clients?

Regards,
Erik
