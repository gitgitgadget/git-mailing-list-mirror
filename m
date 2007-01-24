From: Junio C Hamano <junkio@cox.net>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 17:44:05 -0800
Message-ID: <7vlkjtkxlm.fsf@assigned-by-dhcp.cox.net>
References: <200701192148.20206.johannes.sixt@telecom.at>
	<200701231506.32396.andyparkins@gmail.com>
	<Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701231624.41716.andyparkins@gmail.com>
	<Pine.LNX.4.63.0701231732120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0701230852270.32200@woody.linux-foundation.org>
	<Pine.LNX.4.63.0701231805100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 02:44:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9XBM-0001Dn-O3
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132AbXAXBoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933158AbXAXBoJ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:44:09 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55053 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132AbXAXBoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:44:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124014406.LHMF29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Tue, 23 Jan 2007 20:44:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EpkQ1W00Q1kojtg0000000; Tue, 23 Jan 2007 20:44:24 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37590>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> All the other uses seem to be just a case of
>> 
>> 	git-merge-index -o git-merge-one-file -a
>> 
>> and wouldn't it be beautiful if the default action for git-merge-index (if 
>> you do _not_ specify a merger program) was to do the simple one-file 
>> three-way merge that we can already do for real merges?
>
> If you think that's a new dream:
>
> http://article.gmane.org/gmane.comp.version-control.git/32046/match=git-merge-one-file

(OT: heh, I did not notice Linus's mailing address when I saw
his message for the first time).

I've thought about it when I was really bored, but noticed that
we have no serious users of git-merge-index/git-merge-one-file
combinations anymore in-tree (octopus does not count, and it is
trivial to make it use merge-recursive if somebody is twisted
enough).
