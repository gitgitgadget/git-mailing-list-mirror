From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Unresolved issues
Date: Wed, 21 Feb 2007 11:57:06 -0500
Message-ID: <09D527A1-43E2-41A1-AC46-71F64BC409C2@silverinsanity.com>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org> <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org> <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070221104209.GM21842@admingilde.org> <Pine.LNX.4.63.0702211348060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 21 17:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJumM-0002lc-B3
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 17:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbXBUQ5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 11:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbXBUQ5N
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 11:57:13 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:54325 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422684AbXBUQ5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 11:57:12 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 86F601FFC132;
	Wed, 21 Feb 2007 16:57:09 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.63.0702211348060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40304>


On Feb 21, 2007, at 7:55 AM, Johannes Schindelin wrote:

> What you conveniently "forgot" to quote was the case: if we want  
> this to
> decide on when to use crlf<->lf transformation, we should decide that
> locally.

It seems to me that a tracked .gitattributes file should have things  
like

*.txt: text
*.gif: binary
*.[ch]: text

And the .git/config should have

[attribute "text"]
    mangle = crlf

[attribute "binary"]
    merge = none

The type of each file should be tracked, but what to do with each  
type is a local issue.  Trying to merge the two is madness.

~~ Brian
