From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Documentation: diff-filter=T only tests for symlink changes
Date: Sun, 19 Oct 2008 10:04:54 +0900
Message-ID: <20081019100454.6117@nanako3.lavabit.com>
References: <87vdvq5lu4.fsf_-_@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 03:06:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrMkk-0007ab-Cm
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 03:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbYJSBFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 21:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbYJSBFZ
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 21:05:25 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56553 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbYJSBFY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 21:05:24 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 34077C7B61;
	Sat, 18 Oct 2008 20:05:24 -0500 (CDT)
Received: from 9977.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 4AVMUV5Y015R; Sat, 18 Oct 2008 20:05:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=WEo+esUikubQE33XdO4zBqgDMeMk2JkPP0TkTrlrC5B3asJcQJi+2wXcyDRsipwtPyOgFuxoz1Ts4cUpR1WZS0L03TYzz7qzMbQA0BpaikJGQ4qb3ABbBWTZE4PmQa6KYyce0nBFBHlndGdar/9gq4EWD2fbrBi0B5BcoZ8QAaY=;
  h=From:To:Cc:Date:Subject:In-reply-to:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <87vdvq5lu4.fsf_-_@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98587>

Quoting Junio C Hamano <gitster@pobox.com>:
>
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Quoting Anders Melchiorsen <mail@cup.kalibalik.dk>:
>>
>>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>>> index 7788d4f..7604a13 100644
>>> --- a/Documentation/diff-options.txt
>>> +++ b/Documentation/diff-options.txt
>>> @@ -137,7 +137,7 @@ endif::git-format-patch[]
>>>  --diff-filter=[ACDMRTUXB*]::
>>>  	Select only files that are Added (`A`), Copied (`C`),
>>>  	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
>>> -	type (mode) changed (`T`), are Unmerged (`U`), are
>>> +	type (symlink/regular file) changed (`T`), are Unmerged (`U`), are
>>>  	Unknown (`X`), or have had their pairing Broken (`B`).
>>>  	Any combination of the filter characters may be used.
>>>  	When `*` (All-or-none) is added to the combination, all
>>> -- 
>>> 1.6.0.2.514.g23abd3
>>
>> Are symlinks and regular files the only kind of object you can see in
>> diff? What happens when a file or directory changes to a submodule?
>
> Oops.  I've already applied Anders's patch, but you are right.  A change
> from a blob to submodule also shows up as a typechange event.
>
> Perhaps we should just remove the parenthesised comment from there
> instead.  I'll rewind and rebuild, as I haven't pushed the results out
> yet (lucky me).

I see that you pushed out this change already, and you changed your mind and described them all.  I think the result reads better.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
