From: Junio C Hamano <junkio@cox.net>
Subject: Re: using-topic-branches.txt
Date: Sun, 18 Dec 2005 21:43:00 -0800
Message-ID: <7vfyoplk0r.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056F93AC@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 06:44:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoDnf-0003lH-Jp
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 06:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVLSFnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 00:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbVLSFnE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 00:43:04 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36780 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030283AbVLSFnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 00:43:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051219054107.MXUE17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 00:41:07 -0500
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30056F93AC@hdsmsx401.amr.corp.intel.com>
	(Len Brown's message of "Sun, 18 Dec 2005 23:13:28 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13815>

"Brown, Len" <len.brown@intel.com> writes:

> This works for me, but now it requires a password to update
> when before it did not.

You are right.  I do not have preference either way myself what
to put in this document.  However, the change stops recommending
rsync://, which is something I prefer to keep.

The reason for the change from public machine to master already
got an objection from Jeff.  The reasoning was because I
understand that Linus pulls from master to avoid mirroring lags
(and he publicly stated he does so number of times), and the
workflow recommended for subsystem maintainers, the primary
audience of this document, should not slow them down by pulling
from public machines.
