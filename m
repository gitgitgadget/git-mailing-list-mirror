From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Thu, 25 Apr 2013 06:26:32 +0200 (CEST)
Message-ID: <20130425.062632.630918480810226803.chriscool@tuxfamily.org>
References: <20130422210229.GE5650@pvv.ntnu.no>
	<7vr4i2nuar.fsf@alter.siamese.dyndns.org>
	<20130422222058.GF5650@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: hegge@resisty.net
X-From: git-owner@vger.kernel.org Thu Apr 25 06:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVDlc-0006dZ-Ea
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 06:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839Ab3DYE0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 00:26:36 -0400
Received: from mail-1d.bbox.fr ([194.158.122.56]:45273 "EHLO mail-1d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667Ab3DYE0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 00:26:36 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1d.bbox.fr (Postfix) with ESMTP id 3303B33;
	Thu, 25 Apr 2013 06:26:33 +0200 (CEST)
In-Reply-To: <20130422222058.GF5650@pvv.ntnu.no>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222341>

From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Tue, 23 Apr 2013 00:20:58 +0200

> On Mon, Apr 22, 2013 at 14:13:00 -0700, Junio C Hamano wrote:
>> Torstein Hegge <hegge@resisty.net> writes:
>> 
>> > I took another look at this. I wasn't able to come up with anything
>> > useful for the "The merge base $rev is bad" case, but for the "only
>> > skipped commits left to test" case one could do something like this.
>> 
>> We skipped them because we can gain _no_ information from testing
>> these commits. They are not even "possibly bad", but are "unknown".
>> 
>> So it feels to me that by definition listing them would not be
>> useful. What am I missing?
> 
> The information lies in that those commits are the only commits with an
> unknown state. So if the bisecter hands off the bisect log to someone
> else when they can't test further, the current status is recorded.

Yeah, I think it is a good enough reason for your patch.
 
> I think part of the reason I started looking at this is that there are
> no good way to see what git said after the previous 'git bisect
> good/bad' if the terminal output is lost. And lost terminal output is
> fairly likely if you are bisecting something that requires reboots for
> each test.

Yeah, I agree.

> But I don't feel very strongly about this. It was based on Christian's
> idea, so unless he comes up with some compelling arguments I'll drop it.

I think your arguments are good enough.

Thanks,
Christian.
