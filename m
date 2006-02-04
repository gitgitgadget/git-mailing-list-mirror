From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree --cc on the dodecapus
Date: Sat, 04 Feb 2006 05:01:22 -0800
Message-ID: <7vy80rwa59.fsf@assigned-by-dhcp.cox.net>
References: <17380.37855.117313.631961@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 14:01:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5N2g-0003A8-ER
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 14:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWBDNBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 08:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBDNBY
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 08:01:24 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64950 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751449AbWBDNBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 08:01:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204130018.OHHL15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 08:00:18 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17380.37855.117313.631961@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sat, 4 Feb 2006 22:45:35 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15594>

Paul Mackerras <paulus@samba.org> writes:

> Junio,
>
> When I use git diff-tree --cc on Len's dodecapus merge (9fdb62af), the
> first diff hunk that it shows is this:

Yeah, I noticed it too, and you described how that happens quite
well.  The algorithm is simplistic and improvement patches are
welcome.
