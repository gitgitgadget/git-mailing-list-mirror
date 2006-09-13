From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 14:43:04 -0700
Message-ID: <7v1wqf789j.fsf@assigned-by-dhcp.cox.net>
References: <20060913210817.GA30782@spearce.org>
	<20060913211617.GJ23891@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 23:43:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNcVj-0006e8-3I
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWIMVnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWIMVnH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:43:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:14309 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751212AbWIMVnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 17:43:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913214304.OGKC21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 17:43:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mxit1V00a1kojtg0000000
	Wed, 13 Sep 2006 17:42:54 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060913211617.GJ23891@pasky.or.cz> (Petr Baudis's message of
	"Wed, 13 Sep 2006 23:16:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26955>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Wed, Sep 13, 2006 at 11:08:17PM CEST, I got a letter
> where Shawn Pearce <spearce@spearce.org> said that...
>> Create merge strategy 'applyreject'.
>> 
>> The applyreject merge strategy is a two head merge strategy which performs
>> the merge by obtaining the diff between the common base and the branch
>> being merged and applies it to the current branch using git-apply --reject.
>> Consequently any failures are written to .rej files, rather than using
>> the RCS <<<<<<< ======= >>>>>>> format.
>
> So, it's essentially the same as the classic resolve strategy, just
> handling rejects differently? I think that should be more obvious from
> its name, perhaps resolve-rej?
>
> .rej files, what a nuisance to handle those... :)

You were who asked for "apply --reject", weren't you?

I am not interested in this merge strategy myself.  Having said
that, if it is cleanly done, I do not have much objection adding
it for other people's use, at least in principle.
