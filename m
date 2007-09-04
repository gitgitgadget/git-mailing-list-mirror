From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 16:07:16 +0200
Message-ID: <46DD6694.6030701@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com> <46DD473A.8010602@trolltech.com> <46DD63F5.5050002@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZ3z-0007LP-Qu
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbXIDOH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbXIDOH1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:07:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20439 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbXIDOH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:07:26 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISZ3p-0008Vp-RZ; Tue, 04 Sep 2007 16:07:25 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 490B16B7; Tue,  4 Sep 2007 16:07:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46DD63F5.5050002@trolltech.com>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.362, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57574>

Marius Storm-Olsen schrieb:
> Marius Storm-Olsen said the following on 04.09.2007 13:53:
>> In the meantime, I've pushed out a new patch
>> http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=683775c00d9fb95bcbe4632f95b67a96b902fa59 
>>
>>
>> /me starts another test run, to see how our tests are doing now..
> 
> Neat, with the custom stat() changes cherry-picked on top of 
> 4msysgit.git 'devel' branch, I only have one failing testcase
>     t6024-recursive-merge.sh
> when running
>     $ NO_SYMLINKS=1 make -k
> 
> The rest are passing with flying colors!

And that one will eventually pass if only you try it often enough. See 
71ee4210c in mingw.git.

-- Hannes
