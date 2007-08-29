From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: gitk: cherry-pick issue
Date: Wed, 29 Aug 2007 08:52:41 +0200
Message-ID: <46D517B9.1070906@eudaptics.com>
References: <46D44C4A.90204@eudaptics.com> <18132.45162.604130.618577@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQOvj-0003KU-VJ
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 16:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbXH2Gx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 02:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbXH2Gx2
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 02:53:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59094 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbXH2Gx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 02:53:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IQHQa-0004fo-Q2; Wed, 29 Aug 2007 08:53:25 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5FE226D7; Wed, 29 Aug 2007 08:53:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <18132.45162.604130.618577@cargo.ozlabs.ibm.com>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.369, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56902>

Paul Mackerras schrieb:
> Johannes Sixt writes:
> 
>> Please run this on a checkout of git.git:
>>
>> 	$ git checkout -b gitktmp v1.5.3-rc6
>> 	$ gitk HEAD^.. 324a8bd
>>
>> Then right-click on
>>
>> 	324a8bd git-send-email --cc-cmd
>>
>> (which is in 'next') and choose "Cherry-pick this commit". I get this error:
>>
>> can't read "nbmp": no such variable
> 
> I assume you have "Show nearby tags" turned off.  I'll fix it, but in
> the short term you can work around it by turning "Show nearby tags"
> on.

Yes, indeed, I had this option turned off.

-- Hannes
