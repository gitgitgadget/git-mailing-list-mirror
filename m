From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Exclude a file from a pull =?utf-8?Q?request=E2=80=8F?=
Date: Wed, 07 Oct 2015 18:33:21 +0200
Message-ID: <87oaga8wq6.fsf@igel.home>
References: <88A9B78851BE8145A87C05C88FC3ED840101DEB1@bsrspdag001.boursorama.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Rudy YAYON <Rudy.YAYON.ext@boursorama.fr>
X-From: git-owner@vger.kernel.org Wed Oct 07 18:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjrej-0000SL-2T
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 18:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbbJGQdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 12:33:25 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51267 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbbJGQdY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 12:33:24 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3nWLnZ5PqPz3hjB6;
	Wed,  7 Oct 2015 18:33:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3nWLnZ4Cz2zvdWt;
	Wed,  7 Oct 2015 18:33:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id U931zYeWbIa8; Wed,  7 Oct 2015 18:33:21 +0200 (CEST)
X-Auth-Info: U/Ad+Dd612mO2LsOonJFGkZmUBRhMXdOGCnHzTnBSyQfrRlQMIOa26jqhkH9eVHh
Received: from igel.home (ppp-93-104-93-26.dynamic.mnet-online.de [93.104.93.26])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed,  7 Oct 2015 18:33:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 3A08E2C6DA1; Wed,  7 Oct 2015 18:33:21 +0200 (CEST)
X-Yow: I am a jelly donut.  I am a jelly donut.
In-Reply-To: <88A9B78851BE8145A87C05C88FC3ED840101DEB1@bsrspdag001.boursorama.fr>
	(Rudy YAYON's message of "Wed, 7 Oct 2015 15:55:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279183>

Rudy YAYON <Rudy.YAYON.ext@boursorama.fr> writes:

>   My concern is that one important file (Puppetfile) needs to be pushed to my remote repository so I can check the changes I commited.
>   To do that, I need to commit changes (included to the Puppetfile) then I need to push it to the remote repository.
>  
>   Once I want to merge these changes from a specific branch to the master branch, I do NOT want to include this file. In other words, I want to merge all files except the Puppetfile file.
>  
>   What is the best way for you to do that?

Create a branch that does not include the file.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
