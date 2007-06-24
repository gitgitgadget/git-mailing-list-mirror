From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 2/2] Teach rebase an interactive mode
Date: Sat, 23 Jun 2007 23:39:11 -0400
Message-ID: <31A266F6-775E-41AE-B757-BF0DDAC6CAA5@silverinsanity.com>
References: <Pine.LNX.4.64.0706240001150.4059@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 05:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Iwc-0002VY-B1
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 05:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbXFXDjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 23:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbXFXDjR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 23:39:17 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41706 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbXFXDjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 23:39:16 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 9401F1FFC003;
	Sun, 24 Jun 2007 03:39:15 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.64.0706240001150.4059@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50767>


On Jun 23, 2007, at 7:01 PM, Johannes Schindelin wrote:

>
> With "--interactive", git-rebase now lets you edit the list of patches
> to be reapplied, so that you can reorder and/or delete patches.
>
> Such a list will typically look like this:
>
> 	pick deadbee The oneline of this commit
> 	pick fa1afe1 The oneline of the next commit
> 	...
>

It's not at all obvious from your commit message or the documentation  
where this list comes from.  At first look I thought I would have had  
to type it in.  It took digging into the code to be sure how it  
worked.  You probably want to mention in the documentation that the  
list is generated from the arguments and given in a text editor.

Is there a way to say "Oops, that's the wrong list.  Don't do  
anything."?

Perhaps starting the list with a header like the following would make  
it more user-friendly (Obviously requires s/#.*$//):

# Rebasing $from..$to onto $commit
#
# Commands:
#  pick = use commit
#  squash = meld commit into previous
# <<More useful information here>>

However, those are nits to take a good idea to a great one.  I like  
it very much.

~~ Brian
