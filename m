From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sun, 17 Sep 2006 22:50:26 -0700
Message-ID: <7vlkohu3j1.fsf@assigned-by-dhcp.cox.net>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net>
	<7vu035u4c3.fsf@assigned-by-dhcp.cox.net> <eelbd2$56s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 07:50:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPC1X-00079s-0A
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 07:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965422AbWIRFu2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 18 Sep 2006 01:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965423AbWIRFu2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 01:50:28 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62444 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965422AbWIRFu1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 01:50:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918055027.JKLH6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 01:50:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PhqE1V0091kojtg0000000
	Mon, 18 Sep 2006 01:50:14 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eelbd2$56s$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	18 Sep 2006 07:39:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27228>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> =A0 - An experimental git-for-each-ref command to help language
>> =A0 =A0 bindings to get information on many refs at once. =A0Hopeful=
ly
>> =A0 =A0 Jakub can teach gitweb to use it to speed things up.
>
> I use 'origin' (or 'next') version of gitweb, while using _released_
> version of git (git-core-1.4.2.1-1.i386.rpm). So at least for now=20
> I wouldn't be able to _test_ the git-for-each-ref.

That's not a good excuse, though.  It means you cannot propose
new core-side support that only gitweb would benefit from
initially, since we will not add new stuff to the core that does
not have real users, and new stuff in the core must be cooked in
"next" before it is proven to be useful and correct.
