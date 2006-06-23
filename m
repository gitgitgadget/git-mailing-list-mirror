From: Petr Baudis <pasky@suse.cz>
Subject: Re: Tracking CVS
Date: Fri, 23 Jun 2006 04:31:31 +0200
Message-ID: <20060623023131.GK21864@pasky.or.cz>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com> <20060622135831.GB21864@pasky.or.cz> <9e4733910606221918r775f49f0l4929f4703281115f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 04:31:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtbSO-0001i5-8G
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 04:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWFWCbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 22:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWFWCbd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 22:31:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60646 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750850AbWFWCbc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 22:31:32 -0400
Received: (qmail 20043 invoked by uid 2001); 23 Jun 2006 04:31:31 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606221918r775f49f0l4929f4703281115f@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22394>

Dear diary, on Fri, Jun 23, 2006 at 04:18:32AM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> On 6/22/06, Petr Baudis <pasky@suse.cz> wrote:
> >        cvs update
> >        cg-rm -a
> >        cg-status -wns \? | xargs cg-add
> >        cg-commit
> 
> This doesn't pick up new directories with recursion.

Ah. Either pass -S to cg-status or -r to cg-add.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
