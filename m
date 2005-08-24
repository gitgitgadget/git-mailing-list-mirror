From: Junio C Hamano <junkio@cox.net>
Subject: Re: Query about status of http-pull
Date: Wed, 24 Aug 2005 11:16:57 -0700
Message-ID: <7v1x4jfbdy.fsf@assigned-by-dhcp.cox.net>
References: <1124899847.7187.18.camel@lycan.lan>
	<Pine.LNX.4.63.0508241233260.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 20:19:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7zo7-0003fd-0Z
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVHXSRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVHXSRA
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:17:00 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18892 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751344AbVHXSQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 14:16:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824181659.CTEN7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 14:16:59 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508241233260.23242@iabervon.org> (Daniel
	Barkalow's message of "Wed, 24 Aug 2005 12:39:13 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7716>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It looks like pack-c24bb5025e835a3d8733931ce7cc440f7bfbaaed isn't in the
> pack list. I suspect that updating this file should really be done by
> anything that creates pack files, because people forget to run the program
> that does it otherwise and then http has problems.

True.

Added at the end of git-repack-script (Linus can disable it by
giving an '-n' flag when packing his private repositories).
