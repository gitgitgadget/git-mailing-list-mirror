From: Junio C Hamano <junkio@cox.net>
Subject: Re: Where/how to create tracking branches?
Date: Mon, 19 Feb 2007 13:09:12 -0800
Message-ID: <7v1wkl7t3b.fsf@assigned-by-dhcp.cox.net>
References: <17881.54325.475907.468492@lisa.zopyra.com>
	<7vy7mu6ihj.fsf@assigned-by-dhcp.cox.net>
	<17882.1230.704770.12880@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 22:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJFl8-0000Vk-6E
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 22:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbXBSVJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 16:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbXBSVJO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 16:09:14 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34452 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbXBSVJN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 16:09:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219210912.RXTC1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 16:09:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RZ9C1W00B1kojtg0000000; Mon, 19 Feb 2007 16:09:12 -0500
In-Reply-To: <17882.1230.704770.12880@lisa.zopyra.com> (Bill Lear's message of
	"Mon, 19 Feb 2007 14:13:02 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40153>

Bill Lear <rael@zopyra.com> writes:

> On Monday, February 19, 2007 at 11:43:36 (-0800) Junio C Hamano writes:
>>...
>>Assuming your clone was initially made from /public/repo/project,
>>doesn't "git fetch" without _any_ parameter work?
>>
>>	$ git fetch
>
> Short answer: yes, it does.  I had assumed I needed to create the
> tracking branch somehow since I created the topic branch in the first
> place in my private repo.  More detailed confirmation follows, but
> thank you for pointing out that git is in fact smarter than I gave
> it credit.

Tracking new branches on the remote side after you create a
clone is one of the few things 1.5.0 does much better than 1.4.4
series, and it was done in response to comments from real world
users like yourself, so rather than giving git too much credit,
I think you should take it yourself ;-).
