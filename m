From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Wed, 09 Jun 2010 18:29:49 +0900
Message-ID: <buo4ohcsgdu.fsf@dhlpc061.dev.necel.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
	<20100608053507.GB15156@coredump.intra.peff.net>
	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
	<4C0E5103.7030501@viscovery.net>
	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
	<4C0E6810.3070301@viscovery.net>
	<AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
	<4C0E932B.3010702@viscovery.net>
	<AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
	<4C0EB741.9020905@op5.se>
	<AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Jun 09 11:31:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMHcs-0003LI-Q7
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 11:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab0FIJbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 05:31:04 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:47340 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877Ab0FIJbD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 05:31:03 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o599Tp0S000997;
	Wed, 9 Jun 2010 18:29:51 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o599Tp122385; Wed, 9 Jun 2010 18:29:51 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.60]) by vgate01.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
	id o599To418803; Wed, 9 Jun 2010 18:29:50 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay51.aps.necel.com with ESMTP; Wed, 9 Jun 2010 18:29:50 +0900
Received: from dhlpc061 ([10.114.113.131] [10.114.113.131]) by relay51.aps.necel.com with ESMTP; Wed, 9 Jun 2010 18:29:50 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 6402652E1F3; Wed,  9 Jun 2010 18:29:50 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
	(Tor Arntsen's message of "Wed, 9 Jun 2010 11:08:49 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148757>

Tor Arntsen <tor@spacetec.no> writes:
> AIX doesn't come with 'less', because it doesn't really need one.
> 'more' on AIX can page backwards/forwards in piped data (unlike 'more'
> on Linux etc.), thus negating the most common need for installing
> 'less' elsewhere.

Less has about a zillion features that more [traditionally] doesn't
have, and even some of the more esoteric ones can be quite useful for
git.  For instance you can determine in a great deal of detail exactly
how/when/if it clears the screen/shows a prompt/waits for user input
before exiting, etc.

-Miles

-- 
(\(\
(^.^)
(")")
*This is the cute bunny virus, please copy this into your sig so it can spread.
