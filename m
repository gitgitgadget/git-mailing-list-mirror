From: Junio C Hamano <junkio@cox.net>
Subject: Re: dangling commits
Date: Sun, 15 Jan 2006 13:15:59 -0800
Message-ID: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net>
References: <dqebk9$75f$1@sea.gmane.org> <43CAB6ED.3010703@op5.se>
	<dqedel$d0q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 15 22:16:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyFEP-0005Fw-Ss
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 22:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWAOVQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 16:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWAOVQE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 16:16:04 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:48002 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750887AbWAOVQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 16:16:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115211405.YHEP17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 16:14:05 -0500
To: git@vger.kernel.org
In-Reply-To: <dqedel$d0q$1@sea.gmane.org> (Nick Williams's message of "Sun, 15
	Jan 2006 21:37:00 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14712>

Nick Williams <njw@jarb.freeserve.co.uk> writes:

> Andreas Ericsson wrote:
>..
>> Nopes. One clones over http, so you'll get all objects in the object
>> database. The other clones over the far more clever git protocol
>> which calculates which objects you need. Obviously you don't need
>> dangling commits (and their related blobs), so there will be no such
>> items.

Note that only because that is these dangling objects are packed
in the past, and when fetching over http, packs are fetched as a
whole.

> So, is there any advantage of using http? Seems like git:// makes more
> sense.

As long as you can go native git:// protocol, I do not see much
reason to use http:// commit walkers.  OTOH, if you are
firewalled and your sysadmins do not let you pass 9418/tcp
outgoing, HTTP might be your only choice.
