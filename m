From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git /objects directory created 755 by default?
Date: Wed, 21 Dec 2005 18:15:43 +1300
Message-ID: <46a038f90512202115o652d8e00v86182302513d1319@mail.gmail.com>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	 <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
	 <7vacevdoti.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 06:15:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EowKJ-0002o4-HM
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 06:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVLUFPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 00:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVLUFPp
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 00:15:45 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:20114 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750762AbVLUFPo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 00:15:44 -0500
Received: by wproxy.gmail.com with SMTP id 57so59458wri
        for <git@vger.kernel.org>; Tue, 20 Dec 2005 21:15:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EKk9Sll+vgBboEv1BCKp9h1JkfK/IGjjNBDvvalfkpqsQ7awfpBQVdPkybjMDO+pzKiaLfWcIXaQM1w2L5gKldIkVyT6MI0Y9aeAbaocs1C7NefZiH68QQ/dJGy8bbo6KwavrYTq/uDGNsZgiKB4X3BdwjE/6bib2NCTAystRxQ=
Received: by 10.54.115.7 with SMTP id n7mr268924wrc;
        Tue, 20 Dec 2005 21:15:43 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Tue, 20 Dec 2005 21:15:43 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacevdoti.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13866>

On 12/21/05, Junio C Hamano <junkio@cox.net> wrote:
> [PATCH] Force group writable umask in git-shell
>
> Usually I do not like hardcoded policy in programs, but use of
> git-shell is already a policy decision by the repository
> administrator to use the shared repository style of development,
> and I cannot think of a reason to forbid group (and self, but
> that is obvious) writability in such use scenario.

Could git-shell also be used by a SourceForge-like project, offering
per-developer git repositories? If they are using the (BSDish?)
convention of not having a group per user this could backfire.

Does any unix these days _not_ use a group per user?

cheers,


martin
