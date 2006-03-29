From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull fails
Date: Tue, 28 Mar 2006 16:22:28 -0800
Message-ID: <7vzmjagkvv.fsf@assigned-by-dhcp.cox.net>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com>
	<20060328141140.GC3113@linux-mips.org>
	<20060328173827.3d64d91e.tihirvon@gmail.com>
	<200603281700.17233.astralstorm@o2.pl>
	<20060328224807.GC27689@pasky.or.cz>
	<20060329031136.e0389c00.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 02:22:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOOSS-0004TS-JA
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWC2AWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWC2AWb
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:22:31 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40640 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964877AbWC2AWa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 19:22:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329002229.FAXJ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 19:22:29 -0500
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060329031136.e0389c00.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Wed, 29 Mar 2006 03:11:36 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18148>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Petr Baudis <pasky@suse.cz> wrote:
>
>> If I understand it right, Timo complains that git-fetch got
>> non-fastforward commits for "pu" and "next" and a good fastforward
>> commit for "master", but it didn't update the ref for ANY head, not even
>> the "master".
>
> Exactly.  Maybe git-fetch should abort only if it could not update the
> currently checked out branch?

The erroring-out is there so that the user can take notice.
