From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Any tricks for speeding up cvsps?
Date: Fri, 08 Feb 2008 11:33:26 +0100
Message-ID: <47AC2FF6.1030103@viscovery.net>
References: <47AC1FDC.9000502@glidos.net> <47AC2775.5090403@viscovery.net> <47AC2AC3.6020704@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:34:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQYh-0005qx-6R
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934564AbYBHKda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934562AbYBHKd3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:33:29 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:23150 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934370AbYBHKd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:33:28 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JNQXZ-0002rA-Id; Fri, 08 Feb 2008 11:33:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 61571A33B; Fri,  8 Feb 2008 11:33:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47AC2AC3.6020704@glidos.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73069>

Paul Gardiner schrieb:
> Johannes Sixt wrote:
>> I've used fast-export (not git-fast-export) to convert a CVS repository:
>>
>> http://repo.or.cz/w/fast-export.git
>>
>> It worked better than git-cvsimport because the repository was a real
>> mess.
> 
> That looks to require going either via svn or mercurial. Is that right?
> And if so, which did you find best?

You are right. Because I'm utterly confused. I actually used fromcvs/togit:

http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs

Please bear with me; I did this about a year ago. Sorry for the noise.

Be warned that fromcvs/togit does not convert tags.

-- Hannes
