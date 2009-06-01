From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git log missing last line of output
Date: Mon, 1 Jun 2009 16:56:18 -0400
Message-ID: <DD9E6A72-B168-424E-8406-483B1F315088@silverinsanity.com>
References: <gvhrtf$vpr$1@ger.gmane.org> <4A1D5F70.4030101@drmicha.warpmail.net> <gvjsc9$f40$1@ger.gmane.org> <200905272106.31036.j6t@kdbg.org> <h01enr$71i$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 22:56:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBEYc-0001Hh-Vy
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 22:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbZFAU4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 16:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756457AbZFAU4T
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 16:56:19 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59921 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbZFAU4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 16:56:19 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 5929F1FFC07C; Mon,  1 Jun 2009 20:56:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.3] (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 1443E1FFC07A;
	Mon,  1 Jun 2009 20:56:13 +0000 (UTC)
In-Reply-To: <h01enr$71i$1@ger.gmane.org>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120481>


On Jun 1, 2009, at 4:50 PM, Neal Kreitzinger wrote:

> Git has the option '--no-pager' to overcome incompatibility issues.   
> Since I
> do not know if the pager is having problems with any commands  
> besides 'git
> log', I will focus on 'git log' only.  The command 'git --no-pager  
> log' can
> be executed in lieu of 'git log' to display the log correctly.  A  
> git alias
> can be setup to create a shorter command to accomplish this.  I've  
> created
> the command 'git logr' as a system alias on the git testbox so you  
> can use
> that command instead of 'git log'.  A system alias applies to all  
> logins and
> repos on the system.

You could also use the core.pager and/or pager.<cmd> configuration  
variables.  Setting either to "false" or "no" (or "off" in git >=  
1.6.3-rc1) will stop git from using the pager without needing an  
alias.  See git-config(1) (or Documentation/config.txt) for details.

~~ Brian
