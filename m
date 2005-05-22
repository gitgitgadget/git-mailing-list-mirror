From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 21:05:54 +0200
Message-ID: <20050522190554.GA23388@cip.informatik.uni-erlangen.de>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net> <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org> <20050522184237.GG18500@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 21:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvkz-0004YJ-Nm
	for gcvg-git@gmane.org; Sun, 22 May 2005 21:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVEVTGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 15:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEVTGG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 15:06:06 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:30684 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261275AbVEVTF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 15:05:57 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MJ5tS8024476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 May 2005 19:05:55 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MJ5smc024475
	for git@vger.kernel.org; Sun, 22 May 2005 21:05:54 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> The machine readable format has the same issue: it needs to be able to 
> distinguish between a "copy" (where the source remains) and a "rename" 
> (where the source is removed). So you still need the "*/-" thing, and then 
> you're better off doing "+" and "/" too in the machine-readable format, to 
> make the differences be as small as possible _and_ to avoid confusion if a 
> pathname starts with '*' or '-'.

thanks, I see the point now.

	Thomas
