From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: segfault in diff-delta.c on mac os x (commit 8433669)
Date: Sun, 22 Jul 2007 14:59:10 +0200
Message-ID: <B19AC964-3398-46AF-934B-BB2F06688F7B@zib.de>
References: <C10CCDA5-6D65-445E-92F3-2D3E4DCA4F8B@zib.de> <233B9D70-9D91-4527-9801-7E2463ABDDAA@silverinsanity.com> <6A487E9A-27E5-4212-A7C9-EBB6528791FE@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 14:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICb0v-0004a1-SE
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 14:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760011AbXGVM6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 08:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbXGVM6T
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 08:58:19 -0400
Received: from mailer.zib.de ([130.73.108.11]:41720 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754528AbXGVM6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 08:58:18 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6MCwFYV025551;
	Sun, 22 Jul 2007 14:58:15 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1b753.pool.einsundeins.de [77.177.183.83])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6MCwDKO008534
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 22 Jul 2007 14:58:14 +0200 (MEST)
In-Reply-To: <6A487E9A-27E5-4212-A7C9-EBB6528791FE@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53265>


On Jul 22, 2007, at 10:49 AM, Steffen Prohaska wrote:

>
> On Jul 22, 2007, at 5:35 AM, Brian Gernhardt wrote:
>
>>
>> On Jul 21, 2007, at 11:15 AM, Steffen Prohaska wrote:
>>
>>> 843366961cf14aad6490fbeb30f7b98f37f8833a may cause segfaults on
>>> Mac OS X. See backtrace below. I only observed the segfault with
>>> -O2 builds.
>>
>> I have been using git on my OS X box for quite a while, and that  
>> commit appears to be nearly two months old.  I have yet to see any  
>> packing errors in any of my repositories.  (This is with -O2,  
>> which appears to be the default.)
>>
>> My gcc reports itself as build 5367 instead of 5250.  Perhaps  
>> there is a compiler error in an older copy of the DevTools?
>
> This seems to be the case. I upgraded the compiler and
> tried again. The segfault didn't happen again. Note, this
> was not exactly the same situation as before because the
> git repository used for testing changed a bit since the
> first segfault.
>
> I'll do some more repacking over the day and will report
> my observations.

I did a lot more testing and am pretty convinced now that
the problem is not present with the newer compiler. Using
build 5367 of gcc seems to creating a working git executable
while build 5250 creates a broken one.

	Steffen
