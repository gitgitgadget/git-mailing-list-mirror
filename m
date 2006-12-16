X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Changes between main releases of git
Date: Sat, 16 Dec 2006 13:20:05 -0800
Message-ID: <7v1wmzedx6.fsf@assigned-by-dhcp.cox.net>
References: <em1n78$iud$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 21:20:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <em1n78$iud$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	16 Dec 2006 22:07:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34642>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvgxD-0006XN-ST for gcvg-git@gmane.org; Sat, 16 Dec
 2006 22:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161509AbWLPVUM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 16:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161512AbWLPVUM
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 16:20:12 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:63780 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161509AbWLPVUK (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 16:20:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216212006.EOFA7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 16:20:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zZLH1V0181kojtg0000000; Sat, 16 Dec 2006
 16:20:18 -0500
To: jnareb@gmail.com
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> We are now close according to Junio to git 1.5.0.

We only just started talking about v1.5.0.  I would expect it to
be at least a month away, probably more.  Definitely not by
Christmas nor Linus's birthday.

> I'd like to ask by the occasion what were main changes
> between main versions (main releases) of git, say starting
> from v1.0.0?

I would agree we would LOVE to have that list by the time we do
a real v1.5.0, so that should be on the TO-DO list.  The
essential sources of information are:

 * Previous "What's in" summaries.

 * Previous "GIT v1.X.X" announcements.

 * Output from this (pick the ones that are not marked with ^)

	for txt in Documentation/*.txt
	do
        	git blame v1.0.0..next -- "$txt"
	done

 * Output from this

	git log v1.0.0..next

My time however is rather tight and I feel it is better spent on
the real development and release management.  People who has
been following the git list long enough should be able to come
up with a draft to help the process.

I happen to think you are among the more qualified people.


