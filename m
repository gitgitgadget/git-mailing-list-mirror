From: Junio C Hamano <junkio@cox.net>
Subject: Re: [cogito] paged output for cg-diff
Date: Fri, 20 May 2005 05:53:58 -0700
Message-ID: <7v64xevz15.fsf@assigned-by-dhcp.cox.net>
References: <200505201105.08711.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 14:55:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ707-0004i8-03
	for gcvg-git@gmane.org; Fri, 20 May 2005 14:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVETMyC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 08:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVETMyC
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 08:54:02 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:61692 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261450AbVETMx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 08:53:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520125359.BSUV1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 08:53:59 -0400
To: Michal Rokos <michal.rokos@nextsoft.cz>
In-Reply-To: <200505201105.08711.michal.rokos@nextsoft.cz> (Michal Rokos's
 message of "Fri, 20 May 2005 11:05:08 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MR" == Michal Rokos <michal.rokos@nextsoft.cz> writes:

MR> I'm a bit curious what is going on in development so I'm using cg-diff
MR> often. Usually I pipe it to the less. So for me it would be very nice
MR> when cg-diff behaves as cg-log that pipes output to pager.

I think that is a sensible thing to do.  But doesn't "less"
already do this part without being told?

MR> +PAGER () {
MR> + if [ -t 1 ]; then
MR> +  ${PAGER:-less} ${PAGER_FLAGS:--R}
MR> + else
MR> +  cat
MR> + fi
MR> +}


