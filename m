From: Junio C Hamano <junkio@cox.net>
Subject: Re: Setting up Password protected repositories?
Date: Sat, 16 Sep 2006 19:18:21 -0700
Message-ID: <7v8xkj8ccy.fsf@assigned-by-dhcp.cox.net>
References: <E1GOktx-0005JY-ER@jdl.com>
	<7virjn8eua.fsf@assigned-by-dhcp.cox.net> <E1GOm3h-0005jq-5u@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 04:18:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOmEn-0006bU-R2
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 04:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWIQCSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 22:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWIQCSW
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 22:18:22 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:16019 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964912AbWIQCSW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 22:18:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917021821.WBCC3535.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 Sep 2006 22:18:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PEJ91V00G1kojtg0000000
	Sat, 16 Sep 2006 22:18:09 -0400
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1GOm3h-0005jq-5u@jdl.com> (Jon Loeliger's message of "Sat, 16
	Sep 2006 21:07:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27153>

Jon Loeliger <jdl@jdl.com> writes:

> So, like, the other day Junio C Hamano mumbled:
>> 
>> It all depends on how you start git-daemon, but the last
>> parameters to git-daemon are path whitelist so presumably
>> placing the private repository outside of it should be enough.
>> 
>> Or am I missing something deeper?
>
> I want git-daemon to serve up the repository.
> I just want to have it served to people who can
> supply a password or have an ssh key in place.

Sorry, git-daemon was written as anonymous download service from
the beginning and there is no provision for something like that
in place (as you probably have noticed when you hacked on it
recently ;-)).

Letting them ssh-in, and if you do not trust them giving them
git-shell as their login shell, might be an option.  I do not
think of anything else offhand that is already available.
