From: david@lang.hm
Subject: Re: merge time
Date: Mon, 30 Jul 2007 09:23:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707300922420.11330@asgard.lang.hm>
References: <153733.59721.qm@web51006.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:25:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFY3P-0003L1-6L
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 18:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966495AbXG3QZB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 12:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966213AbXG3QZA
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 12:25:00 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:57845
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965093AbXG3QY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 12:24:58 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l6UGObTa019281;
	Mon, 30 Jul 2007 09:24:37 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <153733.59721.qm@web51006.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54238>

On Mon, 30 Jul 2007, Matthew L Foster wrote:

> --- david@lang.hm wrote:
>
>> if you clone your tree and merge from mine, and I clone my tree and merge
>> from yours, the result of both merges _must_ be the same there will be
>> trouble when we both try and merge with tree C later on.
>>
>> another thing is that a given commit cannot be changed once it's created
>> (if it was changed it wouldn't have the same sha1 value) so you can't just
>> go around changeing dates on commits that took place elsewhere.
>
> Local commit order is stored locally right?

not normally. you could enable reflogs and then mine through the reflogs 
to find the info, but it's not stored in any easy to access fashion.

David Lang

> From looking at gitweb on kernel.org it seems all the
> info is already there, a merge has a list of commits in that merge and they should be displayed in
> local commit order rather than external creation time order.
>
> -Matt
>
>
>
>
> ____________________________________________________________________________________Ready for the edge of your seat?
> Check out tonight's top picks on Yahoo! TV.
> http://tv.yahoo.com/
>
