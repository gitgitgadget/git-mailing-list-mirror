From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Thu, 19 May 2005 01:23:19 -0700
Message-ID: <7voeb7lj48.fsf@assigned-by-dhcp.cox.net>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
	<20050517190355.GA7136@pasky.ji.cz>
	<7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
	<20050517203500.GH7136@pasky.ji.cz>
	<7v4qd1tuud.fsf@assigned-by-dhcp.cox.net>
	<20050517213752.GO7136@pasky.ji.cz>
	<7vzmutqz5f.fsf@assigned-by-dhcp.cox.net>
	<20050518213309.GD10358@pasky.ji.cz>
	<7vekc4nom5.fsf@assigned-by-dhcp.cox.net>
	<20050518232408.GA18281@pasky.ji.cz>
	<20050519074007.GI4738@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 19 10:28:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYgIn-0002YK-1Z
	for gcvg-git@gmane.org; Thu, 19 May 2005 10:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVESIX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 04:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVESIX2
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 04:23:28 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:27606 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262469AbVESIXX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 04:23:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519082320.FVEN1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 04:23:20 -0400
To: git@vger.kernel.org
In-Reply-To: <20050519074007.GI4738@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Thu, 19 May 2005 09:40:07 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> Hello,
>> > <http://members.cox.net/junkio/per-file-commit.txt> ;-).

>> I think the workflow that involves per-file commit is
>> fundamentally broken at two levels.

TG> I disagree here. We at FAUmachine often have FLAGS to turn on specific
TG> features or debugging output by tweaking a headerfile.

So what?  I would understand that in your workflow, the nature
of that never-committed headerfile (the fact it only has
debugging tweaks and contains nothing substantially risky)
practically minimizes the risk to the level everybody in the
group feels acceptable.

That does not, however, change what I stated in the document:
what you have in the repository is something that never existed
in a work tree as a consistent whole and tested.

You are only saying is that it does not practically matter in
your workflow, only because what is floating (not checked in)
are things you feel safe to drift.  I would not dare say that is
a wrong way to work.

However, I feel fairly strong about this after being burned many
times by careless coleagues who forgot to check in either newly
created files or locally modified files and finding problems
only after customer installation happened.

