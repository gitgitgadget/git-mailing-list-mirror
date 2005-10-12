From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Wed, 12 Oct 2005 10:26:32 +0200
Message-ID: <20051012082632.GL30889@pasky.or.cz>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com> <46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com> <4349ED5D.6020703@catalyst.net.nz> <7v4q7p927d.fsf@assigned-by-dhcp.cox.net> <7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net> <7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net> <7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net> <7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 12 10:27:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPbwr-0000wL-Bp
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 10:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVJLI0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 04:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVJLI0f
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 04:26:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18907 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751358AbVJLI0f (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 04:26:35 -0400
Received: (qmail 15447 invoked by uid 2001); 12 Oct 2005 10:26:32 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10015>

Dear diary, on Wed, Oct 12, 2005 at 07:29:45AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I do not personally think it is too much of a restriction if we
> said we only allow tags using letters from [-a-zA-Z0-9.] (yes I
> am trying to be controversial by not allowing even latin-1
> names).

I think this is perfectly reasonable, as long as you also throw _ to the
set. ;-) Actually, cg-tag now already does at least

(echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
        die "name contains invalid characters"

but I'm in no way emotionally attached to the @!: characters.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
