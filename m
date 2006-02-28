From: Junio C Hamano <junkio@cox.net>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 16:10:52 -0800
Message-ID: <7vbqwswdf7.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
	<44038B73.4030004@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 01:11:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDsSM-0007lF-12
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 01:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWB1AK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 19:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWB1AK5
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 19:10:57 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52197 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751789AbWB1AK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 19:10:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228000811.ITCT17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 19:08:11 -0500
To: Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <44038B73.4030004@bigpond.net.au> (Peter Williams's message of
	"Tue, 28 Feb 2006 10:29:55 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16896>

Peter Williams <pwil3058@bigpond.net.au> writes:

>> This whitespace policy should be at least per-project (people
>> working on both kernel and other things may have legitimate
>> reason to want trailing whitespace in the other project),
>
> I'd be interested to hear these reasons.  My experience is that people
> don't put trailing white space in deliberately (or even tolerate it if
> they notice it) and it's usually there as a side effect of the way
> their text editor works (and that's also the reason that they don't
> usually notice it).  But if my experience is misleading me and there
> are valid reasons for having trailing white space I'm genuinely
> interested in knowing what they are.

For example:

	http://compsoc.dur.ac.uk/whitespace/

Jokes aside, I can imagine people want to keep format=flowed
text messages (i.e. not programming language source code) under
git control.  Maybe pulling and pushing would be the default
mode of operation for those people, so what git-apply does would
not be in the picture for those people, but who knows.

One way to find it out is to push out a strict one and see who
screams ;-), but the point is I am reluctant to make a stricter
policy the default, thinking, but not knowing as a fact, that it
is good enough for everybody.
