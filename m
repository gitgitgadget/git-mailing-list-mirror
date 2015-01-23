From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: git pull not ignoring the file which has been sent to the temporary ignore list
Date: Sat, 24 Jan 2015 01:05:53 +0630
Organization: CognitiveClouds
Message-ID: <4004424.cytMaov38D@linux-wzza.site>
References: <3278910.5D06XWKxyS@linux-wzza.site> <xmqqiofxqoo3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 20:43:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEk96-0000Ng-Ch
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 20:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534AbbAWTnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 14:43:53 -0500
Received: from nm14-vm7.bullet.mail.sg3.yahoo.com ([106.10.149.38]:59094 "EHLO
	nm14-vm7.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756494AbbAWTnv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2015 14:43:51 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jan 2015 14:43:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1422041852; bh=uwUwmUV6iYKGDQI0pDCybiIdQQ+NsAfIyumDjbctp4Y=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=GIOOASgra4Zc5s2tMZDo8ttIxeQOjn1cJzGGZY4DXwQyuGiAgBuGgRpvDIGNgncRNGU48/mwKTd55uGdiI2tmkPLau2t+u5b02Y5PDaA4QXRtx5nKE8ujN8/vmky0/hHHZT8xXXhe3t4V3RFwKACIIj6Q1LoOFXZHJplQ31K1Sn/FVppBHzI2hn1JExe3PKAKGxZFcui8CzjWBe3jb/PlnnfMbIerHwSl0y/hfdbqoWbqR2dgILPR7JTJaFFlnbhjpzZE85VqdYRVALn8GsudL7ejVmyrVURatA0gKFl55BLEiNT11mMJN9aYY/c2+uwpIWPaNddPrjIOGfH/n06eg==
Received: from [106.10.166.62] by nm14.bullet.mail.sg3.yahoo.com with NNFMP; 23 Jan 2015 19:37:32 -0000
Received: from [106.10.167.172] by tm19.bullet.mail.sg3.yahoo.com with NNFMP; 23 Jan 2015 19:37:32 -0000
Received: from [127.0.0.1] by smtp145.mail.sg3.yahoo.com with NNFMP; 23 Jan 2015 19:37:32 -0000
X-Yahoo-Newman-Id: 870226.91892.bm@smtp145.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: F8vkcswVM1mlld7OrbcS4wsUMV0gUuQWNvpdY_3CENMxwh9
 KyPp1e_SN0iWtxTnD9LkWM80XWuYzI6K_AiEwjFGcs24kjc3TjnomN_yycAi
 de16cE3G9_6TugSyYgzrbJ.Jqv88sjSdPMuT4L65rTaK.JyK17aVJbAHfj_l
 hj11xGPo9UyapPO7x4JGcKfXcVhcmD.FCbQ4L1ivcC1ljkCCL5uqQp4bcx4e
 cDy4vVpWbNV11r1gJy_PpOvE1B7TzxR.34jfDXVkEH1SDNvz08sfRI2lIkYV
 16XPbFQicnL2QK2X55O.e85PpzIo8x9TWhQhXfJKwAjxJ0eEzoQMqhs2rfWy
 b2jvFuKkBUSx7en2JWwhLhUs.C9aJXYisCJqoXJkdWF8UVgLOY51qgxuik2f
 lmEQXq7Pgct7S12pZYfKzH_UpLJn1jYsg4ntHgrHNDJvMlJnYBho1iIwyucX
 tpLfuOApHCVUZI0NWyxDXEnyeLn3h0JEt9dosUt0g7ZZFw9jlStxV5W5604n
 MEMXD18VWJJx3gsnL5Q6SBxj4Vr4Nh36eH5ACUsCbxxTO24B9Z1rve0Mcgu4
 Ftbhh54Ajxw--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
User-Agent: KMail/4.11.5 (Linux/3.11.10-25-default; KDE/4.11.5; i686; ; )
In-Reply-To: <xmqqiofxqoo3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262950>

On Friday, January 23, 2015 11:31:40 AM you wrote:
> Arup Rakshit <aruprakshit@rocketmail.com> writes:
> 
> > I asked git not to track any changes to the file .gitignore. To do
> > so I did use the command - git update-index --assume-unchanged
> > .gitignore.
> 
> You are not asking Git to do anything. You promised Git that you
> will make no changes to .gitignore, and then broke that promise.
> 
> Assume-unchanged is *not* "Ignore changes to this path".

Ok. How should I then ignore any local changes to the .gitignore file ? And while taking pull, git should skip this file ?
-- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.

--Brian Kernighan
