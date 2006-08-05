From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] gitweb: bugfix: git_commit and git_commitdiff parents
Date: Fri, 04 Aug 2006 17:00:09 -0700
Message-ID: <7vzmekgigm.fsf@assigned-by-dhcp.cox.net>
References: <20060804221147.18778.qmail@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 02:00:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G99aS-0001oF-0d
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 02:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWHEAAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 20:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWHEAAM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 20:00:12 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:730 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422647AbWHEAAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 20:00:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805000010.EGWA12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 20:00:10 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060804221147.18778.qmail@web31801.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 4 Aug 2006 15:11:47 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24866>

Luben Tuikov <ltuikov@yahoo.com> writes:

> In git_commit() the hash base of $from_id is $parent, not
> $hash:
>  - If status is "D", then action blob for $from_id wants
>    $parent, not $hash.  History needs $parent too.
>  - If status is "R", then action blob for $from_id wants
>    $parent, not $hash.
>
> In git_commitdiff() the hash base of $from_id is
> $hash_parent, not $hash:
>  - If status is "D".
>  - If status is "M".

... stopped in mid sentence???
