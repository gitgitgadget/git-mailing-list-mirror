From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/8] git-rebase.sh: Fix --merge --abort failures when
 path contains whitespace
Date: Thu, 10 Apr 2008 08:10:38 +0200
Message-ID: <47FDAF5E.6070101@viscovery.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <47FC6863.8070704@viscovery.net> <20080409143702.GD24402@shion.is.fushizen.net> <47FCD7E8.40004@viscovery.net> <20080409150246.GE24402@shion.is.fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 08:11:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjq0Z-0008L5-Sj
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbYDJGKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbYDJGKq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:10:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31983 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbYDJGKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:10:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jjpzb-00056C-9L; Thu, 10 Apr 2008 08:10:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E79466C4; Thu, 10 Apr 2008 08:10:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080409150246.GE24402@shion.is.fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79168>

Bryan Donlan schrieb:
> On Wed, Apr 09, 2008 at 04:51:20PM +0200, Johannes Sixt wrote:
>> Bryan Donlan schrieb:
>>
>>> If you like I can add a change to the trash directory to the next rev of
>>> the patchset.
>> Yes, why not?
> 
> How exotic ought it be? I'm not entirely sure which characters are
> allowed on windows or any other non-unixes that git supports (are there
> any?)

What you had in your patch is OK: " ' $ The backslash is also a notable
special character, but it is a directory separator on Windows, so it
should not be in the name.

-- Hannes
