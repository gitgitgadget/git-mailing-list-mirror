From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Fri, 19 Nov 2010 22:29:22 +0100
Message-ID: <m24obd0zpp.fsf@igel.home>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
	<20101118175007.GA26505@sigill.intra.peff.net>
	<20101118184241.GN3693@efreet.light.src>
	<20101118190414.GA30438@sigill.intra.peff.net>
	<m2ipzt14rh.fsf@igel.home>
	<20101119194628.GA15466@sigill.intra.peff.net>
	<m28w0p1071.fsf@igel.home>
	<20101119212118.GA19425@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 22:29:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJYWU-0007C5-7F
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 22:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886Ab0KSV3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 16:29:24 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:59227 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab0KSV3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 16:29:24 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 1A021188B5BF;
	Fri, 19 Nov 2010 22:29:23 +0100 (CET)
Received: from igel.home (ppp-88-217-122-42.dynamic.mnet-online.de [88.217.122.42])
	by mail.mnet-online.de (Postfix) with ESMTP id 0DD571C02325;
	Fri, 19 Nov 2010 22:29:23 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id D174DCA2A0; Fri, 19 Nov 2010 22:29:22 +0100 (CET)
X-Yow: C'MON, everybody!!  I've flown in LESLIE GORE and two dozen KOSHER
 BUTCHERS!  They'll be doing intricate MILITARY MANEUVERS to the
 soundtrack from "OKLAHOMA"!!
In-Reply-To: <20101119212118.GA19425@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 19 Nov 2010 16:21:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161790>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 19, 2010 at 10:18:58PM +0100, Andreas Schwab wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Fri, Nov 19, 2010 at 08:40:18PM +0100, Andreas Schwab wrote:
>> >
>> >> Jeff King <peff@peff.net> writes:
>> >> 
>> >> > it really only makes sense to push from a non-bare repo,
>> >> 
>> >> Why?  The repo could itself be a mirror.
>> >
>> > Why do you have a working directory if you are going to have a refspec
>> > that overwrites HEAD behind your back (which, IIRC, git will simply barf
>> > on, so all of your fetches will fail)?
>> 
>> I don't understand that question.  There is no working directory in a
>> bare repo.
>
> Now I'm confused. I thought we were talking about non-bare repos. Can
> you clarify your question?

You claim that pushing from a bare repo does not make sense, and I
question that (I do that all the time).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
