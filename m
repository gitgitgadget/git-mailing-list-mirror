From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: Qn about git pull and git fetch
Date: Tue, 28 Sep 2010 16:01:19 -0400
Message-ID: <074C8233-BDFE-43AE-AF0A-2D510BF6F5DF@gernhardtsoftware.com>
References: <AANLkTi=-UU8X-7h8c4=UENRwNe+G2xGy54YhvWPnnY7y@mail.gmail.com> <9732E43E-124D-4145-A289-2E78F2277ACE@gernhardtsoftware.com> <4CA2473B.2040600@nextest.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: suvayu ali <fatkasuvayu+linux@gmail.com>, <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 22:01:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0gMl-0005QR-B4
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 22:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355Ab0I1UB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 16:01:26 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42752 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230Ab0I1UBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 16:01:25 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id EEDD41FFC6B6; Tue, 28 Sep 2010 20:01:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id CAA221FFC544;
	Tue, 28 Sep 2010 20:01:15 +0000 (UTC)
In-Reply-To: <4CA2473B.2040600@nextest.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157464>


On Sep 28, 2010, at 3:51 PM, Eric Raible wrote:

> On 11:59 AM, Brian Gernhardt wrote:
>> 
> 
>> Your branches should be set to track automatically but if they didn't for
>> some reason and are using v1.7.0 or newer, you can:
>> 
>> $ git branch --set-upstream master origin/next
>> Branch master set up to track remote branch next from origin.
>> $ git pull
>> 
>> If you're using git prior to v1.7.0, you can instead:
>> 
>> $ git config branch.master.remote origin
>> $ git config branch.master.merge refs/heads/master
>> $ git pull
> 
> Seems to me that to be equivalent, the first should be:
> 
> 	git branch --set-upstream master origin/master
> 
> or the second should be:
> 
> 	git config branch.master.merge refs/heads/next
> 
> Eh?

Oops.  I had forgotten to change the first one after some experimenting on the git.git repo.  I had meant

$ git branch --set-upstream master origin/master

Far more repos have a master branch than a next one.

~~ Brian
