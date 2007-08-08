From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Wed, 08 Aug 2007 11:13:27 +0200
Message-ID: <86abt25qyw.fsf@lola.quinscape.zz>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
	<7v4pjc9czm.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708072004150.23971@woody.linux-foundation.org>
	<Pine.LNX.4.64.0708080923580.14781@racer.site>
	<7v3ayu5scj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 11:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIhc1-0003bG-PI
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 11:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbXHHJNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 05:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXHHJNq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 05:13:46 -0400
Received: from main.gmane.org ([80.91.229.2]:58067 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbXHHJNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 05:13:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIhbo-0005hO-1x
	for git@vger.kernel.org; Wed, 08 Aug 2007 11:13:40 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 11:13:40 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 11:13:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <7v3ayu5scj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 08 Aug 2007 01\:43\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:mZ1wh6qjOkjH4xMtoBZmtHsAifk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55310>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> So I have the slight suspicion that all this will accomplish is "shut the 
>> darn thing up", and old-timers will have a harder time, since they no 
>> longer spot easily when they did a Dumb Thing and left the index out of 
>> sync.
>
> The hardest hit would be old-timers who try to be friendly by
> trying to help new people, who has much less chance to notice
> and report these much less prominent warnings, over e-mail or
> irc.

"Dude, you got a stale index hanging out of your trousers."

I find it ridiculous to parade local problems in patches sent out to
the world rather than fixing them, so that old-timers have a chance to
get karma points.

Really: if stale indexes are considered a problem, git should silently
mark the staleness in the file, and the next time (or after three more
times or whatever) the index is used, it is silently regenerated.

Old-timers can get an option disabling this so that they can proud
themselves on cleaning up after themselves consciously, but for the
normal user, this is a bother he can do without.

-- 
David Kastrup
