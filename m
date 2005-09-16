From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update cogito.spec.in
Date: Fri, 16 Sep 2005 11:04:50 -0700
Message-ID: <7vr7bonb25.fsf@assigned-by-dhcp.cox.net>
References: <20050916064720.GI8041@shell0.pdx.osdl.net>
	<20050916110605.GC25169@pasky.or.cz>
	<20050916154631.GJ8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 20:06:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGKZy-0006Hc-NN
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbVIPSEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161212AbVIPSEw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:04:52 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:58285 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161210AbVIPSEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 14:04:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916180451.PYMY3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 14:04:51 -0400
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050916154631.GJ8041@shell0.pdx.osdl.net> (Chris Wright's
	message of "Fri, 16 Sep 2005 08:46:31 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8699>

Chris Wright <chrisw@osdl.org> writes:

> Primary reason is it now requires git, which has those prereqs.

Which I fully agree with.

Could you help me to modernize the git-core.spec.in?  I cannot
even tell if it needs any fix (I am not an RPM guy), but I
suspect dropping Vendor: may apply to git-core as well.
