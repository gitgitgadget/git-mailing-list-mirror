From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Wed, 26 Apr 2006 02:21:00 -0700
Message-ID: <7v7j5cr8ub.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<7vwtde2q1z.fsf@assigned-by-dhcp.cox.net>
	<444EAE7C.5010402@vilain.net> <e2mv30$k08$1@sea.gmane.org>
	<e2n01t$m8j$1@sea.gmane.org>
	<7vzmi8sxt1.fsf_-_@assigned-by-dhcp.cox.net>
	<e2n4am$1vn$1@sea.gmane.org>
	<7vlktssudl.fsf_-_@assigned-by-dhcp.cox.net>
	<e2n72h$aqe$1@sea.gmane.org> <7virowrd1y.fsf@assigned-by-dhcp.cox.net>
	<e2nbrl$p6l$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 11:21:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYgCo-0001OR-Ei
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 11:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWDZJVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 05:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWDZJVD
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 05:21:03 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:63679 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751220AbWDZJVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 05:21:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426092101.CRYD27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 05:21:01 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e2nbrl$p6l$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	26 Apr 2006 10:44:03 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19194>

Jakub Narebski <jnareb@gmail.com> writes:

>> Notice two .git directories?  That's right.
> [...] 
>> Meta/.git is a separate repository that is a clone of "todo"
>> branch of git.git repository.  The top-level .git repository
>> does not even have "todo" branch.  I just happen to push into
>> the same public repository git.git at kernel.org from these two
>> separate repositories.
>
> And top-level .git repository is told to ignore Meta directory?

Yes, I have .git/info/exclude that says something like this:

/.mailmap
*~
/Meta
+*
