From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc7
Date: Wed, 29 Aug 2007 17:42:58 +0200
Message-ID: <46D59402.2060807@eudaptics.com>
References: <7vbqcqr6cz.fsf@gitster.siamese.dyndns.org> <46D57ECF.2050209@eudaptics.com> <Pine.LNX.4.64.0708291516020.28586@racer.site> <46D58C02.2070203@eudaptics.com> <Pine.LNX.4.64.0708291621120.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 29 17:44:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQPhr-0005o0-R9
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 17:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbXH2Pnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 11:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXH2Pnp
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 11:43:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37604 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbXH2Pnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 11:43:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IQPhn-0005pY-AA; Wed, 29 Aug 2007 17:43:43 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C056B6B7; Wed, 29 Aug 2007 17:43:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0708291621120.28586@racer.site>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.382, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56963>

Johannes Schindelin schrieb:
> To refresh my memory, could you please describe how mingw.git's master and 
> devel branches are handled?

'master' merges git.git's tagged releases, i.e. the 'maint' branch, but 
also the -rc series of a new feature release (like in the past weeks).

'devel' contains additional commits that make a "flawless" test suite, 
i.e. mostly disables tests that trigger bugs. This branch is always 
rebased onto of 'master'.

Originally 'devel' contained code changes without which MinGW git would 
have been unusable, but currently it really only disables tests that 
trigger exotic bugs[*] that I cannot fix right away and so is basically 
just for my own convenience. I could very well get rid of the branch - 
if only to raise the incentive for others to help fix the bugs. ;)

[*] bugs that I do not encounter in may daily workflow.

-- Hannes
