From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] fix imap-send for OSX
Date: Wed, 15 Mar 2006 15:50:17 -0800
Message-ID: <7v8xrbfeti.fsf@assigned-by-dhcp.cox.net>
References: <7vk6avgxva.fsf@assigned-by-dhcp.cox.net>
	<86slpj5ljp.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 00:50:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJfl1-0004Mr-QE
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 00:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWCOXuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 18:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWCOXuU
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 18:50:20 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1778 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751620AbWCOXuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 18:50:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060315234624.HNOK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Mar 2006 18:46:24 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86slpj5ljp.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "15 Mar 2006 15:35:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17625>

Thanks.

How much would we care about non GNU libc I wonder.  We could
just lose that private definition, and say 

	#define _GNU_SOURCE
        #include <stdio.h>

instead, in git-compat-util.h.

But let's leave that to later rounds.
