From: Bill Lear <rael@zopyra.com>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 07:46:48 -0500
Message-ID: <18033.14520.846510.640130@lisa.zopyra.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:47:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyojI-0002AY-W4
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbXFNMrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbXFNMrI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:47:08 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60789 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbXFNMrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:47:07 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5ECknZ31887;
	Thu, 14 Jun 2007 07:46:49 -0500
In-Reply-To: <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50189>

On Wednesday, June 13, 2007 at 22:21:38 (-0700) Linus Torvalds writes:
>On Wed, 13 Jun 2007, Bill Lear wrote:
>>
>> We have some CVS users who complain that they cannot do a pull
>> into a dirty working tree, as they could under CVS.
>
>Well, a lot of people have told you that the answer is "don't do that", 
>but I actually somewhat disagree.

I have now officially fallen out of my chair.

>I think it might be perfectly fine to allow for a *fast-forward* pull to 
>do a three-way merge on the working tree, assuming the index is clean in 
>the paths that got modified.
>...
>It might make it a bit easier for CVS people to get used to the git model: 
>keep your dirty working tree, and do "git pull" to update it, and fix up 
>any conflicts in the working tree. That's how CVS works - it's a bad 
>model, but it's a model that may be worth supporting just to get people 
>more easily into the _good_ model.

Exactly my desires.  I think it could work reliably, and as they
mature into git users, they will come to appreciate branches.


Bill
