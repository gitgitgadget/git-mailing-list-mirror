From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Mon, 6 Aug 2007 07:20:17 +0200
Message-ID: <73E0048A-0F57-47AC-933C-55C041ACFD23@zib.de>
References: <20070803125634.GB28323@fieldses.org> <1186318785677-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0708051457110.14781@racer.site> <17AA7EBE-B755-4F26-9C7E-AF6D762811F2@zib.de> <85wswa6n1o.fsf@lola.goethe.zz> <5AB64D44-2324-4A98-B010-8D6D6225F116@zib.de> <Pine.LNX.4.64.0708060119320.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 07:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHv0Z-00070J-1m
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 07:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbXHFFTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 01:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXHFFTn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 01:19:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:49534 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbXHFFTm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 01:19:42 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l765JSMc015006;
	Mon, 6 Aug 2007 07:19:40 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.251.214])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l765JRh2013964
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 6 Aug 2007 07:19:27 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708060119320.14781@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55114>


On Aug 6, 2007, at 2:22 AM, Johannes Schindelin wrote:

> On Sun, 5 Aug 2007, Steffen Prohaska wrote:
>
>> I found it quite useful to be able to commit diff chunks selectively.
>
> But how do you make sure that it works as expected?  I.e. when you  
> commit
> a hunk using, say, variable "rule_the_world", and by mistake  
> (happen to me
> all the time, maybe to you, too?) forgot to select the hunk which  
> declares
> that variable, maybe because it is hidden in a forest of other  
> variables?

In various ways, the details depend on what I'm doing. Here are three
examples.

1) I push the commit to a faster machine to compile it there and  
continue
working on the next commit (a complete build of the software package  
that
I'm mostly working on takes approximately 30 min on our fastest  
machines. I
can't wait for this before I continue working. Luckily a complete  
compile is
rarely needed).

2) I don't care about a single commit. I only care about the result of a
series of commits. I need to check on multiple architectures anyway  
and can't
thoroughly test what I'm doing right now. Regularly gcc and Microsoft
compilers disagree on warnings.

3) I push a series of commits to my scratch space and wait one night  
for the
automated builds to complete on all architectures.

> I _try_ to test commits by my eyes, by compiling, and by running the
> version I'll commit.  (Okay, sometimes I run the test _after_  
> committing,
> but then I test to see if I have to amend something.)

Option (1) is probably the only solution that fulfills your  
requirement that
every single commit should compile and work. This is a perfect  
approach but
sometimes take too much time for me.

	Steffen
