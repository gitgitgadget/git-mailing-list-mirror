From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/3] t3700: avoid racy git situation
Date: Thu, 08 Nov 2007 15:34:13 +0100
Message-ID: <47331E65.9010209@viscovery.net>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site> <Pine.LNX.4.64.0711081414160.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8TO-00018p-EU
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758774AbXKHOeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758746AbXKHOeV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:34:21 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:17598 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbXKHOeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:34:20 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iq8S2-0001IA-6t; Thu, 08 Nov 2007 15:33:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1B9B16B7; Thu,  8 Nov 2007 15:34:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711081414160.4362@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64030>

Johannes Schindelin schrieb:
> Wow, the builtin commit is fast.  It sometimes triggers a racy
> situation in the test case for "git add --refresh -- foo".
> 
> So when that test fails, simply sleep one second and try again.

[/me looks at the calender - no, it's not April Fool's day]

Wouldn't it be better to fix git-commit (or git-add)? I would like to help, 
but you already seem to have done the analysis, so...

-- Hannes
