From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix cloning (memory corruption)
Date: Wed, 26 Oct 2005 13:08:43 -0700
Message-ID: <7vmzkwca7o.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510261616550.21073@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 22:10:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUrZn-0003oI-Lv
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVJZUIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 16:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVJZUIp
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 16:08:45 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:13214 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964912AbVJZUIo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 16:08:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026200828.PNIB1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 16:08:28 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510261616550.21073@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 26 Oct 2005 16:18:56 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10690>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> upload-pack would set create_full_pack=1 if nr_has==0, but would ask later
> if nr_needs<MAX_NEEDS. If that proves true, it would ignore create_full_pack,
> and arguments would be written into unreserved memory.

Thanks.
