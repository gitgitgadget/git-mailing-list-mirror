From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 03 Aug 2006 02:16:31 -0700
Message-ID: <7vmzamqivk.fsf@assigned-by-dhcp.cox.net>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0608020702q2fd4ec83ga43714c15538f7ad@mail.gmail.com>
	<7vd5bis9ha.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0608030109g6f49113ep5cf577475117469b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 11:16:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8ZJk-00007x-9K
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 11:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWHCJQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 05:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWHCJQd
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 05:16:33 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6055 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932410AbWHCJQc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 05:16:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803091632.RSTU27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 05:16:32 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0608030109g6f49113ep5cf577475117469b@mail.gmail.com>
	(Alex Riesen's message of "Thu, 3 Aug 2006 10:09:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24716>

"Alex Riesen" <raa.lkml@gmail.com> writes:

>> What's the standard workflow/procedure ActiveState users would
>> use to build and install .xs extensions?  Maybe they have their
>> own $(MAKE) equivalent that groks such a Makefile with
>> backslashed pathnames and CRLF endings?
>
> I don't know. It's a bit more than backslashes and CRLF. The pathnames
> must be _completely_ converted from windows to cygwin. Cygwin even
> provides an utility for that (cygpath). Besides, there still is that stupid
> case-sensitivity problem.

What I meant to say was that the real mistake might be for us to
try using the Cygwin toolchain (GNU make, gcc and GNU C library)
while working with ActiveState.

Now, I admit I know very little about ActiveState and know
nothing about Windows build environment, but I would not be
surprised if in ActiveState land there were a MakeMaker
equivalent that spits out Makefile equivalent that is suitable
for MS development environment, and the users are expected to
work in that environment, perhaps using MS C compiler toolchain,
to produce object files if they want to link with ActiveState
stuff.  If that were the case, maybe what is needed is to port
the build infrastructure to MS development environment, and
making Makefile generated from perl/Makefile.PL usable might not
be of much use.
