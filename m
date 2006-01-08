From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do I apply a single "change"
Date: Sat, 07 Jan 2006 16:38:08 -0800
Message-ID: <7v7j9b8sgf.fsf@assigned-by-dhcp.cox.net>
References: <20060108003114.4679.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 01:38:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOZd-0007gi-Sv
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWAHAiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWAHAiM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:38:12 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18873 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161105AbWAHAiK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 19:38:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060108003658.GIZK20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 19:36:58 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20060108003114.4679.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Sat, 7 Jan 2006 16:31:14 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14296>

Luben Tuikov <ltuikov@yahoo.com> writes:

> ... how do I apply a single "change", identified
> by its SHA?  Either from one branch to the other or
> remote?
>
> I.e. I want to "integrate" only that change?

$ git-cherry-pick $object_name

> Alternatively, how do I apply the absolute output of
> "git-format-patch".  I tried but whatever I tried with
> complained that it couldn't find any email addressess.
> (roll eyes here)

It is unclear what you mean by absolute output, but here is what
I regularly do:

$ git-format-patch -k -m --stdout from to | git am -3 -k
