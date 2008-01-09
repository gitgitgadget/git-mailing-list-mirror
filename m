From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 09 Jan 2008 11:01:04 +0100
Message-ID: <47849B60.2060000@viscovery.net>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>	 <47848CDD.7050806@viscovery.net> <7bfdc29a0801090151k22d3cd5aqedb0d4860868d4d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 11:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCXkj-0006Kn-VO
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 11:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbYAIKBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 05:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYAIKBL
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 05:01:11 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25022 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYAIKBK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 05:01:10 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCXk8-0004rl-RK; Wed, 09 Jan 2008 11:01:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3DA474E4; Wed,  9 Jan 2008 11:01:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7bfdc29a0801090151k22d3cd5aqedb0d4860868d4d9@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69975>

Imran M Yousuf schrieb:
> On Jan 9, 2008 2:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> - Previously, passing --cached to add, init, or update was an error, now
>> it is not.
> 
> The usage statement and this behaviour is rather contradicting. The
> usage says that --cached can be used with all commands; so I am not
> sure whether using --cached with add should be an error or not. IMHO,
> if the previous implementation was right than the USAGE has to be
> changed, and if the previous implementation was incorrect, than if the
> default command is set to status than current implementation is right.

I prefer that the usage statement lists one line per sub-command with the
flags that apply only to the sub-command. IOW, a usage statement that
suggests that a flag applies to all sub-commands when in reality it
doesn't is bogus, IMHO.

-- Hannes
