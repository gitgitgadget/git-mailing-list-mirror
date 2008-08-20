From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: Local branch ahead of tracked remote branch but git push claims everything up-to-date
Date: Wed, 20 Aug 2008 22:40:46 +0200
Message-ID: <8585F10E-C33C-481E-B044-A7125F3316F2@web.de>
References: <1219263969579-736663.post@n2.nabble.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: ir0s <imirene@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuVW-0002x1-4p
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbYHTUlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbYHTUlO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:41:14 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:34542 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000AbYHTUlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:41:13 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6FF53E94B2F1;
	Wed, 20 Aug 2008 22:41:12 +0200 (CEST)
Received: from [91.18.72.146] (helo=[10.0.1.1])
	by smtp05.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KVuUR-0005t1-00; Wed, 20 Aug 2008 22:41:11 +0200
In-Reply-To: <1219263969579-736663.post@n2.nabble.com>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1+Hq6dpJTUmKBatlPhgzyy6Eqqo4IV1eCWS2+LK
	i/eBvfowll30fkV9crvhKb5h6mu9iLewG+9Gxm0C4UajPxY8GJ
	El6ohupxixSDtiW0kk5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93041>

Hello,

Am 20.08.2008 um 22:26 schrieb ir0s:

> $ git checkout mybranch
> Switched to branch "mybranch "
> Your branch is ahead of the tracked remote branch 'origin/ 
> remotebranch' by 4
> commits.
> mybranch
>
> Accurately, it has 4 commits that I haven't pushed yet. I try to  
> push them
> but I get the following:
> $ git push origin remotebranch
> Everything up-to-date
>
> Any ideas?

You need to name the local branch, not the remote one:

$ git push origin mybranch

It should then push to remotebranch.

HTH,
Andreas
