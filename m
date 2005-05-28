From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Pickaxe fixes.
Date: Sat, 28 May 2005 18:22:57 +0200
Message-ID: <20050528162257.GE4881@cip.informatik.uni-erlangen.de>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net> <7v7jhjy8uw.fsf@assigned-by-dhcp.cox.net> <20050528105914.GA8467@cip.informatik.uni-erlangen.de> <7vpsvbuxzb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 18:35:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1Dc43T-0004u2-00
	for <gcvg-git@gmane.org>; Sat, 28 May 2005 18:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVE1QXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 12:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVE1QXG
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 12:23:06 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:24275 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261160AbVE1QXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 12:23:04 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4SGMwS8008910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 May 2005 16:22:58 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4SGMvhI008909;
	Sat, 28 May 2005 18:22:58 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsvbuxzb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> I agree with Linus that the latter is the semantics we usually
> want.  If we make diffcore filters stackable (I mean, the order
> of applications controllable by the program and the user), we
> could also have the older semantics when the user wants it, but
> I would do that after this series stabilizes.

thanks for the elaboration on this topic. However at the moment I don't
have an opinion on this, I have to use it a bit longer. But it is a good
thing that I know by now that it limits its view to the subdirectory
after your patch-train is applied.

	Thomas
