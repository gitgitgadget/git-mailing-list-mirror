From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Best way to specify all local branches and all remote branches.
Date: Mon, 11 Feb 2008 13:34:47 -0800 (PST)
Message-ID: <m3abm7dvp1.fsf@localhost.localdomain>
References: <47B09921.2070109@glidos.net>
	<m3ir0ve2c1.fsf@localhost.localdomain>
	<alpine.LSU.1.00.0802112022560.3870@racer.site>
	<47B0B775.1050401@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOgJa-0006ii-SN
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbYBKVe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbYBKVez
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:34:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:59520 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbYBKVew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 16:34:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so386615ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 13:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=750uFGrOV/gjNgO4Cg2+yN6pdhhsskuHgPmQ4zu1PHs=;
        b=WhKxI72+Z/Ba8wgNDJWBptym8hz7sG30WcPRh+DcEy9YOHwniN+Z+AZUdxYZU3j9VNrllJKNgnZDc2Om8EJu2juQpe1wo9IEWh1E1NV4GUZdUqYXCC3kbj7Qstlu5C3t6Qd1WhjJ48uSqUMiuftgo8RIkXuca/aLkgNrk7iqiyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=cFcNNbcq5E2YoXIkvivvJGk400C6NeX8fRGZZjPu18a4SSqsQP99R5agP0UCni4GZeTerEFhmv840JPQVMbotUwx6N5tZDp+p8StTUJEaHT6EMDd/DhXIpph5EszXmXnw4DtvRz7K2I5LklsyHxep3PIuPPHpu0PdSXuFB3R9ts=
Received: by 10.67.123.19 with SMTP id a19mr9600955ugn.4.1202765689218;
        Mon, 11 Feb 2008 13:34:49 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.23])
        by mx.google.com with ESMTPS id x33sm2332748ugc.68.2008.02.11.13.34.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 13:34:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1BLYEPd017783;
	Mon, 11 Feb 2008 22:34:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1BLY3PF017780;
	Mon, 11 Feb 2008 22:34:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <47B0B775.1050401@glidos.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73590>

Paul Gardiner <osronline@glidos.net> writes:

> Johannes Schindelin wrote:
>> On Mon, 11 Feb 2008, Jakub Narebski wrote:
>>
>>> git-filter-branch [...] should support --all.
>>
>> It does.
> 
> Yep, it does. I'd forgotten how to drive the shell. It works if
> I put -- --all.
> 
> Turns out that isn't what I want though. I want just the local
> branches. Still can't find a way to do it other than my cd/ls
> thing.

I wrote: git-for-each-ref(1). See documentation, please.

  $(git for-each-ref --shell --format="%(refname)" "refs/heads/*")

-- 
Jakub Narebski
Poland
ShadeHawk on #git
