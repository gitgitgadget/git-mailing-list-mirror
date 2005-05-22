From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Alternate Patch: [PATCH] Don't include device number in cache invalidation when running on NFS
Date: Mon, 23 May 2005 00:07:34 +0200
Message-ID: <20050522220734.GF23388@cip.informatik.uni-erlangen.de>
References: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221205580.2307@ppc970.osdl.org> <20050522192734.GB23388@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221332590.2307@ppc970.osdl.org> <20050522212312.GC23388@cip.informatik.uni-erlangen.de> <20050522214115.GD23388@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221451590.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 23 00:09:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZyaa-00042y-8s
	for gcvg-git@gmane.org; Mon, 23 May 2005 00:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVEVWHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 18:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEVWHm
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 18:07:42 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:46332 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261739AbVEVWHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 18:07:35 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MM7YS8009289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 May 2005 22:07:35 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MM7YIi009288
	for git@vger.kernel.org; Mon, 23 May 2005 00:07:34 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505221451590.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> This is _really_ Linux-specific afaik. Which is ok for git, but at the
> same time it really makes me go "Ewww". It's testing that the major number 
> is 0, and it would be a lot more cleaner to use 

> 	if (!major(st.st_dev))

> but even that is very Linux-specific.

I see.

> I'll have to think about it. Maybe I should just remove the st_dev check. 
> I guess inode/size/mtime/ctime should be plenty safe enough in practice.

I think so. At least I kick this one out because it is just getting on
my nerves. :-)

	Thomas
