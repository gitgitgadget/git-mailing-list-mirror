From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Bootstraper for Git Dev Environment for Windows (Light version)
Date: Thu, 16 Aug 2007 11:06:50 +0200
Organization: eudaptics software gmbh
Message-ID: <46C413AA.CE4C8ACF@eudaptics.com>
References: <2B8D8540264E4205BD1E4605770422BF@ntdev.corp.microsoft.com> <Pine.LNX.4.64.0708051252130.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org,
	Mike Pape <dotzenlabs@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 16 11:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILbJ1-00022A-GV
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 11:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbXHPJGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 05:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756136AbXHPJGM
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 05:06:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:49378 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbXHPJGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 05:06:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1ILbIu-0008Il-F6; Thu, 16 Aug 2007 11:06:08 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 11B9BFCD1; Thu, 16 Aug 2007 11:06:08 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.397, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55996>

Johannes Schindelin wrote:
> - I wanted to hold off a little, until Hannes can apply the fix-up patch
>   we need in mingw.git.  Because when he does, your bootstrap will run
>   into problems...
> 
> > If we want to stick with this installer here is what we need to do:
> > * Remove /git directory from msysGit.git
> > * Bring mingw.git up to date so we can remove patching step from installer
> 
> Sounds like a plan.  Hannes? (I know that Hannes was/is in holiday...)

I gladly accept patches or merge or cherry-pick from one of the repos
that have appeared recently.

BTW, I'm about to push a new mingw.git that is at v1.5.3-rc4. I'm only
waiting for the tests to complete (which takes an awful lot of time on
Windows).

-- Hannes
