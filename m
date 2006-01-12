From: Junio C Hamano <junkio@cox.net>
Subject: Re: git in HP-UX PA-RISC
Date: Thu, 12 Jan 2006 12:28:38 -0800
Message-ID: <7v1wzdmbrd.fsf@assigned-by-dhcp.cox.net>
References: <5c08a49c0601121105u519fe02fq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 21:29:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex93t-00054L-72
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 21:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWALU2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 15:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWALU2l
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 15:28:41 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:34991 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1161168AbWALU2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 15:28:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112202649.FQEH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 15:26:49 -0500
To: Joan Ripoll Balaguer <joan.ripsa@gmail.com>
In-Reply-To: <5c08a49c0601121105u519fe02fq@mail.gmail.com> (Joan Ripoll
	Balaguer's message of "Thu, 12 Jan 2006 20:05:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14586>

Joan Ripoll Balaguer <joan.ripsa@gmail.com> writes:

> How I can build git on HP-UX 11.11 (PA-RISC)?
>
> I have build openSSL and zlib libraries, plus GNU make utility, but I
> haven't gcc compiler. I have native ANSI C compiler.
>
> I search in the archives of that mail list, but I find nothing.

I do not think we had a thread on bootstrapping GCC on HP-UX on
this list ;-).

Your build log that shows compilation error messages, or if you
can identify what GCC extension we use that HP-UX C compiler
does not like then a short summary of the problem, would be
helpful (of course the latter is preferred).

One thing I know we deliberately use GCC extension is flex
array.  "make CFLAGS=-DFLEX_ARRAY=1" might help.  Maybe not.
