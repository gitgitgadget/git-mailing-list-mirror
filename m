From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/7] Git.pm: Introduce ident() and ident_person() methods
Date: Sat, 24 Jun 2006 22:25:32 -0700
Message-ID: <7vhd29zu0j.fsf@assigned-by-dhcp.cox.net>
References: <20060625015421.29906.50002.stgit@machine.or.cz>
	<20060625015751.GB21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 07:25:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuN82-000395-MB
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 07:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWFYFZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 01:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWFYFZe
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 01:25:34 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2995 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751389AbWFYFZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 01:25:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625052533.EAKL18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 01:25:33 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060625015751.GB21864@pasky.or.cz> (Petr Baudis's message of
	"Sun, 25 Jun 2006 03:57:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22589>

Petr Baudis <pasky@suse.cz> writes:

>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index e794e44..79e82f5 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>
> BTW, please tell me if you want to redo the patches without any script
> updates (and how large portion of the patches to resend; my stg stack
> now has 28 patches and I'm finally using it for some real workload!)
> - given that the plan is to have the converted scripts only in pu
> (or entirely outside your tree) but full-fledged Git.pm in tree.

I'd avoid asking you to resend, but give me some time to see how
the series looks like first.
