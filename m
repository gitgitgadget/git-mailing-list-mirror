From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] use only the PATH for exec'ing git commands
Date: Tue, 23 Oct 2007 08:14:43 +0200
Message-ID: <471D9153.30109@viscovery.net>
References: <1193091122.v2.fusewebmail-240137@f>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: srp@srparish.net
X-From: git-owner@vger.kernel.org Tue Oct 23 08:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkD2Z-00055S-Jq
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbXJWGOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 02:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbXJWGOs
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:14:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30878 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXJWGOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 02:14:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IkD23-0002Eu-UP; Tue, 23 Oct 2007 08:14:28 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DC6126C4; Tue, 23 Oct 2007 08:14:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1193091122.v2.fusewebmail-240137@f>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62111>

Scott R Parish schrieb:
>> Alex Riesen, Mon, Oct 22, 2007 12:01
>> Scott R Parish, Mon, Oct 22, 2007 19:01:48 +0200:
>>> +                strbuf_addch(out, ':');
>> Shouldn't it break MingW32 native port?
> 
> What can i do here to better accommodate MingW32? You're
> right, just because the original code did it this way
> isn't a good excuse for me not to do it better.

Don't bother with it right now. GIT currently does not have MinGW specific 
code, yet.

-- Hannes
