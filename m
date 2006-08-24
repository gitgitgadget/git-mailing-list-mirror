From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] adding support for md5
Date: Thu, 24 Aug 2006 00:36:52 -0700
Message-ID: <7vac5ubn57.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
	<Pine.LNX.4.64.0608191339010.11811@g5.osdl.org>
	<20060821204430.GA2700@tuatara.stupidest.org>
	<7vr6z9s376.fsf@assigned-by-dhcp.cox.net>
	<20060823041453.GA25796@spearce.org>
	<7v3bbojbzj.fsf@assigned-by-dhcp.cox.net>
	<20060823064900.GA26340@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 09:37:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG9mP-0000KZ-UZ
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 09:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWHXHgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 03:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWHXHgy
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 03:36:54 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43425 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750756AbWHXHgx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 03:36:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824073653.KTEM12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 Aug 2006 03:36:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Djcs1V0064Noztg0000000
	Thu, 24 Aug 2006 03:36:52 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25944>

Shawn Pearce <spearce@spearce.org> writes:

>> > What about all of those memcpy(a, b, 20)'s?  :-)
>> 
>> Surely.  If you are inclined to, go wild.
>
> Like this?  :-)

Except some minor nits, yes.

 * I would have preferred two patches, one for "master" and one
   for the C merge-recursive topic (or at least "next").

 * You missed a few in "master".

 * The cast in the second hunk in combine-diff.c was wrong;
   breakage was caught by our testsuite.

I've pushed out a fixed up result in "master" and "next".
