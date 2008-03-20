From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: strange git delays
Date: Thu, 20 Mar 2008 15:05:26 +0100
Message-ID: <47E26F26.10301@viscovery.net>
References: <1206019968.27619.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: James Utter <james.utter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 15:06:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcLPF-0002AZ-QC
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 15:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbYCTOFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 10:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754980AbYCTOFa
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 10:05:30 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35874 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbYCTOF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 10:05:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JcLNl-0008O2-6y; Thu, 20 Mar 2008 15:04:37 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AA9F14E4; Thu, 20 Mar 2008 15:05:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1206019968.27619.26.camel@localhost>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77659>

James Utter schrieb:
> Many git operations are running really slowly for me.
> For example 'git commit' and 'git branch' are taking 10 seconds to
> complete, even on an almost empty repository, and no longer on a 60MB
> repository with plenty of history.
> 
> There does not appear to be any CPU or disk activity caused by git.

...

> james@timesink:~/testgit$ time git commit --message "initial commit"
> Created initial commit 4f4b3a3: initial commit
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 hello
> 
> real	0m10.008s
> user	0m0.000s
> sys	0m0.008s

What does

  strace -c git commit --message "initial commit"

report? 'strace -tt' or 'strace -T'?

-- Hannes
