From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 00/10] Fix git's test suite to pass when the path	contains
 spaces
Date: Mon, 05 May 2008 10:19:23 +0200
Message-ID: <481EC30B.4060401@viscovery.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net> <1209879480-16910-1-git-send-email-bdonlan@fushizen.net> <481EB155.6050501@viscovery.net> <20080505075940.GB20537@shion.is.fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Mon May 05 10:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsvvj-0006jL-O4
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 10:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbYEEIT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 04:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYEEIT1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 04:19:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:22692 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbYEEIT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 04:19:26 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jsvut-0006IL-K2; Mon, 05 May 2008 10:19:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3EED56D9; Mon,  5 May 2008 10:19:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080505075940.GB20537@shion.is.fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81242>

Bryan Donlan schrieb:
> On Mon, May 05, 2008 at 09:03:49AM +0200, Johannes Sixt wrote:
>> Please post an incremental diff when you resend it. Feel free to add:
> 
> When you say post an incremental diff, do you mean send just an
> additional patch to squash in, or re-send the series with an interdiff
> from the previous?

The latter. Since you'll most likely use rebase -i, this will amount to
just 'git diff wst-submit3@{yesterday}..' or so.

(This assumes that the rebased series originates from the same commit; if
it doesn't because you have meanwhile updated your origin/master, you
should first rebase without any changes, then rebase -i again, and make
changes during this second rebase; then the interdiff is 'git diff
wst-submit3@{1}..'.)

>> Tested-by: Johannes Sixt <johannes.sixt@telecom.at>
> 
> And does this go on a specific patch or the whole series?

You can add it to every patch below the SOB line.

-- Hannes
