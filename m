X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Wed, 06 Dec 2006 01:48:45 -0800
Message-ID: <7vwt5573sy.fsf@assigned-by-dhcp.cox.net>
References: <456FD461.4080002@saville.com>
	<Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
	<456FDF24.1070001@saville.com>
	<Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
	<7vejri20mf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4575B32F.5060108@ramsay1.demon.co.uk>
	<Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
	<Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vac22glzz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 09:48:57 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vac22glzz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 05 Dec 2006 11:50:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33411>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtOX-0006P2-Dk for gcvg-git@gmane.org; Wed, 06 Dec
 2006 10:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760393AbWLFJss (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 04:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760399AbWLFJss
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 04:48:48 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56081 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760393AbWLFJsr (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 04:48:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206094846.ZIA22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Wed, 6
 Dec 2006 04:48:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vMoA1V00H1kojtg0000000; Wed, 06 Dec 2006
 04:48:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Tue, 5 Dec 2006, Linus Torvalds wrote:
>>
>>>  - take every single merge in git (or the kernel, if you want even more)
>
> The attached is the script I am using.  The test checks the
> output from 'master' (merge from RCS) and 'next' (with xdl-merge)
> and also tries to see how different the conflicts look like.
>
> In the git.git archive, there is no "clean" merge on which
> 'master' and 'next' did not agree.  It is not a proof of
> correctness at all but it gives a sense of assurance.

And all merges in linux-2.6.git archive either result in
conflict with both 'merge' implementations, or cleanly resolves
the same way with both 'merge' implementations.  I have not
compared the conflicted cases yet, but at least it gives me a
warm fuzzy feeling to see that autocommitted stuff are sensible.
