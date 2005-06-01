From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] One Git To Rule Them All
Date: Wed, 01 Jun 2005 09:12:07 -0700
Message-ID: <7vekbmkqeg.fsf@assigned-by-dhcp.cox.net>
References: <20050601055833.GA14231@port.evillabs.net>
	<7vis0yr41f.fsf@assigned-by-dhcp.cox.net>
	<1117627661.19629.1.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:15:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdVpr-00023q-SO
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 18:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVFAQPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 12:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVFAQPK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 12:15:10 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41866 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261462AbVFAQMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 12:12:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601161208.OEIM550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 12:12:08 -0400
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
In-Reply-To: <1117627661.19629.1.camel@jmcmullan.timesys> (Jason McMullan's
 message of "Wed, 01 Jun 2005 08:07:41 -0400, Wed, 1 Jun 2005 08:00:57
 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JM" == McMullan, Jason <jason.mcmullan@timesys.com> writes:

JM> Am I missing something here?

No, but one thing I failed to mention was that I am not a big
fan of busybox.  It is a cute hack to save "disk" space in an
embedded environment, but I find the way many commands are
bundled together a bit too hacky for my taste to use on my
regular work box.  I also suspect the change makes the
maintenance of the result harder than having them separate.

You said with this change there is only one file to install, but
you are not bundling the git-* scripts in the "single git", so
that claim is not true either.  If your patch handled the git-*
script parts as well, then I would have admired that part of the
change ;-).

Personally I find the mandatory documentation requirements this
patch brings us is a good thing ;-).

