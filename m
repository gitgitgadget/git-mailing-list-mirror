From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 15:12:47 -0700
Message-ID: <7vwtazobkw.fsf@assigned-by-dhcp.cox.net>
References: <20060628223744.GA24421@coredump.intra.peff.net>
	<7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
	<20060629180011.GA4392@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
	<20060629185335.GA6704@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
	<20060629195201.GA10786@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
	<Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
	<Pine.LNX.4.64.0606291723060.1213@localhost.localdomain>
	<Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
	<Pine.LNX.4.64.0606291743010.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 00:12:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4ko-0006iV-Mg
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 00:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbWF2WMv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 18:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933039AbWF2WMu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 18:12:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:59633 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S933040AbWF2WMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 18:12:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629221248.SJHC18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 18:12:48 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606291743010.1213@localhost.localdomain> (Nicolas
	Pitre's message of "Thu, 29 Jun 2006 17:47:09 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22918>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 29 Jun 2006, Linus Torvalds wrote:
>
>> 
>> 
>> On Thu, 29 Jun 2006, Nicolas Pitre wrote:
>> >
>> > On Thu, 29 Jun 2006, Linus Torvalds wrote:
>> > 
>> > > Instead of having a separate cache, wouldn't it be much better to just 
>> > > take the hint from the previous pack-file?
>> > 
>> > DOH!  ;-)
>> 
>> Btw, I think this could do with a flag to turn it on/off (but probably 
>> default to on).
>
> I think it should simply be coupled with the --no-reuse-delta flag.

I agree that makes sense.
