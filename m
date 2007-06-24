From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 19:13:42 +0200
Message-ID: <EA80EB51-97F9-4C5F-BEF7-C8C1BF39B8D2@zib.de>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <20070624082906.GB2467@steel.home> <4D530871-0CBE-4F9A-99B7-ECF0F4656D85@zib.de> <20070624093017.GC2467@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 19:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Vdg-0005CO-53
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 19:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXFXRMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 13:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbXFXRMi
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 13:12:38 -0400
Received: from mailer.zib.de ([130.73.108.11]:63708 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbXFXRMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 13:12:38 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5OHCalR018275;
	Sun, 24 Jun 2007 19:12:36 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db104ed.pool.einsundeins.de [77.177.4.237])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5OHCZvB021356
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 24 Jun 2007 19:12:35 +0200 (MEST)
In-Reply-To: <20070624093017.GC2467@steel.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50804>


On Jun 24, 2007, at 11:30 AM, Alex Riesen wrote:

>> I am changing the repository.
>>
>
> No, you don't.

Magically, the script solved my problem by creating a new, corrected
branch that is different from the original one. I didn't run any
other script. I promise, I ran the script that I sent in the patch.


>> I only modify the index for files that have changes in $commit. Their
>> content gets replaced by the content from the commit. I'm leaving
>> all other files untouched.
>
> No, you don't modify anything. Ever tried to run git-status after your
> script finished?

Yes.

> Tried to understand what the output means?

Not really. I instead reset the index to a controlled state.

	Steffen
