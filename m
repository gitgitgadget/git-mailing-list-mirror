From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Remove obsolete commit-walkers
Date: Tue, 03 Jul 2007 22:10:36 -0700
Message-ID: <7vsl84lpo3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707030128110.14638@iabervon.org>
	<7vwsxiroqa.fsf@assigned-by-dhcp.cox.net>
	<18058.17778.692974.122271@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 07:11:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5x8z-0001Ir-Sf
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 07:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbXGDFKq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 01:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXGDFKq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 01:10:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52956 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbXGDFKi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 01:10:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704051038.SFHP1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 01:10:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KHAc1X00L1kojtg0000000; Wed, 04 Jul 2007 01:10:37 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51562>

Bill Lear <rael@zopyra.com> writes:

> On Monday, July 2, 2007 at 23:22:05 (-0700) Junio C Hamano writes:
>>I'll apply this after 1.5.3.  In the meantime, I'll do this for 1.5.3.
>>
>>diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
>>index 19b5f88..141b767 100644
>>--- a/Documentation/git-local-fetch.txt
>>+++ b/Documentation/git-local-fetch.txt
>>@@ -14,6 +14,8 @@ SYNOPSIS
>> 
>> DESCRIPTION
>> -----------
>>+THIS COMMAND IS DEPRECATED.
>>...
>
> If a deprecated command has a replacement, the deprecation notice
> should point the user to that.

Actually these fetch backend shouldn't even be needed by the end
users.  "git fetch" simply does not drive them these days.
