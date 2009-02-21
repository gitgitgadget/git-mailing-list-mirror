From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git merge --abort
Date: Sat, 21 Feb 2009 00:34:58 -0800 (PST)
Message-ID: <m3ocwwrxtg.fsf@localhost.localdomain>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
	<7v63j6n16s.fsf@gitster.siamese.dyndns.org>
	<43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
	<76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
	<43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
	<7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
	<3e8340490902202328r7caca98q973c17dc163e2028@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 09:36:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LanLc-0003mg-Ca
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 09:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbZBUIfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 03:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZBUIfE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 03:35:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:24405 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZBUIfB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 03:35:01 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2175663fgg.17
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 00:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=8lvWuEpJ9WW4YOBCqWnrEIk3MN9YTSF0axMcLErU3lk=;
        b=voeBF3G/CLTOMOzoYWGZ6welSxWgCJxjNBhQBP1f/5QUxfoGfbZHztX8240KqyDNoQ
         pVTSKMasvYKAxWfp6GyANzJ3T0iND+rX/uKA8dlQLVPVJ8ebZqXMBPg2mG1aGkp1g90v
         YzB0eq42TXhDcO7tCKzwzuVMm1yd5A1HY92cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=lh5oC9r59TtnI5t19QhRQ6eKg3CnDeAdy1p/Jidgel9oeXJbNqutLjXDpvgybRs5ST
         IrD0USBB0gsAU4MmxnbYwC/HU/BZyu5PzaOEoeKjCucN4aGsGKngxaQmY5cyzVBQ1NoM
         N1Jz9Lxtw7LtLxgl8XhRijX76IHbIIqN1wzA8=
Received: by 10.86.76.20 with SMTP id y20mr1557745fga.37.1235205299220;
        Sat, 21 Feb 2009 00:34:59 -0800 (PST)
Received: from localhost.localdomain (abvl165.neoplus.adsl.tpnet.pl [83.8.209.165])
        by mx.google.com with ESMTPS id l12sm4274674fgb.51.2009.02.21.00.34.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Feb 2009 00:34:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1L8aVgY018398;
	Sat, 21 Feb 2009 09:36:31 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1L8aRYD018395;
	Sat, 21 Feb 2009 09:36:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <3e8340490902202328r7caca98q973c17dc163e2028@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110932>

Bryan Donlan <bdonlan@gmail.com> writes:
> On Fri, Feb 20, 2009 at 12:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> John Tapsell <johnflux@gmail.com> writes:
>>> 2009/2/19 Jay Soffian <jaysoffian@gmail.com>:
>>>> On Thu, Feb 19, 2009 at 8:34 AM, John Tapsell <johnflux@gmail.com> wrote:
>>>>>
>>>>> There's no reliable way of getting back to the state before the merge?
>>>>
>>>> Sure there is. Commit or stash before you merge, so that your index
>>>> and working copy are clean.
>>>
>>> Could a stash be done automatically by the merge command, for just a case?
>>
>> It cuts both ways.  For people who work on a well organized project
>> (i.e. highly modularized) and tend to keep local changes in the work tree
>> while doing a lot of merges, running "stash" every time would (1) remove
>> the local change from the work tree, which he has to remember to manually
>> unstash after resolving conflicts in the merge (which would not have
>> conflicted with the local change anyway), which is an additional work for
>> no real gain, and (2) clutter his stash.  My gut feeling is that it is a
>> change that affects the way the end user has to work that is sufficiently
>> different and disruptive for no real gain.
> 
> Perhaps a better approach would be to stash the pre-merge state in the
> reflog, then? That is, manufacture a pre-merge commit containing all
> files changed in the working copy, and add it to the reflog prior to
> performing a merge. git merge --abort can then simply check whether
> the top reflog entry is a pre-merge state, and if so, reset --hard to
> it, then reset the index to the parent of our pre-merge commit.
> 
> This would also nicely handle the case where the user tries some
> random things before deciding to abort the merge.

Perhaps this is the case fo "feature that waits for a user", namely
'git stash --no-reset', which would save a state just in case, perhaps
in a separate area and not refs/stash (ORIG_STASH perhaps?).

What do you think about this idea?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
