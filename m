From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: t5541-http-push hanging
Date: Wed, 11 Nov 2009 11:53:24 -0500
Message-ID: <9D004E6C-52FF-441D-82A6-8D002401703A@gernhardtsoftware.com>
References: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com> <be6fef0d0911110747k219e1fe0l7bd19bbc58b5ea3e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 17:53:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8GRz-0001zb-20
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 17:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085AbZKKQxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 11:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758025AbZKKQxW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 11:53:22 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:54524 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbZKKQxV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 11:53:21 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id EF2731FFC087; Wed, 11 Nov 2009 16:53:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id AC5741FFC06B;
	Wed, 11 Nov 2009 16:53:21 +0000 (UTC)
In-Reply-To: <be6fef0d0911110747k219e1fe0l7bd19bbc58b5ea3e@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132673>


On Nov 11, 2009, at 10:47 AM, Tay Ray Chuan wrote:

> On Wed, Nov 11, 2009 at 2:28 PM, Brian Gernhardt
> <brian@gernhardtsoftware.com> wrote:
>> error: RPC failed; result=22, HTTP code = 500
>> ^CFATAL: Unexpected exit with code 130
> 
> looks like an apache/http-backend issue. What version of apache are you running?

It's Apache 2.2.13 on Mac OS X 10.6.2

> Also, are you running out of the 'next' branch?

Yes.  That particular build was v1.6.5.2-372-gc05027d

However I've been seeing it for a couple days.

~~ Brian