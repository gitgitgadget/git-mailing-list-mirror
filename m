From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] mkdelta enhancements
Date: Wed, 25 May 2005 21:48:17 -0700
Message-ID: <7vll62egoe.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505252340270.16151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 06:47:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbAGT-0000qK-CM
	for gcvg-git@gmane.org; Thu, 26 May 2005 06:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVEZEsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 00:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEZEsX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 00:48:23 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7834 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261202AbVEZEsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 00:48:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526044819.GGBN7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 00:48:19 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505252340270.16151@localhost.localdomain> (Nicolas
 Pitre's message of "Wed, 25 May 2005 23:57:49 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have not measured and I have not studied how the current
mkdelta does things, but if you are not doing so already it may
make sense to keep the later one expanded in full and represent
older ones as delta, since that would give faster access to more
often used items (I am assuming more recent version are likely
to be accessed more frequently, which I believe is what SCMs
typically do.  RCS format is geared towards this AFAICR).

