From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH] git-svn: Don't rely on $_ after making a function call
Date: Wed, 25 Apr 2007 14:03:22 -0700
Message-ID: <3601FA1C-CDB1-4BFE-93D7-8FF1A79DCF45@apple.com>
References: <11775270321427-git-send-email-aroben@apple.com> <20070425205948.GA12375@untitled>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:03:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgoeM-0002SY-H8
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbXDYVDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754215AbXDYVDh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:03:37 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:54205 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbXDYVDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:03:36 -0400
Received: from relay6.apple.com (relay6.apple.com [17.128.113.36])
	by mail-out4.apple.com (8.13.8/8.13.8) with ESMTP id l3PL3Zjx010626;
	Wed, 25 Apr 2007 14:03:35 -0700 (PDT)
Received: from relay6.apple.com (unknown [127.0.0.1])
	by relay6.apple.com (Symantec Mail Security) with ESMTP id B291B10084;
	Wed, 25 Apr 2007 14:03:35 -0700 (PDT)
X-AuditID: 11807124-9fc9bbb000000872-c1-462fc227cfe7 
Received: from [17.219.212.53] (unknown [17.219.212.53])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay6.apple.com (Apple SCV relay) with ESMTP id 2ED0710054;
	Wed, 25 Apr 2007 14:03:35 -0700 (PDT)
In-Reply-To: <20070425205948.GA12375@untitled>
X-Mailer: Apple Mail (2.752.3)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45578>

On Apr 25, 2007, at 1:59 PM, Eric Wong wrote:

> Adam Roben <aroben@apple.com> wrote:
>> Many functions and operators in perl set $_, so its value cannot  
>> be relied upon
>> after calling arbitrary functions. The solution is simply to copy  
>> the value of
>> $_ into a local variable that will not get overwritten.
>
> Does this fix any particular bug?  It looks right to me
> and makes the code easier to follow, so;

    Yes, I was getting warnings that $_ was uninitialized in the eq.  
Sorry for not mentioning that.

-Adam
