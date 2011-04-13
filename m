From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] remove doubled words, e.g., s/to to/to/, and fix related typos
Date: Wed, 13 Apr 2011 23:22:28 +0200
Message-ID: <87mxjtn8x7.fsf@rho.meyering.net>
References: <87d3kq6tz7.fsf@rho.meyering.net>
	<1302719749.21047.6.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:22:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA7WN-0005Gi-0h
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 23:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768Ab1DMVWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 17:22:37 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:47956 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397Ab1DMVWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 17:22:36 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 9BDAE940072
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 23:22:29 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 5214D60201; Wed, 13 Apr 2011 23:22:28 +0200 (CEST)
In-Reply-To: <1302719749.21047.6.camel@drew-northup.unet.maine.edu> (Drew
	Northup's message of "Wed, 13 Apr 2011 14:35:49 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171490>

Drew Northup wrote:
> On Wed, 2011-04-13 at 17:39 +0200, Jim Meyering wrote:
>> I found that some doubled words had snuck back into projects from
>> which I'd already removed them, so now there's a "syntax-check" makefile
>> rule in gnulib to help prevent recurrence.  Running the command below
>> spotted a few in git, too:
>>
>> This patch is relative to "next".
>
> Jim,
> Try putting the output of git format-patch into your drafts folder, then
> open that draft in your mail client. The output of format-patch isn't
> meant to be pasted directly into a mail message.

I hope I haven't caused Junio or anyone else undue trouble.
I know well how format-patch output can be used, but in the vast
majority of patch-including messages I send, I include format-patch
output mainly as an FYI, *following* commentary that does not
belong in the log, so it's ok there -- desirable, even.

I find it slightly backwards to have to put non-log (i.e, intro
commentary) *after* the real log, and that's why I've developed
this habit.

I'll try to remember to do it the other way when the
recipient is more likely to apply the patch.
