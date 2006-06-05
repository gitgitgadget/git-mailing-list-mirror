From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 04 Jun 2006 18:37:10 -0700
Message-ID: <7v3bek7589.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<20060603151240.GA4024@diku.dk>
	<7vejy48wp5.fsf@assigned-by-dhcp.cox.net>
	<20060605000423.GA29521@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 03:37:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn41t-00030F-HL
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 03:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWFEBhO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Jun 2006 21:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWFEBhN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 21:37:13 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:15592 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932375AbWFEBhM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 21:37:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605013711.PVSD5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 21:37:11 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060605000423.GA29521@diku.dk> (Jonas Fonseca's message of
	"Mon, 5 Jun 2006 02:04:23 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21303>

Jonas Fonseca <fonseca@diku.dk> writes:

>>     - I want to see the neighbouring commits, but UP or DOWN
>>       does not do what I na=EFvely expect.  It scrolls the lower
>>       pane.  I say TAB to go up.
>
> I wonder what tig version you are using. If you are using the tig
> version from my git repo this should also be working to your
> expectation, making ...

Whichever was the latest when I wrote the message.  I see you
have added a handful commits on it since then.

>>     - Press UP or DOWN and I can move the highlight to
>>       neighbouring commits.  This is wonderful, but the lower
>>       pane does not follow this -- it keeps showing the original
>>       commit, and I have to say ENTER again.
>
> .. this unnecessary.

Maybe I am misusing it then.

"full-screen" diff view and being able to do [UP] and [DOWN] to
move around there do not feel useful to me that much.  It is
something "git log -p" does already, thanks to its output paged
via "less" by default.

I like viewing the list in the upper and diff/log in the lower
at the same time, and that is the primary reason I liked tig, so
moving around in the commit list view and not seeing the
diff/log updated in sync was major dissapointment at least for
me.
