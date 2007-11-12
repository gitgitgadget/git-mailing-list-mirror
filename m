From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 17:51:23 +0100
Message-ID: <4738848B.8020403@viscovery.net>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>	 <4738784F.7010106@viscovery.net>	 <Pine.LNX.4.64.0711121612250.4362@racer.site> <46dff0320711120839q7fc0542frd90a396237c144bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:51:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcVi-0002Bq-3P
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758789AbXKLQv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758762AbXKLQvZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:51:25 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32264 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbXKLQvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:51:25 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrcUu-0003Jl-88; Mon, 12 Nov 2007 17:50:52 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3087554D; Mon, 12 Nov 2007 17:51:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46dff0320711120839q7fc0542frd90a396237c144bf@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64662>

Ping Yin schrieb:
> On Nov 13, 2007 12:13 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
>>> There is already 'status.color', I suggest the configuration to become
>>> 'status.submoduleSummary'.
>> You could make this variable even a numeric one.  Saying how many lines
>> you want to have maximally (-1 meaning unlimited).
> Good idea.
> However, there is a problem about limiting the lines of commit
> summary: if there are 50 backwards and 50 forwards, and summary lines
> are limited to 50 lines. How to display? 25 backwards, 25 forwards or
> only 50 backwards?

Just use git log --left-right --topo-order, then you can easily insert -$n, 
and git-log will decide where it cuts off the lists.

However, --left-right won't reverse one of the list, like you did.

-- Hannes
