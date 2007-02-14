From: Junio C Hamano <junkio@cox.net>
Subject: Re: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 11:54:06 -0800
Message-ID: <7v7iuko6qp.fsf@assigned-by-dhcp.cox.net>
References: <17875.25882.784307.731860@lisa.zopyra.com>
	<20070214194919.GE28290@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:54:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQCi-0006F6-FC
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbXBNTyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbXBNTyI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:54:08 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48107 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbXBNTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:54:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214195407.JFEZ22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 14:54:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PXu61W00T1kojtg0000000; Wed, 14 Feb 2007 14:54:06 -0500
In-Reply-To: <20070214194919.GE28290@spearce.org> (Shawn O. Pearce's message
	of "Wed, 14 Feb 2007 14:49:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39736>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Bill Lear <rael@zopyra.com> wrote:
>> I have not yet figured this one out: I have not tagged anything, but
>> know that I checked in something lame sometime between now and two days
>> ago.  How do I get my working repo to be that as it was, say, yesterday?
>> 
>> Do I do:
>> 
>> % git log --since="2 days ago"
>> 
>> parse, the output for the commit I want, and then do
>> 
>> % git reset <SHA>
>
> No.  This would update your branch and your index to <SHA>, but
> leave your working directory alone.  That's not what you want here.
>
> Use `git checkout <SHA>` which will detach your HEAD and seek to
> the commit, leaving your current commit alone.  Later you can get
> back by `git checkout oldbranch`.

Ah, I thought Bill was talking about getting rid of lame one,
but now when I re-read his message, I think he is talking about
going there to take a look, not necessarily wanting to discard
or alter history.

Sorry, Bill, if that is the case, forget what I said about
reset/revert/rebase in the other message.
