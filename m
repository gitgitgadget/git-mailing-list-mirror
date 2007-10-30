From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] Build in some more things
Date: Tue, 30 Oct 2007 08:24:45 +0100
Message-ID: <4726DC3D.2030202@viscovery.net>
References: <Pine.LNX.4.64.0710292049450.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 08:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImlTB-0006C4-BK
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 08:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbXJ3HYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 03:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbXJ3HYt
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 03:24:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12233 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbXJ3HYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 03:24:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ImlSa-0005Te-8Y; Tue, 30 Oct 2007 08:24:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 818A3546; Tue, 30 Oct 2007 08:24:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0710292049450.7357@iabervon.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow schrieb:
> The main effect of this series is removing the fork/exec from pushing via 
> the git protocol (aside from the later fork/exec in connect.c of course).
> 
> It also heads off some tempting transport-related fetch bugs, which I will 
> not introduce in a later patch.
> 
> * Miscellaneous const changes and utilities
>   Adds two small utility functions, and marks a bunch of stuff as const; 
>   the const stuff is to keep builtin-fetch from getting messed up without 
>   a warning, because it wants some lists not to change.
> 
> * Build-in peek-remote, using transport infrastructure.
> * Build-in send-pack, with an API for other programs to call.
> * Use built-in send-pack.

I assume this goes on top of current master or db/fetch-pack. The patches 
have some conflicts with js/forkexec (nothing serious, though). Maybe it 
makes sense to rebase on top of that.

-- Hannes
