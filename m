From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 26 Nov 2005 19:57:48 -0800
Message-ID: <7vfypioi83.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
	<20051118205513.GA3168@vrfy.org>
	<Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
	<Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
	<437E51EB.7050100@zytor.com>
	<Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
	<7vek5deam6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
	<7v7jb57wud.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>
	<20051127025249.GA12286@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 04:58:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgDfr-0004aH-U5
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 04:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVK0D5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 22:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVK0D5w
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 22:57:52 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:53732 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750834AbVK0D5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 22:57:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051127035713.HCHY20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 22:57:13 -0500
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20051127025249.GA12286@vrfy.org> (Kay Sievers's message of "Sun,
	27 Nov 2005 03:52:49 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12794>

Kay Sievers <kay.sievers@vrfy.org> writes:

> On Sat, Nov 19, 2005 at 09:52:34AM -0800, Linus Torvalds wrote:
>> 
>> On Sat, 19 Nov 2005, Junio C Hamano wrote:
>> > 
>> > Well, some people on the list seem to think UTF-8 is the one and
>> > only right encoding, so for them if the message does not
>> > identify what it is in, assuming UTF-8 and not doing any
>> > conversion is probably the right thing ;-).
>> 
>> If you replace "assume" with "verify", then I agree.

One problem I have that approach is what to do if it does not
verify.  Reject and ask them to re-run the program with another
option --binary-log-message?

> I found some test code I did a while ago for validation of
> filesystem labels, cause D-BUS diconnects your session, if you
> send an invalid utf-8 string to the bus. :)
>
> Kay

Thanks.  I take it that you are licensing this code to use in
git when we doing what Linus suggests?
