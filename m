From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and file name case on cygwin
Date: Sat, 03 Feb 2007 17:25:17 -0800
Message-ID: <7vmz3uzpc2.fsf@assigned-by-dhcp.cox.net>
References: <ad8ce5c20702031400h78ddc11o34f98a461339bb55@mail.gmail.com>
	<Pine.LNX.4.64.0702031716130.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Niklas =?iso-8859-1?Q?H=F6glund?= <nhoglund@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 02:25:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDW8G-0004dB-6F
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbXBDBZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 20:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbXBDBZV
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:25:21 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:58719 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751846AbXBDBZT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Feb 2007 20:25:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204012519.PHTH1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 20:25:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KDRJ1W00l1kojtg0000000; Sat, 03 Feb 2007 20:25:19 -0500
In-Reply-To: <Pine.LNX.4.64.0702031716130.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 3 Feb 2007 17:17:36 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38630>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 3 Feb 2007, Niklas H=F6glund wrote:
>>
>> There's something funny going on with git in cygwin. The following i=
s
>> in a clone of linux 2.6, with no local modifications (only the
>> occasional pull from upstream).
>
> You are using a filesystem that isn't able to handle the Linux kernel=
=2E
>
> Make sure you don't try to maintain kernel source trees on a filesyst=
em=20
> that isn't case-sensitive. Here's a clue:
>
> 	include/linux/netfilter/xt_dscp.h
> 	include/linux/netfilter/xt_DSCP.h
>
> are both tracked files..

Are there plans to "fix" the confusion by renaming them to
reduce chances of name clashes on such suboptimal filesystems?
