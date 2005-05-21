From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Fri, 20 May 2005 22:59:15 -0700
Message-ID: <7vekc1nmq4.fsf@assigned-by-dhcp.cox.net>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
	<7voeb5np30.fsf@assigned-by-dhcp.cox.net>
	<20050521051536.GA9387@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat May 21 07:58:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZN0N-0004dA-27
	for gcvg-git@gmane.org; Sat, 21 May 2005 07:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVEUF72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 01:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEUF72
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 01:59:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14792 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261669AbVEUF7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 01:59:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521055917.EPAG7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 01:59:17 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050521051536.GA9387@havoc.gtf.org> (Jeff Garzik's message of
 "Sat, 21 May 2005 01:15:36 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> On Fri, May 20, 2005 at 10:08:19PM -0700, Junio C Hamano wrote:

>> The patch looks good.  Before you proceed to convert the rest,
>> could I ask you to first let us see the list of new set of
>> options and semantics changes, if any ("checkout-cache -f -a" vs
>> "checkout-cache -a -f" immediately comes to mind)?

JG> FWIW most users (including me!) would expect that order of
JG> options is -not- significant.

That set of users includes me.  I was hoping that this round
would not just change things to use argp, but at the same time
attempt to "fix" the problems around argument parsing.  

JG> Typical implementation is agnostic on the ordering of
JG> options, but with a few lines of code in parse_opt() that
JG> need not always be the case.

I think you are responding to my "semantic changes" question,
but I did not mean to say that exactly emulating the current
behaviour is the requirement, nor I meant to ask if doing so is
impossible using argp().  I just wanted to see "the set of
planned fixes" while we are at it.

