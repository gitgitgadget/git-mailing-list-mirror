From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: cogito - how do I ???
Date: Mon, 23 May 2005 10:02:22 +0200
Message-ID: <20050523080222.GH23388@cip.informatik.uni-erlangen.de>
References: <20050521214700.GA18676@mars.ravnborg.org> <2765.10.10.10.24.1116713164.squirrel@linux1> <Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org> <20050523071919.GG23388@cip.informatik.uni-erlangen.de> <7v64xa75l3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 23 10:01:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da7s6-0006R1-2G
	for gcvg-git@gmane.org; Mon, 23 May 2005 10:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVEWIC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 04:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVEWIC3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 04:02:29 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63180 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261853AbVEWICY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 04:02:24 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4N82MS8020449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 23 May 2005 08:02:23 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4N82MJL020448
	for git@vger.kernel.org; Mon, 23 May 2005 10:02:22 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v64xa75l3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> It should not.  "diff-tree --stdin" expects the line to begin
> with an SHA1 and it either takes (1) one SHA1 followed by one
> space followed by another SHA1 potentially followed by garbage
> til the newline, or (2) one SHA1 potentially followed by garbage
> til the newline.  rev-tree has the timestamp at the beginning
> which does not match either of them.  What you are doing with
> awk should work, so should this:

thanks for the clarification.

>   git-rev-tree MH ^H | sed -e 's/^[0-9]* //' | git-diff-tree --stdin ...

This is very usefull with a 'pull only' mode.

Thanks,
	Thomas
