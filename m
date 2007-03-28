From: Bill Lear <rael@zopyra.com>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 18:08:07 -0600
Message-ID: <17929.45543.421196.935796@lisa.zopyra.com>
References: <17929.37382.984339.742025@lisa.zopyra.com>
	<20070327233552.GA7186@coredump.intra.peff.net>
	<17929.45060.6228.797279@lisa.zopyra.com>
	<20070328000149.GA12808@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLi5-0001bJ-6d
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 02:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933409AbXC1AIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933454AbXC1AIO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 20:08:14 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60223 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933409AbXC1AIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 20:08:13 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2S087V06165;
	Tue, 27 Mar 2007 18:08:07 -0600
In-Reply-To: <20070328000149.GA12808@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43330>

On Tuesday, March 27, 2007 at 20:01:49 (-0400) Jeff King writes:
>On Tue, Mar 27, 2007 at 06:00:04PM -0600, Bill Lear wrote:
>
>> Ok, thank you.  I will try this out and keep this in mind as I test
>> out the patch Johannes posted.
>
>This is, btw, completely different than what Johannes posted. His patch
>shows you the date of the _tip_ of each of the branches. My script shows
>the _oldest_ reflog for the branch. So it depends on whether you want
>them in order of "last worked on" or "created" (you said "created", but
>I wonder if "last worked on" is actually more useful).

Ah, yes, good point.  I think this all falls under the topic of branch
management, and it would be good to have a full suite of reports for
people with a rats' nest of branches to keep track of.  I'm up to ten
topic branches and plan on needing a few more soon.

Queries that help me answer the question of "did I merge this
branch?", "when did I merge it?" (i.e., "Can I delete this branch?"),
along with creation times and last modified times, I think would be
helpful.

Thank you again.


Bill
