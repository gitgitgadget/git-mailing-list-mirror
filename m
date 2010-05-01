From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Sat, 01 May 2010 20:34:54 +0200
Message-ID: <4BDC744E.4050006@drmicha.warpmail.net>
References: <20100427135708.258636000@mlists.thewrittenword.com> <4BD7032D.9050508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 01 20:35:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8HWu-0007sl-4J
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 20:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab0EASe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 14:34:57 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35150 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744Ab0EASe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 14:34:56 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 66E79F2076;
	Sat,  1 May 2010 14:34:55 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 01 May 2010 14:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=macQD/Eg8Icp0RKUMvov78H8f/Y=; b=FvN9sUwIy2nFr1sQ9wZR9Oz9x+udrQ3JwWj4FMo6t8SfJLodzQO+QkTZ1WtbqjxH/HudLAqvGprttTbKupCHftlqBpYNrNXminY/+uxP3+0aG8xDso1S20NT7d06Oqiu7bVDrrx/Zddz3dhMfXgOgxy6AI9ds0Lb9VdHDqLNtKI=
X-Sasl-enc: +OEm/OvTBZBL5bmqHP7KNZkAopjmGTlIlsQyj9blRo94 1272738894
Received: from localhost.localdomain (p5DCC08EA.dip0.t-ipconnect.de [93.204.8.234])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 874281A375;
	Sat,  1 May 2010 14:34:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <4BD7032D.9050508@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146105>

[resent after vger recovery]
Michael J Gruber venit, vidit, dixit 27.04.2010 17:30:
> Gary V. Vaughan venit, vidit, dixit 27.04.2010 15:57:
>> Here are the portability patches we needed at TWW to enable git-1.7.1
>> to compile and run on all of the wide range of Unix machines we
>> support.  These patches apply to the git-1.7.1 release,  and address
>> all of the feedback from the previous three times I posted them to
>> this list, including fixing the massive testsuite failures I was
>> experiencing and taking into account that the ss_family fixes and
>> partial GMT_CMP_TEST fixes that have been pushed since my last post of
>> this patch queue.
> 
> General remark: None of your patches have a s-o-b line. If you want to
> have your patches in git you are required to sign-off on them (commit
> -s) in order to certify that you can submit them under the license terms
> of the project.
> 
> Your diff -> test_cmp are certainly something we want to have in any
> case. The code changes look ugly, honestly, making the code much less
> readable, but it seems to be the only way to make those older platforms
> and compilers happy. (Erik pointed out some good ways to reduce the
> uglyness somewhat.)
> 
> I can't test your target platform, but I would test the impact of the
> code and test changes on mine. Do you have your series somewhere to pull
> from?

OK, unsurprsingly, tests still pass on Linux (Fedora 12 x86_64).
If anyone wants to try, the series can be found at

git://repo.or.cz/git/mjg.git

in branch

gvv/platform-compatibility

applied cleanly on current master.

Cheers,
Michael
