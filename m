From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to create a new branch based on a tag?
Date: Thu, 20 Oct 2005 20:50:30 -0700
Message-ID: <7vsluv5y0p.fsf@assigned-by-dhcp.cox.net>
References: <435901F7.9020509@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 05:52:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESnvd-0000CT-CY
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 05:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVJUDue (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 23:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVJUDue
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 23:50:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17037 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964857AbVJUDue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 23:50:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051021035031.WOIY9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Oct 2005 23:50:31 -0400
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <435901F7.9020509@ust.hk> (Ben Lau's message of "Fri, 21 Oct 2005
	22:57:59 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10413>

Ben Lau <benlau@ust.hk> writes:

> As v2.6.11 is a tree object(tag), git-checkout and git-branch could 
> not process it. The
> only way I know is using git-read-tree to fetch v2.6.11 content into 
> current index and start
> a branch based on it. Is there any simpler method?

The way you know is as good as it gets.  v2.6.11-tree case is
really an unfortunate special case.
