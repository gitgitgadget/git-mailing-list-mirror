From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Can git for MinGW clone from http
Date: Wed, 21 Nov 2007 14:54:34 +0100
Message-ID: <4744389A.4020808@viscovery.net>
References: <474430F9.4080902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bo Yang <techrazy.yang@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 14:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuq2Z-0006yx-TM
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbXKUNyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 08:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbXKUNyi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:54:38 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55392 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbXKUNyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 08:54:37 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iuq1d-0005tm-LM; Wed, 21 Nov 2007 14:53:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 078B46EF; Wed, 21 Nov 2007 14:54:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <474430F9.4080902@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65649>

Bo Yang schrieb:
> Hi
>   I just installed the Git for MinGW in windows platform and I try to
> git clone http://......
> But it give a error message saying that there is no curl available. 
> Could you please tell me that does this version support clone through 
> http protocol? Thanks in advance!

Lets see:

	D:\Src>git clone http://repo.or.cz/r/kdbg.git
	Initialized empty Git repository in d:/Src/kdbg/.git/
	http transport not supported, rebuild Git with curl support

Which part of "http transport not supported" requires further explanation?

-- Hannes
