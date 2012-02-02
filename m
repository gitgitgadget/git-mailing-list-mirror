From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: rebase -i reword converts to pick on pre-commit non-zero exit
Date: Wed, 01 Feb 2012 23:12:59 -0500
Message-ID: <4F2A0D4B.6000001@sohovfx.com>
References: <jgcaoh$d9q$1@dough.gmane.org> <4F29AE8E.6070109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 05:14:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rso3j-0003Nq-TL
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 05:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab2BBEOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 23:14:00 -0500
Received: from smtp04.beanfield.com ([76.9.193.173]:58990 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab2BBEN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 23:13:59 -0500
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1Rso3Z-000HcK-9P
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta04.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1Rso3Z-000HcK-9P; Wed, 01 Feb 2012 23:13:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F29AE8E.6070109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189580>

On 12-02-01 4:28 PM, Neal Kreitzinger wrote:
> Instead of picking commit (a) when the pre-commit
> hook exits non-zero on the reword command, shouldn't interactive rebase
> learn to edit commit (a) and tell the user that because the pre-commit 
> hook
> exited non-zero they need to either remedy the pre-commit hook violations
> and run git commit --amend or run git commit --amend --no-verify to 
> bypass
> the pre-commit hook?

Yup, I've submitted a patch to address this issue a while ago. This new 
behavior should be in v.1.7.8.2 and later.
