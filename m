From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: Git svn fetches entire trunk on tags (change from 1.6.5.2 to 1.7.0)
Date: Fri, 19 Feb 2010 06:14:00 -0600
Message-ID: <F3657B42-F723-4656-A86E-3117B355D6C0@gmail.com>
References: <5CFEDDA0-6C6B-43DF-8BB4-E303E91C24EF@gmail.com> <20100218000620.GA7123@dcvr.yhbt.net>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Andrew Myrick <amyrick@apple.com>, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 13:14:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiRkP-0006o1-J0
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 13:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0BSMOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 07:14:12 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59623 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0BSMOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 07:14:10 -0500
Received: by vws11 with SMTP id 11so449vws.19
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 04:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=GxnW4f71AMTI+p58LubqpNMdsLp3rykAaTjjNrywgbc=;
        b=k+TMWDYh3RLwV2gw2yPB7I9px3SnuXBKKCfjkJ0vgOS2SSvhEDqxlCtVqC8xvC5/Mb
         fcDbCtlhVuXZ4I3rqQ3n+UzG8qwY7QmpEWvhsfsabLmrddE7oXt1lUwqX6U6WFFE/tC8
         QBSUlr/JltMMXXyBYAf6LcU3i4USzIvn1I9G0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=IqwQog3PIWC1y8I42HM7rX7434q5Drhn/LOdoQzmaX/FQj7BJAEvpBBKQ4tGVWCAfC
         Jn96mGTNBj8Y83eSTUp3WKdcnv3muE/wOpA2pESyfMpruIpGtJQCAz21aoSKHghfPHOh
         aqxeSmQ2+uyrPjfsNaK0HCONAdLAQQ1ZmXjAk=
Received: by 10.220.125.8 with SMTP id w8mr4133125vcr.48.1266581649152;
        Fri, 19 Feb 2010 04:14:09 -0800 (PST)
Received: from ?10.80.66.231? (mobile-166-137-139-057.mycingular.net [166.137.139.57])
        by mx.google.com with ESMTPS id 25sm484140vws.12.2010.02.19.04.14.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Feb 2010 04:14:08 -0800 (PST)
In-Reply-To: <20100218000620.GA7123@dcvr.yhbt.net>
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140445>


On Feb 17, 2010, at 6:06 PM, Eric Wong <normalperson@yhbt.net> wrote:

> Robert Zeh <robert.allan.zeh@gmail.com> wrote:
>> On Feb 17, 2010, at 5:23 PM, Eric Wong <normalperson@yhbt.net> wrote:
>>> There was a rather large amount of changes between 1.6.5.2 so some
>>> regressions could've slipped in.  A bisection would definitely help
>>> us track down the cause.
>>
>> I will attempt a bisection Thursday.
>
> Awesome, thanks.

I now believe the real problem is that I had an ignore-paths set in  
the repo that fetched the entire trunk on branch.  Is this expected?

Robert
>
