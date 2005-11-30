From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT_OBJECT_DIRECTORY handling broken on master.kernel.org?
Date: Wed, 30 Nov 2005 10:50:14 -0800
Message-ID: <7v64qaug0p.fsf@assigned-by-dhcp.cox.net>
References: <1133359173.4117.68.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 20:12:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhX28-0006TD-A7
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 19:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbVK3SuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 13:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbVK3SuT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 13:50:19 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64184 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751495AbVK3SuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 13:50:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130184845.DMRL17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 13:48:45 -0500
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1133359173.4117.68.camel@baythorne.infradead.org> (David
	Woodhouse's message of "Wed, 30 Nov 2005 13:59:33 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13013>

David Woodhouse <dwmw2@infradead.org> writes:

> Daily kernel snapshots broke again. Trying to access, literally, "GIT_OBJECT_DIRECTORY".

Sorry about that.
Tommi Virtanen's patch looks correct.
