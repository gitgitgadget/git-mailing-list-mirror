From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some index-base bug in "next" branch ("git-applymbox"-related?)..
Date: Thu, 12 Apr 2007 21:19:11 -0700
Message-ID: <7vfy74hpog.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
	<7vbqhti0nr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704121812440.4061@woody.linux-foundation.org>
	<7vlkgxgc9d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704122115240.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 06:19:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcDFl-0002SZ-0T
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 06:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbXDMETN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 00:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbXDMETN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 00:19:13 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50922 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbXDMETM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 00:19:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413041912.RLMB1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Apr 2007 00:19:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mUKA1W00y1kojtg0000000; Fri, 13 Apr 2007 00:19:11 -0400
In-Reply-To: <Pine.LNX.4.64.0704122115240.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 12 Apr 2007 21:16:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44384>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 12 Apr 2007, Junio C Hamano wrote:
>> 
>> The whole reason I did not _enhance_ git-applymbox but wrote a
>> separate git-am was because I found git-applymbox's command line
>> parameter quite insane and felt that supporting it at the same
>> time doing a saner command line parameter was too much kludge.
>
> Heh. I'll try to make my alias be
>
> 	alias dotest='git-am --utf8'
>
> and see what happens ;)
>
> 		Linus

You should not need -u; it's default these days.
