From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon enabled on kernel.org
Date: Wed, 19 Oct 2005 02:02:30 -0700
Message-ID: <7v7jc9dgm1.fsf@assigned-by-dhcp.cox.net>
References: <43554D4F.7040403@zytor.com>
	<20051019083542.GA31526@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 11:05:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES9qR-00060o-Rb
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 11:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVJSJCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 05:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVJSJCe
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 05:02:34 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54726 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932484AbVJSJCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 05:02:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019090203.VLNQ11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 05:02:03 -0400
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20051019083542.GA31526@harddisk-recovery.com> (Erik Mouw's
	message of "Wed, 19 Oct 2005 10:35:42 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10279>

Erik Mouw <erik@harddisk-recovery.com> writes:

> How do I tell git to change the default repository to pull from?

Depends on how you are currently telling git what your "default
repository to pull from" is.  If you are using git-core
(i.e. git-pull and git-fetch) for downloading, either
.git/remotes/origin or .git/branches/origin file are used in
this order; if you are using Cogito for downloading, it uses
.git/branches/origin IIRC.
