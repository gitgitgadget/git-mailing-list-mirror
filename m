From: John Tapsell <johnflux@gmail.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 10:03:21 +0000
Message-ID: <43d8ce650902190203i4708f2b6r33aa1d856b89bb45@mail.gmail.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
	 <200902191101.35310.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:05:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5m8-0007JJ-9m
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbZBSKDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZBSKDX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:03:23 -0500
Received: from el-out-1112.google.com ([209.85.162.181]:38599 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZBSKDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:03:22 -0500
Received: by el-out-1112.google.com with SMTP id b25so163089elf.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 02:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=xgB3/Fu8MiJeJ8AQAexe58znHwirWOYne/btGsK7ZF8=;
        b=bXfhIy7fEH2BsN+GKCDxWqmw/GVW3gbFUHTCXwH5pqkhkyvDxqMF9o3wMVH8nAFjrb
         /CAfqgn2yNVLTqUq6A2tXkGRSUnOevZPvH4IQ6EO12t5NLtcI++XmQZ6nHjoW/QbfH70
         X+i/cskgrvBhsfyC4fXJKuYlzRYvxYyPLzcCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=MLMk7RD0Vs3Sl92Eo9PMHvETHNsHdh9COrePf8t+3qBAyQJPnulkiZsATWtmujXzxd
         6DAwDVtMmpxntIg6CXmWaYMadTmcr+D0j3M/t/6fQTbfo8nXcYO0EUgv86luNyvg8Kr2
         D0zzyJ+O0wF36phTAEVRCeD/ytg6qoe5Lqjc4=
Received: by 10.150.217.14 with SMTP id p14mr831899ybg.75.1235037801482; Thu, 
	19 Feb 2009 02:03:21 -0800 (PST)
In-Reply-To: <200902191101.35310.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110659>

2009/2/19 Thomas Rast <trast@student.ethz.ch>:
> John Tapsell wrote:
>>   I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
>> doesn't matter if you go back 'too far' I just always use HEAD~10 even
>> if it's just for the last or so commit.
>
> It makes a *huge* difference if any of those last N commits is a merge.

Lots of good points.  I'll leave this idea for now then :-)
